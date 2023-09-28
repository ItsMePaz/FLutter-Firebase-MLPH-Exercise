class Equipment {
  String equipmentcode;
  String specs;
  String description;
  String imageUrl;
  String name;
  bool isAvailable;

  Equipment({
    required this.equipmentcode,
    required this.specs,
    required this.description,
    required this.isAvailable,
    required this.imageUrl,
    required this.name,
});


  //Returns an equipment object from the json data retrieved from firebase
 static Equipment fromJson(Map<String, dynamic> json) {
   return Equipment(
     equipmentcode: json["equipmentcode"],
     specs: json["specs"],
     description: json["description"],
     isAvailable: json["isAvailable"],
     imageUrl: json["imageUrl"],
     name: json["name"],
  );
 }
}





