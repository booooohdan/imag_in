import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imag_in/core/services/app_status_provider.dart';
import 'package:imag_in/core/utils/extensions/context_extensions.dart';
import 'package:provider/provider.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  static Future<void> show({required BuildContext context}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        insetPadding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 24,
            children: [
              Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium?.copyWith(
                  color: Colors.teal,
                ),
              ),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        context.pop();
                        await context.read<AppStatusProvider>().logout();
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('No'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
