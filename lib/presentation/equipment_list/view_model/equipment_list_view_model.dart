
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/equipment_model.dart';

class EquipmentListViewModel {


  //Returns a stream of equipment objects to be displayed in the UI
  static Stream<List<Equipment>> readEquipments() =>
      FirebaseFirestore.instance
          .collection("equipments")
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => Equipment.fromJson(doc.data())).toList());
}