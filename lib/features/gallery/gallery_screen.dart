import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imag_in/core/services/app_status_provider.dart';
import 'package:imag_in/features/authentication/screens/logout_dialog.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async => await LogoutDialog.show(context: context),
            icon: const FaIcon(FontAwesomeIcons.rightFromBracket),
          ),
        ],
      ),
      body: const Column(children: [Placeholder()]),
    );
  }
}
