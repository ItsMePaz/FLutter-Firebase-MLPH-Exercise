
import "package:flutter/material.dart";
import '../../../models/equipment_model.dart';
import '../view_model/equipment_list_view_model.dart';
import '../../equipment_detail/view/equipment_detail_view.dart';


class AvailableEquipmentsPage extends StatefulWidget {
  const AvailableEquipmentsPage ({super.key});

  @override
  _AvailableEquipmentsPage createState() => _AvailableEquipmentsPage();
}

class _AvailableEquipmentsPage extends State<AvailableEquipmentsPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: StreamBuilder<List<Equipment>>(
            stream: EquipmentListViewModel.readEquipments(),
            builder: (context, snapshot) {
              //This conditional statement handles the return in the UI
              // if in case the stream
              //of equipment objects from firebase does or does not exist
              if(snapshot.hasError){
                return Text("Something went wrong ${snapshot.error}");
              } else if (snapshot.hasData) {
                final equipments = snapshot.data!;
                //Returns the details to be displayed in the UI
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

          //This widget builds the list shown in the UI that is based on
          //the read equipment json converted to an object
          Widget buildEquipment(Equipment equipment) => Visibility(
            //This handles the list segregation.
            //If the "isAvailable" value is "true", then the equipment is displayed
            //in the "Available" tab and the "Request" button will be visible
            //Otherwise, it will be displayed in the "Unavailable tab"
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
              leading: Icon(Icons.circle_sharp, color: Colors.green,),
              onTap: (){
                //Navigates to the equipment's details page with submit button shown
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
    bool showChild = true;
    if(isAvailable==false){
      showChild = false;//must stay "false" if to be ousted from the "Available"
      //tab if equipment's "isAvailable" value is "false"
    }
    return showChild;
  }
}
