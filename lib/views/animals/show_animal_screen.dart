import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:meau/controllers/animal/animal_controller.dart';
import '../../components/app_bar_component.dart';
import '../../model/animal.dart';

class ShowAnimal extends StatelessWidget {
  ShowAnimal({Key? key, required this.animal}) : super(key: key);
  final animalController = AnimalController();
  final Animal animal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        appBar: AppBar(),
        title: "${animal.name}",
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: 380,
            decoration: BoxDecoration(
              color: const Color(0xfff1f2f2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: FutureBuilder<File>(
              future: animalController.getFile(animal.photo),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Container(); // or some other placeholder
                return new Image.file(snapshot.data!);
              },
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15),
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              animal.name ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff434343),
                fontSize: 25,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Sexo"),
                      Text(animal.sex ?? ""),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Porte"),
                      Text(animal.porte ?? ""),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Idade"),
                      Text(animal.age ?? ""),
                    ],
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Localização"),
                  Text("####"),
                ],
              ),
            ]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Castrado"),
                      Text(animal.illness ?? ""),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Vermifugado"),
                      Text(animal.illness ?? ""),
                    ],
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Vacinado"),
                      Text(animal.illness ?? ""),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Doenças"),
                      Text(animal.illness ?? ""),
                    ],
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Temperamento"),
                Text(animal.temperament ?? ""),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("O ${animal.name} precisa de",
                    style: const TextStyle(
                      color: Color(0xff434343),
                      fontSize: 15,
                    )),
                Text(animal.objective ?? ""),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Exigências do doador"),
                const Text(""),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
            padding: const EdgeInsets.only(left: 20),
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Mais sobre o ${animal.name}",
                    style: const TextStyle(
                      color: Color(0xff434343),
                      fontSize: 15,
                    )),
                Text(animal.about ?? ""),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
