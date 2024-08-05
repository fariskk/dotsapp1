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
        margin: const EdgeInsets.symmetric(horizontal: 50),
        build: (context) {
          return Container(
              child: Column(children: [
            Header(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        color: PdfColors.amber,
                        margin: const EdgeInsets.all(5),
                        height: 100,
                        width: 100,
                        child: Image(
                          MemoryImage(bytes1),
                        )),
                    Container(
                        color: PdfColors.amber,
                        margin: const EdgeInsets.all(5),
                        height: 35,
                        width: 35,
                        child: Image(
                          MemoryImage(bytes3),
                        )),
                    Container(
                        color: PdfColors.amber,
                        margin: const EdgeInsets.all(5),
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
      {required String requestedDate,
      required RequestModel request,
      required String signUrl,
      required String img1,
      required String img2,
      required String img3}) async {
    Uint8List bytes1 = (await NetworkAssetBundle(Uri.parse(img1)).load(img1))
        .buffer
        .asUint8List();
    Uint8List bytes2 = (await NetworkAssetBundle(Uri.parse(img2)).load(img2))
        .buffer
        .asUint8List();
    Uint8List? bytes3 = (await NetworkAssetBundle(Uri.parse(img3)).load(img3))
        .buffer
        .asUint8List();
    Uint8List sign =
        (await NetworkAssetBundle(Uri.parse(signUrl)).load(signUrl))
            .buffer
            .asUint8List();

    Document pdf = Document();
    pdf.addPage(Page(
        margin: const EdgeInsets.symmetric(horizontal: 40),
        build: (context) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Header(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            color: PdfColors.amber,
                            margin: const EdgeInsets.all(5),
                            height: 60,
                            width: 100,
                            child: Image(MemoryImage(bytes1),
                                fit: BoxFit.contain)),
                        Row(children: [
                          Container(
                              color: PdfColors.amber,
                              margin: const EdgeInsets.all(5),
                              height: 60,
                              width: 100,
                              child: Image(MemoryImage(bytes3),
                                  fit: BoxFit.contain)),
                          SizedBox(width: 5),
                          Container(
                              color: PdfColors.amber,
                              margin: const EdgeInsets.all(5),
                              height: 60,
                              width: 100,
                              child: Image(MemoryImage(bytes2),
                                  fit: BoxFit.contain))
                        ]),
                      ]),
                ),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ref : 1258",
                          style: const TextStyle(
                            fontSize: 12,
                          )),
                      Text(requestedDate,
                          style: const TextStyle(
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      color: PdfColors.amber,
                      height: 60,
                      width: 120,
                      child: Image(MemoryImage(sign), fit: BoxFit.contain)),
                  SizedBox(height: 10),
                  myPdfText(text: "Dr.Amal Almesafr"),
                  SizedBox(height: 10),
                  myPdfText(text: "Director HC & Support Services"),
                ]),
                Expanded(child: SizedBox()),
                myPdfText(text: "This is a System-genarated Document"),
                SizedBox(height: 30),
                SizedBox(
                    child: Column(children: [
                  Divider(thickness: .5, indent: 60, endIndent: 60),
                  SizedBox(height: 10),
                  Text(
                      "P.O.Box:54227,RAKEZ,U.A.E,|Tel:+971 72434610/11||Fax:+971 72434612",
                      style: const TextStyle(fontSize: 9)),
                  Text(
                      "infp@uticome.com|Wbsite: www.uticom.com|www.mb-group.com",
                      style: const TextStyle(fontSize: 9))
                ])),
                SizedBox(height: 50)
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
      width: 540,
      child: Text(text,
          overflow: TextOverflow.span,
          style: TextStyle(
            fontSize: fontsize,
            fontWeight: fontweight,
          )));
}
