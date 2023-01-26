import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meau/model/animal.dart';
import 'package:meau/services/notification_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AnimalController extends ChangeNotifier {
  List<dynamic> animals = [];
  bool loading = false;
  bool todos = true;
  NotificationService notificationService;

  AnimalController(this.notificationService);

  setTodos(value) {
    todos = value;
    notifyListeners();
  }

  Future<void> getAnimals() async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('animal');
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var animals = allData.map((e) => Animal.fromJson(e as Map)).toList();

    this.animals = animals;
    notifyListeners();
  }

  setLoading() {
    loading = !loading;
    notifyListeners();
  }

  changeOwner(docAnimal, docNewOwner) {
    FirebaseFirestore.instance
        .collection('animal')
        .doc(docAnimal)
        .update({'user': "user/$docNewOwner"});
  }

  Future<void> getUserAnimals(docID) async {
    var collectionRef =
        FirebaseFirestore.instance.collection('animal').where('user', isEqualTo: "user/$docID");
    // Get docs from collection reference
    var querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var animals = allData.map((e) => Animal.fromJson(e)).toList();

    this.animals = animals;
    notifyListeners();
  }

  getFile(image) {
    var img = getIMG(image);

    return img;
  }

  Future<File> getIMG(image) async {
    final gsReference = FirebaseStorage.instance.ref("files/$image").child("file/");

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

  sendNotification(String? docUser, Animal animal) async {
    var splitDoc = docUser!.split('/');
    var doc = FirebaseFirestore.instance.collection('user').doc(splitDoc[1]);
    var querySnapshot = await doc.get();
    final Map<String, dynamic>? allData = querySnapshot.data();

    String tokenNotification = allData!["token_notification"];

    String title = "Novo interessado!";
    String message = "Existe uma pessoa interessada em adotar ${animal.name}!";

    await notificationService.sendNotification(title, message, tokenNotification);
  }
}
