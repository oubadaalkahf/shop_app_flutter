import 'package:flutter/material.dart';

Widget defaultIconButton({
  required IconData icon,
  required String text,
}) =>
    IconButton(
      iconSize: 50,
      splashColor: Colors.red,
      icon: Icon(
        icon,
        color: Colors.red.shade900,
      ),
      onPressed: () {
        print(text);
      },
    );
