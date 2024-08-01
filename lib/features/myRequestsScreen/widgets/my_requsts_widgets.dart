import 'package:flutter/material.dart';
import 'package:formapplication/coommon/common.dart';
import 'package:formapplication/features/myRequestsScreen/screnns/request_details_screen.dart';
import 'package:formapplication/models/request_model.dart';

InkWell adminPanelButton(BuildContext context, String text) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(7),
      height: 40,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: myText(
          text: text,
          size: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Container myTile(BuildContext context, RequestModel details) {
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.all(5),
    height: 100,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.token,
          size: 40,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 180, child: myText(text: details.requestType, size: 20)),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                myText(text: "Status : ", size: 16, color: Colors.grey),
                myText(
                    text: details.status,
                    size: 15,
                    color: getColordText(details.status)),
              ],
            )
          ],
        ),
        TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RequestDetailsScreen(
                            details: details,
                          )));
            },
            child: const Text("View Details"))
      ],
    ),
  );
}

Color getColordText(String colorText) {
  switch (colorText) {
    case "approved":
      return Colors.green;
    case "rejected":
      return Colors.red;
    case "requested":
      return Colors.blue;
  }
  return Colors.black;
}
