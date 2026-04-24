import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imag_in/core/utils/enums/consumer_state.dart';
import 'package:imag_in/core/utils/extensions/context_extensions.dart';
import 'package:imag_in/core/widgets/consumer_state_widget.dart';
import 'package:imag_in/features/authentication/dialogs/logout_dialog.dart';
import 'package:imag_in/features/gallery/services/gallery_provider.dart';
import 'package:imag_in/features/photo/widgets/photo_thumbnail.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final gallery = context.read<GalleryProvider>();
      if (gallery.photos.isEmpty) {
        await gallery.fetchFirstPage();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      unawaited(context.read<GalleryProvider>().loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GalleryProvider>(
        builder: (context, gallery, _) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: Colors.teal,
                centerTitle: true,
                title: Text(
                  'Gallery',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () => LogoutDialog.show(context: context),
                    icon: const FaIcon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              if (gallery.state == ConsumerState.loading &&
                  gallery.photos.isEmpty)
                const SliverFillRemaining(
                  child: Center(
                    child: ConsumerStateWidget(
                      ConsumerState.loading,
                      isAccentColor: true,
                    ),
                  ),
                )
              else if (gallery.state == ConsumerState.error)
                const SliverFillRemaining(
                  child: Center(
                    child: ConsumerStateWidget(
                      ConsumerState.error,
                      errorMessage: 'Failed to load images',
                      isAccentColor: true,
                    ),
                  ),
                )
              else ...[
                SliverPadding(
                  padding: const EdgeInsets.all(2),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          PhotoThumbnail(photo: gallery.photos[index]),
                      childCount: gallery.photos.length,
                    ),
                  ),
                ),
                if (gallery.hasMore)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 32, bottom: 96),
                      child: ConsumerStateWidget(
                        ConsumerState.loading,
                        title: 'Loading more images...',
                        isAccentColor: true,
                      ),
                    ),
                  ),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        icon: const FaIcon(FontAwesomeIcons.plus),
        label: const Text('Add Photo'),
        onPressed: () async =>
            await context.read<GalleryProvider>().pickAndAddPhoto(),
      ),
    );
  }
}
