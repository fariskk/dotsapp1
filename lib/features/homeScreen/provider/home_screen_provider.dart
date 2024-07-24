import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:formapplication/features/homeScreen/screens/success_screen.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';

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

  void submit(BuildContext context) {
    {
      if (radioResult == "on behalf" && behalfController.text == "") {
        mySnackbar("Please Fill the Name of Person", context);
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
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SuccessScreen()));
      }
    }
  }

  void clearForm() {
    radioResult = "individual";
    dropdownSerchFielHint = "-Select Requset Type-";
    requestType = null;
    date = null;
    file = null;
    behalfController.clear();
    subFeild1Controller.clear();
    subFeild2Controller.clear();
    purposeController.clear();
    reQuestTypeController.clear();
    remarksController.clear();
    notifyListeners();
  }
}
