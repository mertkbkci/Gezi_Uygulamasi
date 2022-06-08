import 'package:flutter/material.dart';

class PanelBody extends StatelessWidget {
  const PanelBody({
    Key? key,
    required this.radius,
  }) : super(key: key);

  final BorderRadiusGeometry radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.teal, borderRadius: radius),
      child: Center(
        child: Text(
          "or Sign Up (up arrow icon)",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
