// To parse this JSON data, do
//
//     final selectRole = selectRoleFromJson(jsonString);

import 'dart:convert';

ProfileDetails profiledetailsFromJson(String str) =>
    ProfileDetails.fromJson(json.decode(str));

String profiledetails(ProfileDetails data) => json.encode(data.toJson());

class ProfileDetails {
  ProfileData data;
  String message;
  bool status;
  bool token;

  ProfileDetails({
    required this.data,
    required this.message,
    required this.status,
    required this.token,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
        data: ProfileData.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
        "token": token,
      };
}

class ProfileData {
  int id;
  String firstName;
  String lastName;
  String email;
  dynamic emailVerifiedAt;
  String location;
  String mobileNumber;
  int role;
  dynamic createdAt;
  DateTime updatedAt;
  String encryptPassword;
  dynamic deletedAt;
  String apiToken;
  dynamic fcmToken;
  String designation;
  int userParty;
  String emergencyContactName;
  String emergencyContactRelation;
  String emergencyContactNumber;
  int idProof;
  String idProofNumber;
  String documentPath;
  dynamic profilePhoto;
  int isActive;
  dynamic adhaarCardNo;

  ProfileData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.emailVerifiedAt,
    required this.location,
    required this.mobileNumber,
    required this.role,
    this.createdAt,
    required this.updatedAt,
    required this.encryptPassword,
    this.deletedAt,
    required this.apiToken,
    this.fcmToken,
    required this.designation,
    required this.userParty,
    required this.emergencyContactName,
    required this.emergencyContactRelation,
    required this.emergencyContactNumber,
    required this.idProof,
    required this.idProofNumber,
    required this.documentPath,
    this.profilePhoto,
    required this.isActive,
    this.adhaarCardNo,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        location: json["location"],
        mobileNumber: json["mobile_number"],
        role: json["role"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        encryptPassword: json["encrypt_password"],
        deletedAt: json["deleted_at"],
        apiToken: json["api_token"],
        fcmToken: json["FCM_token"],
        designation: json["designation"],
        userParty: json["user_party"],
        emergencyContactName: json["emergency_contact_name"],
        emergencyContactRelation: json["emergency_contact_relation"],
        emergencyContactNumber: json["emergency_contact_number"],
        idProof: json["id_proof"],
        idProofNumber: json["id_proof_number"],
        documentPath: json["document_path"],
        profilePhoto: json["profile_photo"],
        isActive: json["is_active"],
        adhaarCardNo: json["adhaar_card_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "location": location,
        "mobile_number": mobileNumber,
        "role": role,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "encrypt_password": encryptPassword,
        "deleted_at": deletedAt,
        "api_token": apiToken,
        "FCM_token": fcmToken,
        "designation": designation,
        "user_party": userParty,
        "emergency_contact_name": emergencyContactName,
        "emergency_contact_relation": emergencyContactRelation,
        "emergency_contact_number": emergencyContactNumber,
        "id_proof": idProof,
        "id_proof_number": idProofNumber,
        "document_path": documentPath,
        "profile_photo": profilePhoto,
        "is_active": isActive,
        "adhaar_card_no": adhaarCardNo,
      };
}
