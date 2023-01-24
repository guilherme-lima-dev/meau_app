class Interested {
  String? animalid;
  String? ownerid;
  String? interestedid;

  Interested({this.animalid, this.ownerid, this.interestedid});

  Interested.fromJson(Map<String, dynamic> json) {
    animalid = json['animalid'];
    ownerid = json['ownerid'];
    interestedid = json['interestedid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['animalid'] = animalid;
    data['ownerid'] = ownerid;
    data['interestedid'] = interestedid;
    return data;
  }
}
