import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exercise_paz/models/equipment_model.dart';
import 'package:flutter_exercise_paz/models/request_model.dart';
import 'package:flutter_exercise_paz/presentation/request_form/view_model/request_form_view_model.dart';
import "package:flutter/src/material/dropdown.dart";
import '../../../shared/widgets/center_app_bar.dart';
import 'package:quickalert/quickalert.dart';

class RequestForm extends StatelessWidget {
   RequestForm(this.equipment, {super.key});

  final Equipment equipment;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final viewModel = RequestFormViewModel();

   @override
  Widget build(BuildContext context) => Scaffold(

    appBar: CenterAppBar("REQUEST FORM", context),
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
            padding:  const EdgeInsets.all(1.0),
            child: Column(children:[

          const SizedBox(height: 24),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: Text("You are about to request for this equipment: ",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,

              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: Text(equipment.name,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: Text("Fill out and submit this form to process your request",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 15),
          const Divider(thickness: 2,),
          const SizedBox(height: 15),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: Text("Personal Information",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: TextFormField(
              controller: viewModel.controllerFullName,
              inputFormatters: [viewModel.alphaOnlyFormatter],
              decoration: InputDecoration(
                  labelText: "Full name",
                  border: OutlineInputBorder()
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "This field is required";
                }
                return null;
              },
              keyboardType: TextInputType.name,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: TextFormField(
              controller: viewModel.controllerContactNumber,
              inputFormatters: [viewModel.numericFormatter],
              decoration: InputDecoration(
                  labelText: "Contact Number",
                  border: OutlineInputBorder()
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "This field is required";
                }
                return null;
              },
              keyboardType: TextInputType.name,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: TextFormField(
              controller: viewModel.controllerEmail,
              decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                helperText: "Please use the company email address"
              ),
              validator: viewModel.validateGmail,
              keyboardType: TextInputType.name,
            ),
          ),

          const SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: DropdownButtonFormField<String>(
              value: viewModel.selectedValue,
              items: [
                DropdownMenuItem(value: "Support", child: Text("Support")),
                DropdownMenuItem(value: "Operation", child: Text("Operation")),
              ],
              onChanged: (newValue){
                viewModel.selectedValue=newValue!;
              },
              decoration: InputDecoration(
                  labelText: "Choose department",
                  border: OutlineInputBorder()
              ),
              validator: (value){
                if(value==null){
                  return "Please select your department";
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 30),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: TextFormField(
              controller: viewModel.controllerPosition,
              decoration: InputDecoration(
                  labelText: "Position",
                  border: OutlineInputBorder()
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "This field is required";
                }
                return null;
              },
              keyboardType: TextInputType.name,
            ),
          ),

          const SizedBox(height: 24),
          const Divider(thickness: 2,),
          const SizedBox(height: 24),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: Text("Request Details",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: TextFormField(
              controller: viewModel.controllerPurpose,
              decoration: InputDecoration(
                  labelText: "Purpose of Request",
                  border: OutlineInputBorder()
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "This field is required";
                }
                return null;
              },
              keyboardType: TextInputType.name,
            ),
          ),

          const SizedBox(height: 30),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 26.0),
            child: TextFormField(
              controller: viewModel.controllerDuration,
              decoration: InputDecoration(
                  labelText: "How long will you need it?)",
                  helperText: "Please indicate unit time or range",
                  border: OutlineInputBorder()
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "This field is required";
                }
                return null;
              },
              keyboardType: TextInputType.name,
            ),
          ),

          const SizedBox(height: 30),


          Container(
            margin: EdgeInsets.symmetric(horizontal: 100.0),
            height: 40,
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                //Upon clicking the submit button, all validator for each
                //TextFormField and DropDownButtonFormField runs.
                //Once eveything is validated, all inputs, converted into text, will
                //be converted into a RequestDetails object.
                if(_formKey.currentState!.validate()){
                  final requestDetail = RequestDetails(
                    name: viewModel.controllerFullName.text,
                    contactNumber: viewModel.controllerContactNumber.text,
                    email: viewModel.controllerEmail.text,
                    department: viewModel.selectedValue!,
                    position: viewModel.controllerPosition.text,
                    purpose: viewModel.controllerPurpose.text,
                    duration: viewModel.controllerDuration.text,
                    equipmentcode: equipment.equipmentcode,
                  );
                  viewModel.createRequest(requestDetail); //Calls the createRequest function to turn the passed object into a json data to be set in the firebase "request" collection
                  CollectionReference equipmentCollection = FirebaseFirestore.instance.collection("equipments");

                  //This targets equipment's doc reference and updates the "isAvaialble"
                  // value of the equipment and turns it to "false", removing it from
                  //the available list and removing the "Request button"
                  QuerySnapshot querySnapshot = await equipmentCollection.where("equipmentcode", isEqualTo: equipment.equipmentcode).get();
                  querySnapshot.docs.forEach((QueryDocumentSnapshot doc) {
                    // Get the document reference and update the "isAvailable" field
                    DocumentReference docRef = doc.reference;
                    docRef.update({"isAvailable": false});
                  });

                  Navigator.pop(context); //Closes the request form

                  //Shows a success alert
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text:"Equipment has been made temporarily unavailable to avoid more than one requests until an admin approves yours",
                    textColor: Colors.black54,
                  );
                }
              },
              child: Text("Submit"),
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

          const SizedBox(height: 30),

        ],)),
      )
        ),
  );
}
