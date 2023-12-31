import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    required this.icon,
    required this.color,
}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16,
      ),
    );
  }


}