import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/adminScreen/provider/admin_provider.dart';
import 'package:formapplication/features/adminScreen/widgets/admin_widgets.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:formapplication/features/login/screens/landing_screen.dart';
import 'package:formapplication/features/myRequestsScreen/widgets/my_requsts_widgets.dart';
import 'package:formapplication/models/request_model.dart';
import 'package:formapplication/utils/pdf_genarator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
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
        backgroundColor: Theme.of(context).primaryColor,
        title: myText(text: "Requests", size: 20, color: Colors.white),
        actions: [
          // popup menu button
          myPopUpmenubutton(Provider.of<HomeScreenProvider>(context)),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("requests").snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            List listData = data.docs;
            listData = listData.reversed.toList();
            return ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  RequestModel request =
                      RequestModel.fromJson(listData[index].data());
                  return Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        myText(
                            text: request.requestType,
                            size: 20,
                            fontWeight: FontWeight.bold),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(
                              text: getText("Requested By", context),
                              size: 18,
                            ),
                            myText(
                              text: request.requestedBy,
                              size: 18,
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(
                                text: getText("Requested For", context),
                                size: 18),
                            myText(
                              text: request.requestdFor,
                              size: 18,
                            )
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(text: getText("Status", context), size: 18),
                            myText(
                                text: request.status,
                                size: 18,
                                color: getColordText(request.status))
                          ],
                        ),
                        Visibility(
                          child: Column(
                            children: [
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(
                                      text: getText("Amount", context),
                                      size: 18),
                                  myText(
                                    text: "\$${request.amount}",
                                    size: 18,
                                  )
                                ],
                              ),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  myText(
                                      text: getText("Account Number", context),
                                      size: 18),
                                  myText(
                                    text: request.acountNumber,
                                    size: 18,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(
                                text: getText("Requried Date", context),
                                size: 18),
                            myText(
                                text:
                                    "${request.requestedDate.day}/${request.requestedDate.month}/${request.requestedDate.year}",
                                size: 18)
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(
                                text: getText("Requested Date", context),
                                size: 18),
                            myText(
                                text:
                                    "${request.requestedDate.day}/${request.requestedDate.month}/${request.requestedDate.year}",
                                size: 18)
                          ],
                        ),
                        const Divider(),
                        if (request.requestType == "Docment Request")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myText(
                                  text: getText("Requested Document", context),
                                  size: 18),
                              myText(text: request.documentName, size: 18)
                            ],
                          ),
                        Row(
                          children: [
                            myText(
                                text: getText("Purpose", context),
                                size: 20,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: myText(text: request.purpose, size: 18)),
                        Row(
                          children: [
                            myText(
                                text: getText("Remarks", context),
                                size: 20,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Text(
                              request.remarks,
                              style: GoogleFonts.workSans(fontSize: 18),
                            )),
                        MaterialButton(
                          onPressed: () {},
                          color: Theme.of(context).primaryColor,
                          minWidth: double.infinity,
                          child: myText(
                              text: getText("Download Attached Files", context),
                              size: 17,
                              color: Colors.white),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                Provider.of<AdminProvider>(context,
                                        listen: false)
                                    .reject(request);
                              },
                              color: Theme.of(context).primaryColor,
                              minWidth:
                                  MediaQuery.of(context).size.width / 2 - 50,
                              child: myText(
                                  text: getText("Reject", context),
                                  size: 17,
                                  color: Colors.white),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                Provider.of<AdminProvider>(context,
                                        listen: false)
                                    .approve(request);
                                String reqDate =
                                    "${request.requestedDate.day}-${getMountText(request.requestedDate.month)}-${request.requestedDate.year}";

                                if (request.requestType ==
                                    "Resignation Letter") {
                                  File file =
                                      await PdfGenarator.genarateResignationPdf(
                                          reqDate, request.requestdFor);
                                  openFileSnackbar(context, file);
                                } else if (request.requestType ==
                                    "Salary Transfer") {
                                  File file = await PdfGenarator
                                      .genarateSalaryTransferPdf(
                                          reqDate, request);
                                  openFileSnackbar(context, file);
                                }
                              },
                              color: Colors.green,
                              minWidth:
                                  MediaQuery.of(context).size.width / 2 - 50,
                              child: myText(
                                  text: getText("Approve", context),
                                  size: 17,
                                  color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

String getMountText(String monunt) {
  switch (monunt) {
    case "1":
      return "January";
    case "2":
      return "February";
    case "3":
      return "March";
    case "4":
      return "April";
    case "5":
      return "May";
    case "6":
      return "June";
    case "7":
      return "July";
    case "8":
      return "August";
    case "9":
      return "September";
    case "10":
      return "October";
    case "11":
      return "November";
    case "12":
      return "December";
  }
  return "";
}
