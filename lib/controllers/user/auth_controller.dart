import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:meau/model/user.dart';
import 'package:meau/services/auth_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
      var name = "";
      var image = "";
      var docId = "";
      token = authBody['idToken'];
      user = User.fromJson(authBody);
      await FirebaseFirestore.instance
          .collection('user')
          .where("uid_user", isEqualTo: res['localId'])
          .get()
          .then((QuerySnapshot querySnapshot) {
        name = querySnapshot.docs.first.get('name');
        image = querySnapshot.docs.first.get('photo');
        docId = querySnapshot.docs.first.id;
      });
      print(image);
      final gsReference =
          FirebaseStorage.instance.ref("files/${image}").child("file/");

      var img = await gsReference.getDownloadURL();

      final Response response = await Dio().get<List<int>>(
        img,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      /// Get App local storage
      final Directory appDir = await getApplicationDocumentsDirectory();

      /// Generate Image Name
      final String imageName = user.uid + ".jpg";

      /// Create Empty File in app dir & fill with new image
      final File file = File(join(appDir.path, imageName));

      file.writeAsBytesSync(response.data as List<int>);

      user = User(
          docID: docId,
          email: user.email,
          name: name,
          uid: user.uid,
          token: user.token,
          image: file);

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

    var res = authBody;
    if (!authBody.containsKey('error')) {
      token = authBody['idToken'];

      this.user = User.fromJson(authBody);
      print(this.user);
      authenticated = true;
    } else {
      token = '';
      authenticated = false;
      res = null;
    }
    notifyListeners();
    return res;
  }

  setUser(User user) {
    this.user = user;
    notifyListeners();
  }
}
