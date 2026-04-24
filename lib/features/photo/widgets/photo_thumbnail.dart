import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imag_in/core/router/routes.dart';
import 'package:imag_in/features/photo/models/photo.dart';
import 'package:shimmer/shimmer.dart';

class PhotoThumbnail extends StatelessWidget {
  const PhotoThumbnail({required this.photo, super.key});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/${Routes.photo.route}', extra: photo),
      child: photo.isLocal
          ? Image.file(File(photo.localPath!), fit: BoxFit.cover)
          : ExtendedImage.network(
              photo.thumbnailUrl,
              fit: BoxFit.cover,
              loadStateChanged: (state) {
                if (state.extendedImageLoadState == LoadState.loading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(color: Colors.white),
                  );
                }

                return null;
              },
            ),
    );
  }
}
