import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meau/model/animal.dart';
import 'package:meau/model/interested.dart';
import 'package:meau/model/user.dart';

class InterestedController extends ChangeNotifier {
  final User owner = const User();
  final User interested = const User();
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
      for (var e in futureInterestedListWithModel) {
        e.then((value) => addInterested(value));
      }
    }

    notifyListeners();
  }

  verifyExistance(docAnimal, docInterested) async {
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

  removeThisInterested(docAnimal, docInterested) async {
    var collectionRef = FirebaseFirestore.instance
        .collection('interested')
        .where('interestedId', isEqualTo: "user/$docInterested")
        .where('animalId', isEqualTo: "animal/$docAnimal");
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    var interestedsList = allData.map((e) => Interested.fromJson(e as Map)).toList();

    for (var element in interestedsList) {
      FirebaseFirestore.instance.collection('interested').doc(element.docId).delete();
    }
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

    for (var element in interestedsList) {
      FirebaseFirestore.instance.collection('interested').doc(element.docId).delete();
    }
    interesteds.clear();
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
