import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_app/size_config.dart';

class BlurImage extends StatelessWidget {
  const BlurImage({
    Key key,
    @required this.url,
    @required this.sigmaX,
    @required this.sigmaY,
  }) : super(key: key);

  final String url;
  final double sigmaX, sigmaY;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth <= 425
          ? getProportionateScreenHeight(300)
          : SizeConfig.screenWidth >= 1024
              ? getProportionateScreenHeight(300)
              : SizeConfig.screenWidth <= 768
                  ? getProportionateScreenHeight(200)
                  : getProportionateScreenHeight(500),
      width: SizeConfig.screenWidth >= 1024
          ? getProportionateScreenWidth(200)
          : getProportionateScreenWidth(300),
      decoration: BoxDecoration(
        border: Border.all(
          width: 8,
          color: Colors.white,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          image: new DecorationImage(
            image: NetworkImage(
              url,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: sigmaX,
            sigmaY: sigmaY,
          ),
          child: Container(
            decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
    );
  }
}
