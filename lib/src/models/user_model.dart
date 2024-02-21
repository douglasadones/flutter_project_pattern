// ignore_for_file: public_member_api_docs, sort_constructors_first
import "dart:convert";

import 'package:projeto_flutter/src/models/address_model.dart';
import 'package:projeto_flutter/src/models/company_model.dart';

class UserModel {
  int? id;
  String name;
  String username;
  String email;
  Address? address;
  String phone;
  String website;
  Company? company;
  
  UserModel({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    this.address,
    required this.phone,
    required this.website,
    this.company,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'userName': username,
      'email': email,
      'address': address?.toMap(),
      'phone': phone,
      'website': website,
      'company': company?.toMap(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      address: map['address'] != null ? Address.fromMap(map['address'] as Map<String,dynamic>) : null,
      phone: map['phone'] as String,
      website: map['website'] as String,
      company: map['company'] != null ? Company.fromMap(map['company'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, userName: $username, email: $email, address: $address, phone: $phone, website: $website, company: $company)';
  }
}
