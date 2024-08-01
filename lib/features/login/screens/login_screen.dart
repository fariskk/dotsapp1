import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/screens/home_screen.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:formapplication/features/login/screens/provider/login_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  bool isAdmin;
  LoginScreen({required this.isAdmin, super.key});
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: myText(
            text:
                getText("Login As ${isAdmin ? "Admin" : "Employee"}", context),
            size: 20,
            color: Colors.white),
        actions: [
          myPopUpmenubutton(Provider.of<HomeScreenProvider>(context)),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      body: Center(
        child: Consumer<LoginProvider>(builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.width - 150,
            width: MediaQuery.of(context).size.width - 100,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myTextField(
                    hintText: "User Name",
                    controller: userNameController,
                    context: context),
                myTextField(
                    hintText: "Password",
                    controller: passwordController,
                    context: context),
                MaterialButton(
                  onPressed: () {
                    provider.login(userNameController.text,
                        passwordController.text, isAdmin, context);
                  },
                  color: Theme.of(context).primaryColor,
                  minWidth: MediaQuery.of(context).size.width - 120,
                  child: myText(
                      text: getText("Login", context),
                      size: 17,
                      color: Colors.white),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
