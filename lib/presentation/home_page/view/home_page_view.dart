import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_exercise_paz/presentation/equipment_list/view/available_equipments_view.dart';
import 'package:flutter_exercise_paz/presentation/equipment_list/view/unavailable_equipments_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 2,
    child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text("EQUIPMENT",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: "Arial",
        ),),
        centerTitle: true,
        bottom: TabBar(
            tabs:[
              Tab(text: "Available",
                  icon: Icon(Icons.lock_open,
                    color: Colors.black,)),
              Tab(text: "Unavailable",
                  icon: Icon(Icons.lock_clock,
                    color: Colors.black,))
            ],
        ),
      ),
      body: TabBarView(
        children: [
          AvailableEquipmentsPage(),
          UnavailableEquipmentsPage(),
        ],
      )
    ),
  );
}


