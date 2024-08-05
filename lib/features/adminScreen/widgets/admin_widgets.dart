import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:open_file/open_file.dart';

void openFileSnackbar(BuildContext context, File file) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      margin: const EdgeInsets.all(10),
      content: SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myText(text: "PDF Genarated successfully", size: 16),
            ElevatedButton(
                onPressed: () {
                  OpenFile.open(file.path);
                },
                child: const Text("Open"))
          ],
        ),
      )));
}
