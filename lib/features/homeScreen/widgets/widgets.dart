import 'package:flutter/material.dart';

import 'package:formapplication/coommon/common_widgets.dart';
import 'package:formapplication/features/homeScreen/bloc/form_bloc_bloc.dart';

Container myTextField(
    {required hintText, required TextEditingController controller}) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20))),
    child: Center(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: OutlineInputBorder(),
            hintText: hintText,
            labelText: hintText,
            border: OutlineInputBorder(),
            labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey)),
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
