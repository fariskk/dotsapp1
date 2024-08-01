import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/homeScreen/screens/home_screen.dart';
import 'package:formapplication/features/login/screens/landing_screen.dart';
import 'package:formapplication/features/myRequestsScreen/provider/my_request_screen_provider.dart';
import 'package:formapplication/features/myRequestsScreen/widgets/my_requsts_widgets.dart';
import 'package:formapplication/models/request_model.dart';
import 'package:provider/provider.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LandingScreen()),
                (route) => false);
          },
        ),
        title: myText(text: "My Requests", size: 20, color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  mySpacer(width: 5),
                  myText(
                      text: "Add Request",
                      color: Colors.white,
                      size: 16,
                      fontWeight: FontWeight.bold)
                ],
              ))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(Provider.of<MyRequestProvider>(context).myName)
                .snapshots(),
            builder: (context, AsyncSnapshot Snapshot) {
              if (Snapshot.hasData) {
                List data = Snapshot.data.docs;
                data = data.reversed.toList();
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, Index) {
                      final request = data[Index];

                      return myTile(
                          context, RequestModel.fromJson(request.data()));
                    });
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
