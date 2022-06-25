import 'package:flutter/material.dart';
import 'package:project/utility/colors.dart';

class BigText extends StatelessWidget {
  String text;
  double? size;
  Color? color;
  BigText({required this.text, this.size = 16, this.color = appColors.black});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        fontFamily: "Roboto",
          fontWeight: FontWeight.w600,
          fontSize: size,
          color: color
      ),
    );
  }
}