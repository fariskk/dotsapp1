import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:formapplication/models/request_model.dart';

class AdminProvider extends ChangeNotifier {
  void reject(RequestModel details) {
    final fir1 = FirebaseFirestore.instance.collection("requests");
    final fir2 = FirebaseFirestore.instance.collection(details.requestdFor);
    fir1.doc(details.requestId).update({"status": "rejected"});
    fir2.doc(details.requestId).update({"status": "rejected"});
  }

  void approve(RequestModel details) {
    final fir1 = FirebaseFirestore.instance.collection("requests");
    final fir2 = FirebaseFirestore.instance.collection(details.requestdFor);
    fir1.doc(details.requestId).update({"status": "approved"});
    fir2.doc(details.requestId).update({"status": "approved"});
  }
}
