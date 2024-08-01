import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:formapplication/features/login/screens/login_screen.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: myText(
            text: getText("Who is Logging In", context),
            size: 22,
            fontWeight: FontWeight.bold,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            mySpacer(height: 50),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(isAdmin: false)));
                },
                icon: Icon(
                  Icons.person,
                  size: 60,
                  color: Color.fromARGB(255, 33, 151, 141),
                )),
            myText(
              text: getText("Employee", context),
              size: 18,
            ),
            mySpacer(height: 40),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen(isAdmin: true)));
                },
                icon: Icon(
                  Icons.house,
                  size: 60,
                  color: Color.fromARGB(255, 81, 44, 161),
                )),
            myText(
              text: getText("Admin", context),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
