import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meau/model/animal.dart';
import 'package:meau/model/interested.dart';
import 'package:meau/model/user.dart';

class InterestedController extends ChangeNotifier {
  final User owner = User();
  final User interested = User();
  final Animal animal = Animal();
  bool loading = false;
  bool canAdopt = true;
  List<InterestedWithModels> interesteds = [];

  getAll(docOwner) async {
    var collectionRef = FirebaseFirestore.instance
        .collection('interested')
        .where('ownerId', isEqualTo: "user/$docOwner");
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var interestedsList = allData.map((e) => Interested.fromJson(e as Map)).toList();

    InterestedWithModels interestedWithModels = InterestedWithModels();

    List<Future<InterestedWithModels?>> futureInterestedListWithModel =
        interestedsList.map((e) => interestedWithModels.fromDocs(e)).toList();

    if (futureInterestedListWithModel.length > interesteds.length) {
      futureInterestedListWithModel.forEach((e) {
        e.then((value) => addInterested(value));
      });
    }

    notifyListeners();
  }

  verifyExistance(docInterested, docAnimal) async {
    var collectionRef = FirebaseFirestore.instance
        .collection('interested')
        .where('interestedId', isEqualTo: "user/$docInterested")
        .where('animalId', isEqualTo: "animal/$docAnimal");
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var interestedsList = allData.map((e) => Interested.fromJson(e as Map)).toList();

    if (interestedsList.isNotEmpty) {
      canAdopt = false;
    } else {
      canAdopt = true;
    }
    notifyListeners();
  }

  removeThisInterested(docInterested, docAnimal) async {
    var collectionRef = FirebaseFirestore.instance
        .collection('interested')
        .where('interestedId', isEqualTo: "user/$docInterested")
        .where('animalId', isEqualTo: "animal/$docAnimal");
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var interestedsList = allData.map((e) => Interested.fromJson(e as Map)).toList();

    interestedsList.forEach((element) {
      FirebaseFirestore.instance.collection('interested').doc(element.animalId).delete();
    });
  }

  removeAllInterestedInThisAnimal(docAnimal) async {
    var collectionRef = FirebaseFirestore.instance
        .collection('interested')
        .where('animalId', isEqualTo: "animal/$docAnimal");

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var interestedsList = allData.map((e) => Interested.fromJson(e as Map)).toList();

    print('1-------------------');
    interestedsList.forEach((element) {
      print(element.animalId);
    });
    print('2-------------------');

    notifyListeners();
  }

  addInterested(InterestedWithModels? interestedWithModels) {
    interesteds.add(interestedWithModels!);
    notifyListeners();
  }

  setLoading() {
    loading = !loading;
  }
}
