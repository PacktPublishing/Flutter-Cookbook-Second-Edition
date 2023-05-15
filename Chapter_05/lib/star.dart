import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final Color color;
  final double size;

  const Star({required this.color, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _StarPainter(color),
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  final Color color;

  _StarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.618, size.height * 0.382)
      ..lineTo(size.width, size.height * 0.382)
      ..lineTo(size.width * 0.691, size.height * 0.618)
      ..lineTo(size.width * 0.809, size.height)
      ..lineTo(size.width * 0.5, size.height * 0.7639)
      ..lineTo(size.width * 0.191, size.height)
      ..lineTo(size.width * 0.309, size.height * 0.618)
      ..lineTo(size.width * 0.309, size.height * 0.618)
      ..lineTo(0, size.height * 0.382)
      ..lineTo(size.width * 0.382, size.height * 0.382)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class StarRating extends StatelessWidget {
  final Color color;
  final int value;
  final double starSize;

  const StarRating({
    super.key,
    required this.value,
    this.color = Colors.deepOrange,
    this.starSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        value,
        (_) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: Star(
            color: color,
            size: starSize,
          ),
        ),
      ),
    );
  }
}
