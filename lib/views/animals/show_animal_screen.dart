import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/model/interested.dart';
import 'package:provider/provider.dart';
import '../../components/app_bar_component.dart';
import '../../model/animal.dart';

class ShowAnimal extends StatefulWidget {
  const ShowAnimal({Key? key, required animal}) : super(key: key);

  @override
  State<ShowAnimal> createState() => _ShowAnimalState();
}

class _ShowAnimalState extends State<ShowAnimal> {
  final animalController = AnimalController();
  final animal = Animal();
  Interested interested = Interested();
  bool loadingButtonAdopt = false;

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    return Scaffold(
      appBar: AppBarComponent(
        appBar: AppBar(),
        title: "${animal.name}",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 285,
              width: 380,
              decoration: BoxDecoration(
                color: const Color(0xfff1f2f2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: FutureBuilder<File>(
                future: animalController.getFile(animal.photo),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } // or some other placeholder
                  return Image.file(snapshot.data!);
                },
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 15),
              margin: const EdgeInsets.only(bottom: 10, top: 10),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${animal.name} precisa de ${animal.objective}",
                      style: const TextStyle(
                        color: Color(0xff434343),
                        fontSize: 16,
                      )),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 10, right: 20, left: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sexo", style: TextStyle(fontSize: 16)),
                    Text(animal.sex ?? "",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 80),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Porte", style: TextStyle(fontSize: 16)),
                    Text(animal.porte ?? "",
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 80),
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
              margin: const EdgeInsets.only(
                  bottom: 10, top: 10, right: 20, left: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Castrado", style: TextStyle(fontSize: 16)),
                    animal.health?.contains("Castrado") == true
                        ? const Text("Sim", style: TextStyle(fontSize: 16))
                        : const Text("Não", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 60),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Vermifugado", style: TextStyle(fontSize: 16)),
                    animal.health?.contains("Vermifugado") == true
                        ? const Text("Sim", style: TextStyle(fontSize: 16))
                        : const Text("Não", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 35),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Vacinado", style: TextStyle(fontSize: 16)),
                    animal.health?.contains("Vacinado") == true
                        ? const Text("Sim", style: TextStyle(fontSize: 16))
                        : const Text("Não", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ]),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(
                  bottom: 10, top: 10, right: 20, left: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Doenças", style: TextStyle(fontSize: 16)),
                    animal.illness != ''
                        ? Text(animal.illness ?? "",
                            style: const TextStyle(fontSize: 16))
                        : const Text("Nenhuma", style: TextStyle(fontSize: 16))
                  ],
                ),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Temperamento", style: TextStyle(fontSize: 16)),
                  if (animal.temperament?.contains("Brincalhão") == true)
                    const Text("Brincalhão", style: TextStyle(fontSize: 16)),
                  if (animal.temperament?.contains("Guarda") == true)
                    const Text("Guarda", style: TextStyle(fontSize: 16)),
                  if (animal.temperament?.contains("Amoroso") == true)
                    const Text("Amoroso", style: TextStyle(fontSize: 16)),
                  if (animal.temperament?.contains("Preguiçoso") == true)
                    const Text("Preguiçoso", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Exigências do doador",
                      style: TextStyle(fontSize: 16)),
                  if (animal.requirements?.accompaniment == 'one')
                    const Text(
                      "Tempo de acompanhamento: Um mês",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (animal.requirements?.accompaniment == 'three')
                    const Text(
                      "Tempo de acompanhamento: Três meses",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (animal.requirements?.accompaniment == 'six')
                    const Text(
                      "Tempo de acompanhamento: Seis meses",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (animal.requirements?.accompaniment == 'not')
                    const Text(
                      "Não é necessário tempo de acompanhamento",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (animal.requirements?.pictureHouse == true)
                    const Text(
                      "Fotos da Casa",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (animal.requirements?.term == true)
                    const Text(
                      "Assinatura do termo",
                      style: TextStyle(fontSize: 16),
                    ),
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
                onPressed: () async {
                  final docInterested =
                      FirebaseFirestore.instance.collection('interested').doc();
                  setState(() {
                    loadingButtonAdopt = true;
                  });
                  interested = Interested(
                    animalid: animal.id,
                    ownerid: animal.user,
                    interestedid: "user/${authController.user.docID}",
                  );
                  await docInterested.set(interested.toJson());
                  setState(() {
                    loadingButtonAdopt = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Informamos o dono do animal, em breve vocês estarão em contato'),
                  ));
                },
                child: loadingButtonAdopt
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
