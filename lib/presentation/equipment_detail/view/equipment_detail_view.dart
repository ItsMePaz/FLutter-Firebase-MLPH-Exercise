

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise_paz/models/equipment_model.dart';
import 'package:flutter_exercise_paz/presentation/request_form/view/request_form_view.dart';

import '../../../shared/widgets/center_app_bar.dart';

class EquipmentDetailsView extends StatelessWidget {
  const EquipmentDetailsView(this.equipment, {super.key});

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenterAppBar(equipment.name, context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(equipment.imageUrl),
              const SizedBox(height: 24),

              Text("Equipment Code: ",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Text(equipment.equipmentcode,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54
                ),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 30),

              Text("Description: ",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54
              ),
              textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(equipment.description,
                    style: TextStyle(
                      fontSize: 20,
                        color: Colors.black54
                    ),
                textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 30),

              Text("Specs: ",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black54
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(equipment.specs,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 30),

              Visibility(
                visible: showButton(equipment.isAvailable),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 100.0),
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(
                        builder:(context){
                          return RequestForm(equipment);
                        } )),
                    child: Text("Request"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.green;
                          }
                          return Colors.green;
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );


  }

  bool showButton(bool isAvailable) {
    bool showChild = true;
      if(isAvailable==false){
        showChild = false;
      }
      return showChild;
  }
}
