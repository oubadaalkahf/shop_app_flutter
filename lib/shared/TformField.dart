import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget newDefaultText({
  required keyboardType,
  required TextEditingController? controller,
  required bool isObsecure,
  required String submitText,
  bool isPassword = false,
  required String text,
  required IconData? prefix,
  Function? suffixPressed,
  IconData? suffix,
}) =>
    TextFormField(
      obscureText: isObsecure,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            suffixPressed!();
          },
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return submitText;
        }

        return null;
      },
    );
