import 'dart:ui';

import 'package:flutter/material.dart';

class SplashImage extends StatelessWidget {
  const SplashImage({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(imagePath),
        Opacity(
            child: Image.asset(imagePath, color: Colors.black), opacity: 0.2),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
      ],
    );
  }
}
