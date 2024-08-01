import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

Text myText(
    {required String text,
    required double size,
    Color? color,
    FontWeight? fontWeight}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.openSans(
      color: color,
      fontSize: size,
      fontWeight: fontWeight,
    ),
  );
}

Widget mySpacer({double? height, double? width}) {
  return SizedBox(
    height: height,
    width: width,
  );
}

String getText(String name, BuildContext context) {
  var language = AppLocalizations.of(context)!;
  switch (name) {
    case "HR Request Form":
      return language.hrRequestForm;
    case "Individual":
      return language.individual;
    case "Behalf of":
      return language.behalfOf;
    case "On Behalf Of":
      return language.onBehalfOf;
    case "Select Requset Type":
      return language.selectRequsetType;
    case "Document Name":
      return language.documentName;
    case "Name of the Institustion":
      return language.nameOftheInstitustion;
    case "Address of the Institustion":
      return language.addressOTheInstitustion;
    case "Select Required Date":
      return language.selectRequiredDate;
    case "Purpose":
      return language.purpose;
    case "Attach files":
      return language.attachFiles;
    case "Browse File":
      return language.browseFile;
    case "Remarks":
      return language.remarks;
    case "Clear":
      return language.clear;
    case "Submit":
      return language.submit;
    case "Select Employee":
      return language.selectEmployee;
    case "Who is Logging In":
      return language.whoIsLoggingIn;
    case "Employee":
      return language.employee;
    case "Login":
      return language.login;
    case "Add File":
      return language.addFile;
    case "Admin":
      return language.admin;
    case "Login As Employee":
      return language.loginAsEmployee;
    case "Login As Admin":
      return language.loginAsAdmin;
    case "Requested By":
      return language.requestedBy;
    case "Requested For":
      return language.requestedFor;
    case "Status":
      return language.status;
    case "Requried Date":
      return language.requiredDate;
    case "Requested Date":
      return language.requestedDate;
    case "Download Attached Files":
      return language.downloadAttachedFiles;
    case "Requested Document":
      return language.requestedDocument;
    case "User Name":
      return language.username;
    case "Password":
      return language.password;
    case "Reject":
      return language.reject;
    case "Approve":
      return language.approve;
    default:
      return "error";
  }
}
