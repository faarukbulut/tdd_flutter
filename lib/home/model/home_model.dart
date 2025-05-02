import 'dart:convert';

List<ReqProfile> reqProfileFromJson(String str) => List<ReqProfile>.from(json.decode(str).map((x) => ReqProfile.fromJson(x)));

String reqProfileToJson(List<ReqProfile> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReqProfile {
  int? id;
  String? name;
  String? username;
  String? email;
  String? expiryTime;

  bool isExpiry()
  {
    if(expiryTime == null) return false;
    final _currentData = DateTime.parse(expiryTime!);
    return DateTime.now().isAfter(_currentData);
  }

  ReqProfile({
    this.id,
    this.name,
    this.username,
    this.email,
    this.expiryTime
  });

  factory ReqProfile.fromJson(Map<String, dynamic> json) => ReqProfile(
    id: json["id"] ?? 0,
    name: json["name"] ?? "",
    username: json["username"] ?? "",
    email: json["email"] ?? "",
    expiryTime: json["expiryTime"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? 0,
    "name": name ?? "",
    "username": username ?? "",
    "email": email ?? "",
    "expiryTime": expiryTime ?? "",
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReqProfile &&
      other.email == email &&
      other.name == name &&
      other.username == username;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode ^ username.hashCode;



}
