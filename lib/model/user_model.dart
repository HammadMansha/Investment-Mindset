import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.dateofBirth,
    this.email,
    this.userId,
    this.userName,
    this.unHashedPassword,
    this.addressL1,
    this.addressL2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.phone,
    this.role,
    this.photoPath,
    this.memberShipLevel,
    this.status,
    this.active,
    this.suspended,
    this.id,
  });

  String? firstName;
  String? lastName;
  DateTime? dateofBirth;
  String? email;
  int? userId;
  String? userName;
  String? unHashedPassword;
  String? addressL1;
  String? addressL2;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? phone;
  String? role;
  String? photoPath;
  String? memberShipLevel;
  String? status;
  bool? active;
  bool? suspended;
  String? id;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        dateofBirth: DateTime.parse(json["DateofBirth"]),
        email: json["email"],
        userId: json["user_id"],
        userName: json["userName"],
        unHashedPassword: json["unHashedPassword"],
        addressL1: json["addressL1"],
        addressL2: json["addressL2"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postalCode"],
        country: json["country"],
        phone: json["phone"],
        role: json["role"],
        photoPath: json["photoPath"],
        memberShipLevel: json["memberShipLevel"],
        status: json["status"],
        active: json["active"],
        suspended: json["suspended"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "DateofBirth": dateofBirth!.toIso8601String(),
        "email": email,
        "user_id": userId,
        "userName": userName,
        "unHashedPassword": unHashedPassword,
        "addressL1": addressL1,
        "addressL2": addressL2,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "country": country,
        "phone": phone,
        "role": role,
        "photoPath": photoPath,
        "memberShipLevel": memberShipLevel,
        "status": status,
        "active": active,
        "suspended": suspended,
        "id": id,
      };
}
