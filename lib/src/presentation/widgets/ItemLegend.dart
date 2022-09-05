import 'package:flutter/material.dart';

class ItemLegend extends StatelessWidget {
  final String text;
  final Color color;

  ItemLegend(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color,),
        Text(text)
      ],
    );
  }
}