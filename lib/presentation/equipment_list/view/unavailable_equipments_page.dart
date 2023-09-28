import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

import '../../../models/equipment_model.dart';
import '../view_model/equipment_list_view_model.dart';
import '../../equipment_detail/view/equipment_detail_view.dart';


class UnavailableEquipmentsPage extends StatefulWidget {
  const UnavailableEquipmentsPage ({super.key});

  @override
  _UnavailableEquipmentsPage createState() => _UnavailableEquipmentsPage();
}

class _UnavailableEquipmentsPage extends State<UnavailableEquipmentsPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: StreamBuilder<List<Equipment>>(
            stream: EquipmentListViewModel.readEquipments(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text("Something went wrong ${snapshot.error}");
              } else if (snapshot.hasData) {
                final equipments = snapshot.data!;
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  children: equipments.map(buildEquipment).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }

        ),
      );
  Widget buildEquipment(Equipment equipment) => Visibility(
    //If the "isAvailable" value is "false", then the equipment is displayed
    //in the "Unavailable" tab and the "Request" button will NOT be visible
    //Otherwise, it will be displayed in the "Available tab"
    visible: showButton(equipment.isAvailable),
    child: ListTile(
        title: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black54,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(3.0)
                )
            ),
            padding: EdgeInsets.all(15.0),

            child: Text(equipment.name+" ("+equipment.equipmentcode+")")),
        leading: Icon(Icons.circle_sharp, color: Colors.deepOrangeAccent,),
        onTap: (){
          //Navigates to the equipment's details page with the submit button shown
          Navigator.push(
              context,
              MaterialPageRoute
                (builder: (context)=>
                  EquipmentDetailsView(equipment))
          );
        }
    ),
  );

  bool showButton(bool isAvailable) {
    bool showChild = false;
    if(isAvailable==false){
      showChild = true;//must stay "true" if to be ousted from the "Unavailable"
      //tab if equipment's "isAvailable" value is "false"
    }
    return showChild;
  }
}
