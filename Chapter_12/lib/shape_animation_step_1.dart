import 'package:flutter/material.dart';

class ShapeAnimation extends StatefulWidget {
  const ShapeAnimation({super.key});

  @override
  State<ShapeAnimation> createState() => _ShapeAnimationState();
}

class _ShapeAnimationState extends State<ShapeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  double pos = 0;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 200).animate(controller)
      ..addListener(() {
        moveBall();
      });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    animation.removeListener(() {});
    super.dispose();
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
      body: Stack(
        children: [
          Positioned(left: pos, top: pos, child: const Ball()),
        ],
      ),
    );
  }

  void moveBall() {
    setState(() {
      pos = animation.value;
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
