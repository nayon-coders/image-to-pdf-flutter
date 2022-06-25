import 'package:flutter/material.dart';
import 'package:project/utility/colors.dart';

class MediunText extends StatelessWidget {
  String text;
  double? size;
  Color ? color;
  MediunText({required this.text, this.size = 13, this.color = appColors.black});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          fontSize: size,
          color: color
      ),
    );
  }
}