import 'dart:math' as math;
import 'package:flutter/material.dart';

class BuuttiLogoAnimated extends StatefulWidget {
  const BuuttiLogoAnimated({Key? key}) : super(key: key);

  @override
  _BuuttiLogoAnimatedState createState() => _BuuttiLogoAnimatedState();
}

class _BuuttiLogoAnimatedState extends State<BuuttiLogoAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      lowerBound: .54,
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addListener(() {
        this.setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: const Center(
        child: BuuttiLogo(
          height: 190,
          width: 190,
        ),
      ),
    );
  }
}

class BuuttiLogo extends StatelessWidget {
  final double height;
  final double width;
  const BuuttiLogo({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              LogoImage(
                width: width,
                height: height,
                asset: "assets/images/buutti_logo.png",
              ),
              Positioned(
                top: -48,
                left: -9,
                child: Transform.rotate(
                  angle: -math.pi / 6,
                  child: LogoImage(
                    height: height * 3 / 4,
                    width: width * 3 / 4,
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
