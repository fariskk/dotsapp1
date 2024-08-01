import 'package:flutter/material.dart';
import 'package:formapplication/features/adminScreen/screens/admin_screen.dart';
import 'package:formapplication/features/homeScreen/screens/home_screen.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:formapplication/features/myRequestsScreen/screnns/my_requests_screen.dart';

class LoginProvider extends ChangeNotifier {
  String adminUserName = "admin";
  String adminPassword = "123456789";
  String employeeUserName = "employee";
  String employeePassword = "123456789";

  void login(
      String userName, String password, bool isAdmin, BuildContext context) {
    if (userName.isEmpty) {
      mySnackbar("Please Provide a Username", context);
    } else if (password.isEmpty) {
      mySnackbar("Please Provide a Password", context);
    } else if (isAdmin &&
        (userName == adminUserName && password == adminPassword)) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AdminScreen()),
          (route) => false);
    } else if ((!isAdmin) &&
        (userName == employeeUserName && password == employeePassword)) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MyRequestsScreen()),
          (route) => false);
    } else {
      mySnackbar("Incurrect Username or password", context);
    }
  }
}
