// Desenvolvido por: Vinicius Montuani e Pietro Rennó

import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const GlassBox({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final defaultRadius = BorderRadius.circular(15);
    
    return ClipRRect(
      borderRadius: borderRadius ?? defaultRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: width,
          height: height,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade900.withValues(alpha: 0.6), // Mais cinza e mais opaco
            borderRadius: borderRadius ?? defaultRadius,
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2), // Borda mais visível
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
