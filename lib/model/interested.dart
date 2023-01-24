class Interested {
  String? animalId;
  String? ownerId;
  String? interestedId;

  Interested({this.animalId, this.ownerId, this.interestedId});

  Interested.fromJson(Map<String, dynamic> json) {
    animalId = json['animalId'];
    ownerId = json['ownerId'];
    interestedId = json['interestedId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animalId'] = animalId;
    data['ownerId'] = ownerId;
    data['interestedId'] = interestedId;
    return data;
  }
}
