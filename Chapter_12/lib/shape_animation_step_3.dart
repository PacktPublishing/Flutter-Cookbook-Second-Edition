import 'package:flutter/material.dart';

class ShapeAnimation extends StatefulWidget {
  const ShapeAnimation({super.key});

  @override
  State<ShapeAnimation> createState() => _ShapeAnimationState();
}

class _ShapeAnimationState extends State<ShapeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double posTop = 0;
  double posLeft = 0;
  double maxTop = 0;
  double maxLeft = 0;
  final int ballSize = 100;

  late Animation<double> animation;
  late Animation<double> animationTop;
  late Animation<double> animationLeft;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
    animation.addListener(() {
      moveBall();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Animation Controller'),
          actions: [
            IconButton(
              onPressed: () {
                controller.reset();
                controller.forward();
              },
              icon: const Icon(Icons.run_circle),
            )
          ],
        ),
        body: SafeArea(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            maxLeft = constraints.maxWidth - ballSize;
            maxTop = constraints.maxHeight - ballSize;
            return Stack(
              children: [
                Positioned(left: posLeft, top: posTop, child: const Ball()),
              ],
            );
          },
        )));
  }

  void moveBall() {
    setState(() {
      posTop = animation.value * maxTop;
      posLeft = animation.value * maxLeft;
    });
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration:
          const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
    );
  }
}
