import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:formapplication/models/request_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfGenarator {
  static genarateResignationPdf(
      String requestedDate, String requestedFor) async {
    String img1 =
        "https://media.istockphoto.com/id/1420172793/vector/connection-logo-business-global-technology-and-network.jpg?s=612x612&w=0&k=20&c=PSDmuJrOSV9k_GxXtvu8jKHLijvsCT9P9iTGXysPPY4=";
    String img2 =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1PKD2a1PZzLkoDaWk-Xl1-wTCVeb9n7WJWw&s";
    String img3 =
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRsZxTh64waGviP9rXLM-UKxkZpaOMR_gYFZaEQ6CBDwgGowX6PLMQrAb0BXRduu-Qzmeo&usqp=CAU";
    Uint8List bytes1 = (await NetworkAssetBundle(Uri.parse(img1)).load(img1))
        .buffer
        .asUint8List();
    Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse(img2)).load(img2))
        .buffer
        .asUint8List();
    Uint8List bytes3 = (await NetworkAssetBundle(Uri.parse(img3)).load(img3))
        .buffer
        .asUint8List();
    Document pdf = Document();
    pdf.addPage(Page(
        margin: EdgeInsets.symmetric(horizontal: 50),
        build: (context) {
          return Container(
              child: Column(children: [
            Header(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        color: PdfColors.amber,
                        margin: EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        child: Image(
                          MemoryImage(bytes1),
                        )),
                    Container(
                        color: PdfColors.amber,
                        margin: EdgeInsets.all(5),
                        height: 35,
                        width: 35,
                        child: Image(
                          MemoryImage(bytes3),
                        )),
                    Container(
                        color: PdfColors.amber,
                        margin: EdgeInsets.all(5),
                        height: 40,
                        width: 40,
                        child: Image(
                          MemoryImage(bytes2),
                        ))
                  ]),
            ),
            SizedBox(height: 20),
            Text("Resignation Letter",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 80),
            Row(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Column(children: [
                    myPdfText(text: "From :", width: 250),
                    SizedBox(height: 10),
                    myPdfText(text: requestedFor, width: 250),
                    SizedBox(height: 10),
                    myPdfText(text: requestedDate, width: 250),
                  ]),
                  Column(children: [
                    myPdfText(text: "To :"),
                    SizedBox(height: 10),
                    myPdfText(text: "Shinoj TK"),
                    SizedBox(height: 10),
                    myPdfText(text: "Dots,mukkam,kozhikode,kerala"),
                  ])
                ]),
                SizedBox(height: 30),
                myPdfText(text: "RE : Resignation"),
                SizedBox(height: 30),
                myPdfText(text: "Dear Shinoj sir", fontsize: 16),
                SizedBox(height: 10),
                myPdfText(
                    text:
                        "Please accept this as my formal resignation from my position as SOFTWARE DEVELOPER at DOTS, effective five from today date",
                    fontsize: 16),
                SizedBox(height: 10),
                myPdfText(
                    text:
                        "I appreciate the opertunities for growth and development you provided during my tenure. thank you for your repaeted guidence and support",
                    fontsize: 16),
                SizedBox(height: 10),
                myPdfText(
                    text:
                        "Please let me know how how i can be help during the transition period, i wish you and your company a very best going forward",
                    fontsize: 16),
                SizedBox(height: 50),
                myPdfText(text: "Sincerely,"),
                SizedBox(height: 10),
                myPdfText(text: "muhammed faris kk"),
              ])
            ]),
            Expanded(child: SizedBox()),
            myPdfText(text: "This is a System-genarated Document"),
            SizedBox(height: 20),
            Divider(thickness: .5),
            SizedBox(height: 15),
            Footer(
                title: Text("Dots acdemy,Mukkam,Kozhikode,kerala"),
                leading: Text("+91 8921914641"),
                trailing: Link(
                    child: Text("www.DotsAcademy.com"),
                    destination: "https://www.facebook.com/")),
            SizedBox(height: 15),
          ]));
        }));
    final dir = await getExternalStorageDirectory();
    File file = File("${dir!.path}/$requestedFor-$requestedDate.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static genarateSalaryTransferPdf(
      String requestedDate, RequestModel request) async {
    String img1 =
        "https://firebasestorage.googleapis.com/v0/b/dotsapp1-e4e78.appspot.com/o/pdfimages%2FScreenshot%202024-08-04%20211736.png?alt=media&token=1d5cfe05-9851-4726-b116-3725bd0ccd71";
    String img2 =
        "https://firebasestorage.googleapis.com/v0/b/dotsapp1-e4e78.appspot.com/o/pdfimages%2FScreenshot%202024-08-04%20211811.png?alt=media&token=889bb46d-eae5-4807-9a08-5e5ca24bddda";

    Uint8List bytes1 = (await NetworkAssetBundle(Uri.parse(img1)).load(img1))
        .buffer
        .asUint8List();
    Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse(img2)).load(img2))
        .buffer
        .asUint8List();
    Uint8List? sign;
    if (request.files.isNotEmpty) {
      sign = (await NetworkAssetBundle(Uri.parse(request.files.first["url"]))
              .load(request.files.first["url"]))
          .buffer
          .asUint8List();
    }
    Document pdf = Document();
    pdf.addPage(Page(
        margin: EdgeInsets.symmetric(horizontal: 30),
        build: (context) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Header(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            color: PdfColors.amber,
                            margin: EdgeInsets.all(5),
                            height: 100,
                            width: 100,
                            child: Image(
                              MemoryImage(bytes1),
                            )),
                        Container(
                            color: PdfColors.amber,
                            margin: EdgeInsets.all(5),
                            height: 110,
                            width: 110,
                            child: Image(
                              MemoryImage(bytes2),
                            ))
                      ]),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ref : 1258",
                          style: TextStyle(
                            fontSize: 12,
                          )),
                      Text(requestedDate,
                          style: TextStyle(
                            fontSize: 12,
                          )),
                    ]),
                SizedBox(height: 50),
                Row(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myPdfText(text: "To,"),
                        SizedBox(height: 10),
                        myPdfText(text: "Dear sir"),
                        SizedBox(height: 20),
                        myPdfText(
                            text: "Re : Salary Transfer Letter",
                            fontweight: FontWeight.bold),
                        SizedBox(height: 40),
                        myPdfText(
                            text:
                                "This is to certify that Mr. ${request.requestdFor} of ${request.nationality} Nationality, holding passport no ${request.passportNumber} is working with us since 31-August-2005 as Shift Supervisor and is drawing a monthly salary of ${request.amount} Dollar",
                            fontsize: 12),
                        SizedBox(height: 10),
                        myPdfText(
                            text:
                                "We undertake that his monthly salary will be transferred by Payroll to his account number ${request.acountNumber} with yourself effective null and undertake not to transfer the salary to any other bank, unless the employee produces this Clearance letter from your bank.",
                            fontsize: 12),
                        SizedBox(height: 10),
                        myPdfText(
                            text:
                                "In the event of resignation/termination of Mr. ${request.requestdFor} , we undertake to inform you accordingly and transfer his gratuity and fnal settlement of his dues for his account with your bank.",
                            fontsize: 12),
                        SizedBox(height: 40),
                        myPdfText(text: "Your Faithfully,"),
                        SizedBox(height: 10),
                        myPdfText(text: "for UTICO FZC"),
                      ])
                ]),
                SizedBox(height: 20),
                sign != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Container(
                                color: PdfColors.amber,
                                height: 80,
                                width: 160,
                                child: Image(
                                  MemoryImage(sign),
                                )),
                            SizedBox(height: 10),
                            myPdfText(text: "Dr.Amal Almesafr"),
                            SizedBox(height: 10),
                            myPdfText(text: "Director HC & Support Services"),
                          ])
                    : SizedBox(),
                Expanded(child: SizedBox()),
                myPdfText(text: "This is a System-genarated Document"),
                SizedBox(height: 20),
                SizedBox(
                    child: Column(children: [
                  Divider(thickness: .5, indent: 60, endIndent: 60),
                  SizedBox(height: 10),
                  Text(
                      "Dots acdemy,Mukkam,Kozhikode,kerala | Tel +91 8921914641",
                      style: TextStyle(fontSize: 8)),
                  Text("www.DotsAcademy.com", style: TextStyle(fontSize: 8))
                ])),
                SizedBox(height: 40)
              ]));
        }));
    final dir = await getExternalStorageDirectory();
    File file = File("${dir!.path}/${request.requestdFor}-$requestedDate.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}

Widget myPdfText(
    {required String text,
    FontWeight? fontweight,
    double fontsize = 12,
    double? width}) {
  return SizedBox(
      width: width ?? PageTheme().pageFormat.availableWidth,
      child: Text(text,
          overflow: TextOverflow.span,
          style: TextStyle(
            fontSize: fontsize,
            fontWeight: fontweight,
          )));
}
