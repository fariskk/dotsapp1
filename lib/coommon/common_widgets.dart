import 'package:flutter/material.dart';
import 'package:formapplication/features/homeScreen/provider/home_screen_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

enum Languages { english, arabic, hindi }

String getText(String name, BuildContext context) {
  final provider = Provider.of<HomeScreenProvider>(context);
  Map englisTexts = {
    "Select Requset Type": "Select Requset Type",
    "-Select Requset Type-": "-Select Requset Type-",
    "Document Name": "Document Name",
    "Name of the Institustion": "Name of the Institustion",
    "Address of the Institustion": "Address of the Institustion",
    "-Select Required Date-": "-Select Required Date-",
    "Select Required Date": "  Select Required Date",
    "Purpose": "Purpose",
    "Remarks": "Remarks",
    "Behalf of": "Behalf of"
  };
  Map hindiTexts = {
    "Select Requset Type": "रिक्यूसेट प्रकार का चयन करें",
    "-Select Requset Type-": "-रिक्यूसेट प्रकार का चयन करें-",
    "Document Name": "दस्तावेज़ का नाम",
    "Name of the Institustion": "संस्थान का नाम",
    "Address of the Institustion": "संस्थान का पता",
    "-Select Required Date-": "-आवश्यक तिथि चुनें-",
    "Select Required Date": "  आवश्यक तिथि चुनें",
    "Purpose": "उद्देश्य",
    "Remarks": "टिप्पणी",
    "Behalf of": "نيابة عن"
  };
  Map arabicTexts = {
    "Select Requset Type": "حدد نوع الطلب",
    "-Select Requset Type-": "-حدد نوع الطلب-",
    "Document Name": "اسم الملف",
    "Name of the Institustion": "اسم المؤسسة",
    "Address of the Institustion": "عنوان المؤسسة",
    "-Select Required Date-": "-حدد التاريخ المطلوب-",
    "Select Required Date": "  حدد التاريخ المطلوب",
    "Purpose": "غاية",
    "Remarks": "ملاحظات",
    "Behalf of": "हेतु"
  };
  switch (provider.language) {
    case Languages.english:
      return englisTexts[name] ?? name;
    case Languages.arabic:
      return arabicTexts[name] ?? name;
    case Languages.hindi:
      return hindiTexts[name] ?? name;
    default:
      return "called Default";
  }
}
