import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meau/model/animal.dart';
import 'package:meau/model/user.dart';

class Interested {
  String? docId;
  String? animalId;
  String? ownerId;
  String? interestedId;

  Interested({this.docId, this.animalId, this.ownerId, this.interestedId});

  Interested.fromJson(Map<dynamic, dynamic> json) {
    docId = json['docId'];
    animalId = json['animalId'];
    ownerId = json['ownerId'];
    interestedId = json['interestedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docId'] = docId;
    data['animalId'] = animalId;
    data['ownerId'] = ownerId;
    data['interestedId'] = interestedId;
    return data;
  }
}

class InterestedWithModels {
  User? owner = User();
  User? interested = User();
  Animal? animal = Animal();

  InterestedWithModels({this.animal, this.owner, this.interested});

  Future<InterestedWithModels?> fromDocs(Interested interested) async {
    var splitAnimalDoc = interested.animalId!.split('/');
    var splitOwnerDoc = interested.ownerId!.split('/');
    var splitInterestedDoc = interested.interestedId!.split('/');
    var docAnimal = FirebaseFirestore.instance.collection('animal').doc(splitAnimalDoc[1]);
    var docOwner = FirebaseFirestore.instance.collection('user').doc(splitOwnerDoc[1]);
    var docInterested = FirebaseFirestore.instance.collection('user').doc(splitInterestedDoc[1]);
    var querySnapshotAnimal = await docAnimal.get();
    var querySnapshotOwner = await docOwner.get();
    var querySnapshotInterested = await docInterested.get();

    Map<String, dynamic>? mapOwner = querySnapshotOwner.data();
    Map<String, dynamic>? mapInterested = querySnapshotInterested.data();

    mapOwner!['docId'] = docOwner.id;
    mapInterested!['docId'] = docInterested.id;

    return InterestedWithModels(
        animal: Animal.fromJson(querySnapshotAnimal.data() as Map),
        owner: User.fromJsonTwo(mapOwner),
        interested: User.fromJsonTwo(mapInterested));
  }
}
