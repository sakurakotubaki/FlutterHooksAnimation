import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_animaition/gen/assets.gen.dart';

class NextPage extends HookWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 画像がくるくる回るアニメーションを制御するためのuseAnimationController
    final controller = useAnimationController(
      duration: const Duration(seconds: 3),
      vsync: useSingleTickerProvider(),
    )..repeat();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: controller, // AnimationControllerを渡す。
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
            child: Center(
              child: Column(
                children: [
                  Assets.images.orechan.image(
                    width: 100,
                    height: 100,
                  ),
                  const Text('くるくる回っちゃうもんね〜'),
                ],
              ),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            // Transform.rotateで回転させる。
            return Transform.rotate(
              angle: controller.value * 2.0 * math.pi,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
