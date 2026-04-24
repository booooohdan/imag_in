import 'package:flutter/material.dart';
import 'package:imag_in/core/utils/enums/consumer_state.dart';
import 'package:imag_in/core/utils/extensions/context_extensions.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ConsumerStateWidget extends StatelessWidget {
  const ConsumerStateWidget(
    this.consumerState, {
    this.title,
    this.emptyMessage,
    this.errorMessage,
    this.isAccentColor = false,
    super.key,
  });

  final ConsumerState consumerState;
  final String? title;
  final String? emptyMessage;
  final String? errorMessage;
  final bool isAccentColor;

  @override
  Widget build(BuildContext context) {
    switch (consumerState) {
      case ConsumerState.loading:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.threeArchedCircle(
              color: isAccentColor ? Colors.teal : Colors.white,
              size: 48,
            ),
            const SizedBox(height: 16, width: double.maxFinite),
            Text(
              title ?? 'Loading...',
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: isAccentColor ? Colors.teal : Colors.white,
              ),
            ),
          ],
        );
      case ConsumerState.error:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.report_outlined, color: Colors.red[800], size: 48),
            const SizedBox(height: 16, width: double.infinity),
            Text(
              errorMessage ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        );
      case ConsumerState.success:
        return const SizedBox();
    }
  }
}
