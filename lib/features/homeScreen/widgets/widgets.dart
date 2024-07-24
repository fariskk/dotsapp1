import 'package:flutter/material.dart';

import 'package:formapplication/coommon/common_widgets.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:provider/provider.dart';

Container myTextField({
  required hintText,
  required TextEditingController controller,
  required BuildContext context,
  int? minLines,
  int? maxLines,
}) {
  return Container(
    height: 55,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20))),
    child: Center(
      child: TextField(
        style: const TextStyle(fontSize: 18),
        controller: controller,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: const OutlineInputBorder(),
            hintText: getText(hintText, context),
            labelText: getText(hintText, context),
            border: const OutlineInputBorder(),
            labelStyle: const TextStyle(fontSize: 18, color: Colors.grey),
            hintStyle: const TextStyle(fontSize: 18, color: Colors.grey)),
      ),
    ),
  );
}

void mySnackbar(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: myText(text: text, size: 18),
      margin: const EdgeInsets.all(15)));
}

List<Widget> myTabs(BuildContext context) {
  final provider = Provider.of<HomeScreenProvider>(context);
  return [
    GestureDetector(
      onTap: () {
        if (provider.radioResult != "individual") {
          provider.clearForm();
        }
        provider.radioResult = "individual";

        provider.rebuild();
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            color: provider.radioResult == "individual"
                ? Colors.white
                : Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: myText(
              text: "Individual",
              size: 18,
              color: provider.radioResult == "individual"
                  ? Theme.of(context).primaryColor
                  : Colors.white,
            )),
      ),
    ),
    GestureDetector(
      onTap: () {
        if (provider.radioResult != "on behalf") {
          provider.clearForm();
        }
        provider.radioResult = "on behalf";

        provider.rebuild();
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 5),
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            color: provider.radioResult == "individual"
                ? Theme.of(context).primaryColor
                : Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: myText(
              text: "On Behalf Of",
              size: 18,
              color: provider.radioResult == "individual"
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            )),
      ),
    ),
  ];
}
