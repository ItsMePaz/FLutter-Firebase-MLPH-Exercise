class RequestDetails {
  String id;
  String name;
  String contactNumber;
  String email;
  String department;
  String position;
  String purpose;
  String duration;
  String equipmentcode;

  RequestDetails({
    this.id ="",
    required this.name,
    required this.contactNumber,
    required this.email,
    required this.department,
    required this.position,
    required this.purpose,
    required this.duration,
    required this.equipmentcode,
  });

Map<String, dynamic> toJson() => {
  "id":id,
  "name":name,
  "contactNumber": contactNumber,
  "email": email,
  "department": department,
  "position": position,
  "purpose": purpose,
  "duration": duration,
  "equipmentcode": equipmentcode
};

  static RequestDetails fromJson(Map<String, dynamic> json) {
    return RequestDetails(
       id: json["id"],
      name: json["name"],
      contactNumber: json["contactNumber"],
      email: json["email"],
      department: json["department"],
      position: json["position"],
      purpose: json["purpose"],
      duration: json["duration"],
      equipmentcode: json["equipmentcode"],
    );
  }
  }





