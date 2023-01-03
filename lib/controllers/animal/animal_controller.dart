import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meau/model/animal.dart';
import 'package:meau/views/animals/register_animal_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AnimalController extends ChangeNotifier {
  List<dynamic> animals = [];
  bool loading = true;
  bool todos = true;

  setTodos(value){
    this.todos = value;
    notifyListeners();
  }

  Future<void> getAnimals() async {
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('animal');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var animals = allData.map((e) => Animal.fromJson(e as Map)).toList();

    this.animals = animals;
    notifyListeners();
  }

  setLoading(){
    this.loading = !this.loading;
    notifyListeners();
  }

  Future<void> getUserAnimals(docID) async{
    var _collectionRef =
    FirebaseFirestore.instance.collection('animal').where('user', isEqualTo: "user/$docID");
    // Get docs from collection reference
    var querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var animals = allData.map((e) => Animal.fromJson(e as Map)).toList();

    this.animals = animals;
    notifyListeners();
  }

  getFile(image){
    var img = getIMG(image);

    return img;
  }

  Future<File> getIMG(image) async{
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
    final String imageName = "$image";

    /// Create Empty File in app dir & fill with new image
    final File file = File(join(appDir.path, imageName));

    file.writeAsBytesSync(response.data as List<int>);

    return file;

  }
}