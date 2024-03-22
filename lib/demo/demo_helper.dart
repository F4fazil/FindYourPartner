import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import '../start_screens/startScreen.dart';

enum DemoType {
  custom,
  gif,
  fadeIn,
  scale,
  dynamicNextScreenFadeIn,
  usingBackgroundImage,
  usingGradient,
  lottieAnimation,
}

// ignore: must_be_immutable
class DemoHelper extends StatefulWidget {
  DemoHelper({super.key, required this.demoType});

  DemoType demoType;

  @override
  State<DemoHelper> createState() => _DemoHelperState();
}

class _DemoHelperState extends State<DemoHelper> {
  @override
  Widget build(BuildContext context) {
    switch (widget.demoType) {
      case DemoType.gif:
        return FlutterSplashScreen.gif(
          useImmersiveMode: true,
          gifPath: 'data/splash_screen/example.gif',
          gifWidth: 269,
          gifHeight: 474,
          nextScreen: const StartScreen(),
          duration: const Duration(seconds: 3),
          onInit: () async {
            debugPrint("onInit 1");
            await Future.delayed(const Duration(milliseconds: 2000));
            debugPrint("onInit 2");
          },
          onEnd: () async {
            debugPrint("onEnd 1");
            debugPrint("onEnd 2");
          },
        );
      default:
        return Container();
    }
  }
}