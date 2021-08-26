import 'dart:math' as math;
import 'package:flutter/material.dart';

class BuuttiLogo extends StatelessWidget {
  const BuuttiLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const LogoImage(
                asset: "assets/images/buutti_logo.png",
              ),
              Positioned(
                top: -28,
                left: -9,
                // right: 200,
                child: Transform.rotate(
                  angle: -math.pi / 6,
                  child: const LogoImage(
                    height: 90,
                    width: 90,
                    asset: "assets/images/chef_hat_t.png",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  final String asset;
  final double height;
  final double width;
  const LogoImage({
    Key? key,
    required this.asset,
    this.height = 120,
    this.width = 120,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(asset),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
