import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imag_in/core/utils/enums/consumer_state.dart';
import 'package:imag_in/core/widgets/consumer_state_widget.dart';
import 'package:imag_in/features/photo/models/photo.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({required this.photo, super.key});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: photo.isLocal
                ? ExtendedImage.file(
                    File(photo.localPath!),
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (_) => GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 3,
                      animationMaxScale: 3.5,
                    ),
                  )
                : ExtendedImage.network(
                    photo.downloadUrl,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (_) => GestureConfig(
                      minScale: 0.9,
                      animationMinScale: 0.7,
                      maxScale: 3,
                      animationMaxScale: 3.5,
                    ),
                    loadStateChanged: (state) {
                      if (state.extendedImageLoadState == LoadState.loading) {
                        return const Center(
                          child: ConsumerStateWidget(
                            ConsumerState.loading,
                            title: 'Loading image...',
                          ),
                        );
                      }

                      return null;
                    },
                  ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 48, 16, 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
              child: Text(
                photo.author,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
