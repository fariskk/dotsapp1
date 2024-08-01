import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:formapplication/features/homeScreen/screens/success_screen.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:formapplication/models/request_model.dart';

class HomeScreenProvider extends ChangeNotifier {
  String myName = "muhammed faris kk";
  Locale language = const Locale("en");
  List<String> dropitems = [
    "Leave Application",
    "Docment Request",
    "Accound Opening-Bank Letter",
    "Resignation Letter",
  ];
  List<String> employees = [
    "Shukur kk",
    "Fasal",
    "Farhana Sherin",
    "Safiyya",
    "muhammed faris kk"
  ];
  String? selectedEmployees;
  String radioResult = "individual";
  String dropdownSerchFielHint = "-Select Requset Type-";
  String? requestType;
  DateTime? date;
  FilePickerResult? file;
  bool isLoading = false;
  TextEditingController reQuestTypeController = TextEditingController();
  TextEditingController subFeild1Controller = TextEditingController();
  TextEditingController subFeild2Controller = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  void rebuild() {
    notifyListeners();
  }

  void submit(BuildContext context) {
    {
      if (radioResult == "on behalf" && selectedEmployees == null) {
        mySnackbar("Please Select a Employee", context);
      } else if (requestType == null) {
        mySnackbar("Select Your request type", context);
      } else if (subFeild1Controller.text == "" &&
          (requestType == "Docment Request" ||
              requestType == "Accound Opening-Bank Letter")) {
        if (requestType == "Docment Request") {
          mySnackbar("Please fill Document Name", context);
        } else {
          mySnackbar("Please fill Name of Institution", context);
        }
      } else if (subFeild2Controller.text == "" &&
          requestType == "Accound Opening-Bank Letter") {
        mySnackbar("Please fill Address of Institution", context);
      } else if (date == null) {
        mySnackbar("Select Your Required Date", context);
      } else if (purposeController.text == "") {
        mySnackbar("Please fill your Purpose", context);
      } else {
        submitForm(context);
      }
    }
  }

  void submitForm(BuildContext context) async {
    isLoading = true;
    rebuild();
    final fir = FirebaseFirestore.instance
        .collection(radioResult == "individual" ? myName : selectedEmployees!);

    List fileUrls = [];
    final storage = FirebaseStorage.instance.ref(
        "files/${radioResult == "individual" ? myName : selectedEmployees}");
    if (file != null) {
      for (var fileToUpload in file!.files) {
        await storage
            .child(fileToUpload.name)
            .putFile(File(fileToUpload.path!));
        fileUrls.add({
          "name": fileToUpload.name,
          "url": await storage.child(fileToUpload.name).getDownloadURL()
        });
      }
    }
    final now = DateTime.now();
    String docId = now.toString();
    Map<String, dynamic> dataToStore = RequestModel(
            requestId: docId,
            requestedBy: myName,
            requestdFor:
                radioResult == "individual" ? myName : selectedEmployees!,
            requestType: requestType!,
            date: Date(
                day: date!.day.toString(),
                month: date!.month.toString(),
                year: date!.year.toString()),
            purpose: purposeController.text,
            files: fileUrls,
            remarks: remarksController.text,
            documentName: requestType == "Docment Request"
                ? subFeild1Controller.text
                : "",
            nameOfTheInstitution: subFeild1Controller.text,
            addressOfTheInstitution: subFeild2Controller.text,
            status: "requested",
            requestedDate: RequestedDate(
                day: now.day.toString(),
                month: now.month.toString(),
                year: now.year.toString()))
        .toJson();
    fir.doc(docId).set(dataToStore);
    final requests = FirebaseFirestore.instance.collection("requests");
    AggregateQuerySnapshot query = await requests.count().get();

    requests.doc(docId).set(dataToStore);
    isLoading = false;
    rebuild();
    // ignore: use_build_context_synchronously
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()));
  }

  void clearForm() {
    radioResult = "individual";
    dropdownSerchFielHint = "-Select Requset Type-";
    requestType = null;
    date = null;
    file = null;
    selectedEmployees = null;
    subFeild1Controller.clear();
    subFeild2Controller.clear();
    purposeController.clear();
    reQuestTypeController.clear();
    remarksController.clear();
    notifyListeners();
  }
}
