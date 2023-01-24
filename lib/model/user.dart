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

  const User({
    this.token = '',
    this.tokenNotification = '',
    this.uid = '',
    this.docID = '',
    this.name = '',
    this.image,
    this.email = '',
    this.password = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        token: json['idToken'], email: json['email'], uid: json['localId']);
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
