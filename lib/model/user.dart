import 'dart:io';
import 'package:flutter/material.dart';

@immutable
class User {
  final String token;
  final String tokenNotification;
  final String uid;
  final String docID;
  final String name;
  final File? image;
  final String email;
  final String password;
  final String photo;

  const User({
    this.token = '',
    this.tokenNotification = '',
    this.uid = '',
    this.docID = '',
    this.name = '',
    this.image,
    this.email = '',
    this.password = '',
    this.photo = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(token: json['idToken'], email: json['email'], uid: json['localId']);
  }

  factory User.fromJsonTwo(Map<String, dynamic>? json) {
    return User(
        name: json!['name'],
        photo: json['photo'],
        tokenNotification: json['token_notification'],
        docID: json['docId'],
        uid: json['uid_user']);
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  User copyWith({
    String? email,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
