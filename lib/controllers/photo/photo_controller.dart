import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:meau/model/animal.dart';
import 'package:meau/model/user.dart';
import 'package:path/path.dart';

class PhotoController extends ChangeNotifier{
  File? photoUser;
  File? photoAnimal;
  User? user;
  Animal? animal;

  setPhotoUser(File? photoUser){
    this.photoUser = photoUser;
    notifyListeners();
  }
  setPhotoAnimal(File? photoAnimal){
    this.photoAnimal = photoAnimal;
    notifyListeners();
  }

  Future uploadFile() async {
    if (photoUser == null) return;
    final fileName = basename(photoUser!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      print(user?.docID);
      var doc = FirebaseFirestore.instance.collection('user').doc(user?.docID);
      await doc.update({"photo": fileName});
      await ref.putFile(photoUser!);
    } catch (e) {
      print('error occured');
    }

    notifyListeners();
  }

  Future uploadFileAnimal() async {
    if (photoAnimal == null) return;
    final fileName = basename(photoAnimal!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      // print(user?.docID);
      // var doc = FirebaseFirestore.instance.collection('animal').doc(user?.docID);
      // await doc.update({"photo": fileName});
      await ref.putFile(photoAnimal!);
    } catch (e) {
      print('error occured');
    }

    notifyListeners();
  }

  setAnimal(Animal animal){
    this.animal = animal;
    notifyListeners();
  }

  setUser(User user){
    this.user = user;
    notifyListeners();
  }
}