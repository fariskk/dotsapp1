import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:formapplication/features/homeScreen/widgets/widgets.dart';
import 'package:formapplication/features/myRequestsScreen/widgets/my_requsts_widgets.dart';
import 'package:formapplication/models/request_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RequestDetailsScreen extends StatelessWidget {
  RequestModel details;
  RequestDetailsScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 236),
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
        title: myText(text: "Request Details", size: 20, color: Colors.white),
        actions: [
          // popup menu button
          myPopUpmenubutton(Provider.of<HomeScreenProvider>(context)),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(
                      text: details.requestType,
                      size: 20,
                      fontWeight: FontWeight.bold),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(
                          text: getText("Requested Date", context), size: 18),
                      myText(
                          text:
                              "${details.requestedDate.day}/${details.requestedDate.month}/${details.requestedDate.year}",
                          size: 18)
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(text: getText("Status", context), size: 18),
                      myText(
                          text: details.status,
                          size: 18,
                          color: getColordText(details.status))
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(
                        text: getText("Requested By", context),
                        size: 18,
                      ),
                      myText(
                        text: details.requestedBy,
                        size: 18,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(text: getText("Requested For", context), size: 18),
                      myText(
                        text: details.requestdFor,
                        size: 18,
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      myText(text: getText("Requried Date", context), size: 18),
                      myText(
                          text:
                              "${details.requestedDate.day}/${details.requestedDate.month}/${details.requestedDate.year}",
                          size: 18)
                    ],
                  ),
                  Visibility(
                      visible: details.requestType == "Docment Request",
                      child: Column(
                        children: [
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              myText(
                                  text: getText("Requested Document", context),
                                  size: 18),
                              myText(text: details.documentName, size: 18)
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(
                      text: getText("Purpose", context),
                      size: 20,
                      fontWeight: FontWeight.bold),
                  myText(text: details.purpose, size: 18),
                  myText(
                      text: getText("Remarks", context),
                      size: 20,
                      fontWeight: FontWeight.bold),
                  Text(details.remarks,
                      style: GoogleFonts.workSans(fontSize: 18)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(text: "Files", size: 20, fontWeight: FontWeight.bold),
                  SizedBox(
                      height: details.files.length * 30,
                      child: ListView.builder(
                          itemCount: details.files.length,
                          itemBuilder: (context, index) {
                            return myText(
                                text: details.files[index]["name"], size: 17);
                          })),
                  Visibility(
                      visible: details.files.isEmpty,
                      child: myText(text: "No files", size: 18))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
