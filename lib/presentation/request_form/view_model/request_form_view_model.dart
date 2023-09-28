
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exercise_paz/models/request_model.dart';

import '../../../models/equipment_model.dart';

class RequestFormViewModel {
  final controllerFullName = TextEditingController();
  final controllerContactNumber = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerDepartment = TextEditingController();
  final controllerPosition = TextEditingController();
  final controllerPurpose = TextEditingController();
  final controllerDuration = TextEditingController();
  final alphaOnlyFormatter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s\.\-]'));
  final numericFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
  String? selectedValue;


  String? validateGmail(String? value) {
    RegExp regex = RegExp(r'^[a-zA-Z0-9\.]+@monstar-lab\.com$');
    if (!regex.hasMatch(value!)) {
      return 'Invalid email address';
    }
    return null;
  }

  static Stream<List<RequestDetails>> readRequestDetails() =>
      FirebaseFirestore.instance
          .collection("requestForm")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => RequestDetails.fromJson(doc.data())).toList());

  Future createRequest(RequestDetails requestDetails) async {
    final docRequest = FirebaseFirestore.instance.collection("requestForm").doc();
    requestDetails.id = docRequest.id;
    final json = requestDetails.toJson();
    await docRequest.set(json);
  }
}



