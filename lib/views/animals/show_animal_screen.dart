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
  bool loadingButtonRegister = false;

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
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sexo", style: TextStyle(fontSize: 16)),
                        Text(animal.sex ?? "",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Porte", style: TextStyle(fontSize: 16)),
                        Text(animal.porte ?? "",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Idade", style: TextStyle(fontSize: 16)),
                        Text(animal.age ?? "",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ]),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Castrado", style: TextStyle(fontSize: 16)),
                        Text(animal.illness ?? "",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Vermifugado",
                            style: TextStyle(fontSize: 16)),
                        Text(animal.illness ?? "",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ]),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Vacinado", style: TextStyle(fontSize: 16)),
                        Text(animal.illness ?? "",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Doenças", style: TextStyle(fontSize: 16)),
                        Text(animal.illness ?? "",
                            style: const TextStyle(fontSize: 16)),
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
                children: const [
                  Text("Exigências do doador", style: TextStyle(fontSize: 16)),
                  Text(""),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mais sobre o ${animal.name}:",
                      style: const TextStyle(
                        color: Color(0xff434343),
                        fontSize: 16,
                      )),
                  Text(
                    animal.about ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color(0xffF5A900),
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextButton(
                onPressed: () {
                  print('Apertou');
                },
                child: loadingButtonRegister
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3,
                      )
                    : const Text(
                        "Adotar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
