import 'package:flutter/material.dart';

PreferredSizeWidget appBar(String text, Color backgroundColor, Color foregroundColor) {
  return AppBar(
    title: Text(text, style: TextStyle(),),
    centerTitle: true,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
  );
}
