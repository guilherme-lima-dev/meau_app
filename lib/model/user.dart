import 'package:flutter/material.dart';

@immutable
class User {
  final String token;
  // final String name;
  late final String email;
  final String password;

  User({
    this.token = '',
    this.email = '',
    this.password = '',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['idToken'],
      email: json['email'],
    );
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
