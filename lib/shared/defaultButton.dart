import 'package:flutter/material.dart';

import 'colors.dart';

Widget defaultButton({
  required String text,
  required Function function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: defaultColor,
      ),
      width: double.infinity,
      child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          )),
    );
