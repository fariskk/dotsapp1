import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<String> dropitems = [
    "Leave Application",
    "Docment Request",
    "Accound Opening-Bank Letter",
    "Resignation Letter",
  ];
  String radioResult = "individual";
  String dropdownSerchFielHint = "-Select Requset Type-";
  String? requestType;
  DateTime? date;
  FilePickerResult? file;
  TextEditingController behalfController = TextEditingController();
  TextEditingController reQuestTypeController = TextEditingController();
  TextEditingController subFeild1Controller = TextEditingController();
  TextEditingController subFeild2Controller = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  void rebuild() {
    notifyListeners();
  }
}
