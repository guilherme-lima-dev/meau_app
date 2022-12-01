import 'package:flutter/material.dart';
import 'package:meau/model/user.dart';
import 'package:meau/services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService service;
  var user = User();
  var token = '';
  var authenticated = false;
  var loading = false;

  AuthController(this.service);

  // getUser() async{
  //   user = await service.getUser(token);
  //   notifyListeners();
  // }

  setLoading() {
    loading = !loading;
    notifyListeners();
  }

  auth(Map credentials) async {
    var authBody = await service.auth(credentials);
    var res = authBody;
    if (!authBody.containsKey('error')) {
      token = authBody['idToken'];
      user = User.fromJson(authBody);
      authenticated = true;
    } else {
      token = '';
      authenticated = false;
      res = null;
    }
    notifyListeners();
    return res;
  }

  register(Map user) async {
    var authBody = await service.register(user);
    print(authBody);
    var res = authBody;
    if (!authBody.containsKey('error')) {
      token = authBody['idToken'];
      this.user = User.fromJson(authBody);
      authenticated = true;
    } else {
      token = '';
      authenticated = false;
      res = null;
    }
    notifyListeners();
    return res;
  }
}
