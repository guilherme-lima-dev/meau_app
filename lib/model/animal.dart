import 'dart:io';

class Animal {
  String? id;
  String? about;
  String? age;
  String? carry;
  String? health;
  String? illness;
  String? name;
  String? objective;
  String? porte;
  Requirements? requirements;
  String? sex;
  String? species;
  String? temperament;
  String? photo;
  String? user;

  Animal(
      {
        this.id,
        this.about,
        this.age,
        this.carry,
        this.health,
        this.illness,
        this.name,
        this.objective,
        this.porte,
        this.requirements,
        this.sex,
        this.species,
        this.temperament,
        this.photo,
        this.user
      });

  Animal.fromJson(Map<dynamic, dynamic> json) {
    about = json['about'];
    age = json['age'];
    carry = json['carry'];
    health = json['health'];
    illness = json['illness'];
    name = json['name'];
    objective = json['objective'];
    porte = json['porte'];
    requirements = json['requirements'] != null
        ? new Requirements.fromJson(json['requirements'])
        : null;
    sex = json['sex'];
    species = json['species'];
    temperament = json['temperament'];
    photo = json['photo'];
    user = json['user'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['about'] = this.about;
    data['age'] = this.age;
    data['carry'] = this.carry;
    data['health'] = this.health;
    data['illness'] = this.illness;
    data['name'] = this.name;
    data['objective'] = this.objective;
    data['porte'] = this.porte;
    if (this.requirements != null) {
      data['requirements'] = this.requirements!.toJson();
    }
    data['sex'] = this.sex;
    data['species'] = this.species;
    data['temperament'] = this.temperament;
    data['photo'] = this.photo;
    data['user'] = this.user;
    return data;
  }

  Animal copyWith({
    String? id,
    String? about,
    String? age,
    String? carry,
    String? health,
    String? illness,
    String? name,
    String? objective,
    String? porte,
    Requirements? requirements,
    String? sex,
    String? species,
    String? temperament
  }) {
    return Animal(
        id: this.id,
        about: this.about,
        age: this.age,
        carry: this.carry,
        health: this.health,
        illness: this.illness,
        name: this.name,
        objective: this.objective,
        porte: this.porte,
        requirements: this.requirements,
        sex: this.sex,
        species: this.species,
        temperament: this.temperament
    );
  }
}

class Requirements {
  String? accompaniment;
  bool? pictureHouse;
  bool? term;
  bool? visit;

  Requirements({this.accompaniment, this.pictureHouse, this.term, this.visit});

  Requirements.fromJson(Map<String, dynamic> json) {
    accompaniment = json['accompaniment'];
    pictureHouse = json['picture_house'];
    term = json['term'];
    visit = json['visit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accompaniment'] = this.accompaniment;
    data['picture_house'] = this.pictureHouse;
    data['term'] = this.term;
    data['visit'] = this.visit;
    return data;
  }
}