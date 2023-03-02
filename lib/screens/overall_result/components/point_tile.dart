import 'package:flutter/material.dart';

class PointTile extends StatelessWidget {
  const PointTile({
    super.key,
    required this.points,
  });
  final int points;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          points.toString(),
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
