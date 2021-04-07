import 'package:flutter/material.dart';
import 'package:flutter_catalog/ui/util/app_colors.dart';


class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [gradientColorStart, gradientColorEnd],
          ),
        ),
        child: child);
  }
}