import 'package:flutter/material.dart';

class ShadowBox extends StatelessWidget {
  const ShadowBox({
    required this.child,
    this.isLightShadow = false,
    this.isCircular = false,
    super.key,
  });

  final Widget child;
  final bool isLightShadow;
  final bool isCircular;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircular ? null : BorderRadius.circular(16),
        boxShadow: isLightShadow ? boxLightShadow : boxShadow,
      ),
      child: child,
    );
  }
}

final boxShadow = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.3),
    blurRadius: 20,
    offset: const Offset(0, 2),
  ),
];

final boxLightShadow = [
  BoxShadow(
    color: Colors.black.withValues(alpha: 0.1),
    blurRadius: 20,
    offset: const Offset(0, 2),
  ),
];
