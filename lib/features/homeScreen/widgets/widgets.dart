import 'package:flutter/material.dart';

import 'package:formapplication/coommon/common_widgets.dart';
import 'package:formapplication/features/homeScreen/bloc/form_bloc_bloc.dart';

List<BoxShadow> myShadow() => [
      const BoxShadow(
          color: Color.fromARGB(225, 228, 227, 227),
          blurRadius: 2,
          spreadRadius: 1,
          offset: Offset(-2, 2))
    ];

Container myTextField(
    {required hintText, required TextEditingController controller}) {
  return Container(
    padding: const EdgeInsets.only(top: 10, left: 22),
    height: 55,
    decoration: BoxDecoration(
        boxShadow: myShadow(),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    child: Center(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: const TextStyle(
                fontSize: 19, color: Color.fromARGB(255, 182, 182, 182))),
      ),
    ),
  );
}

SnackBar mySnackbar(FormValidationFailedState state) {
  return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: myText(text: state.message, size: 18),
      margin: const EdgeInsets.all(15));
}
