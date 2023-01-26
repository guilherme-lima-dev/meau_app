import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/model/interested.dart';
import 'package:provider/provider.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/model/animal.dart';
import 'package:meau/controllers/interested/interested_controller.dart';

class ShowAnimal extends StatefulWidget {
  final Animal animal;
  const ShowAnimal({Key? key, required this.animal}) : super(key: key);

  @override
  State<ShowAnimal> createState() => _ShowAnimalState();
}

class _ShowAnimalState extends State<ShowAnimal> {
  Interested interested = Interested();
  bool loadingButtonAdopt = false;
  // bool canAdopt = true;

  @override
  void initState() {
    final interestedController = Provider.of<InterestedController>(context, listen: false);
    final authController = Provider.of<AuthController>(context, listen: false);
    final animalController = Provider.of<AnimalController>(context, listen: false);

    interestedController.setLoading();

    interestedController.verifyExistance(authController.user.docID, widget.animal.id);

    interestedController.setLoading();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animalController = context.watch<AnimalController>();
    final interestedController = context.watch<InterestedController>();
    final authController = context.watch<AuthController>();

    return Scaffold(
      appBar: AppBarComponent(
        appBar: AppBar(),
        title: "${widget.animal.name}",
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
                future: animalController.getFile(widget.animal.photo),
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
                widget.animal.name ?? "",
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
                  Text("${widget.animal.name} precisa de ${widget.animal.objective}",
                      style: const TextStyle(
                        color: Color(0xff434343),
                        fontSize: 16,
                      )),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20, left: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sexo", style: TextStyle(fontSize: 16)),
                    Text(widget.animal.sex ?? "", style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 80),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Porte", style: TextStyle(fontSize: 16)),
                    Text(widget.animal.porte ?? "", style: const TextStyle(fontSize: 16)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 80),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Idade", style: TextStyle(fontSize: 16)),
                    Text(widget.animal.age ?? "", style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ]),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20, left: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Castrado", style: TextStyle(fontSize: 16)),
                    widget.animal.health?.contains("Castrado") == true
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
                    widget.animal.health?.contains("Vermifugado") == true
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
                    widget.animal.health?.contains("Vacinado") == true
                        ? const Text("Sim", style: TextStyle(fontSize: 16))
                        : const Text("Não", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ]),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20, left: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Doenças", style: TextStyle(fontSize: 16)),
                    widget.animal.illness != ''
                        ? Text(widget.animal.illness ?? "", style: const TextStyle(fontSize: 16))
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
                  if (widget.animal.temperament?.contains("Brincalhão") == true)
                    const Text("Brincalhão", style: TextStyle(fontSize: 16)),
                  if (widget.animal.temperament?.contains("Guarda") == true)
                    const Text("Guarda", style: TextStyle(fontSize: 16)),
                  if (widget.animal.temperament?.contains("Amoroso") == true)
                    const Text("Amoroso", style: TextStyle(fontSize: 16)),
                  if (widget.animal.temperament?.contains("Preguiçoso") == true)
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
                  const Text("Exigências do doador", style: TextStyle(fontSize: 16)),
                  if (widget.animal.requirements?.accompaniment == 'one')
                    const Text(
                      "Tempo de acompanhamento: Um mês",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (widget.animal.requirements?.accompaniment == 'three')
                    const Text(
                      "Tempo de acompanhamento: Três meses",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (widget.animal.requirements?.accompaniment == 'six')
                    const Text(
                      "Tempo de acompanhamento: Seis meses",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (widget.animal.requirements?.accompaniment == 'not')
                    const Text(
                      "Não é necessário tempo de acompanhamento",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (widget.animal.requirements?.pictureHouse == true)
                    const Text(
                      "Fotos da Casa",
                      style: TextStyle(fontSize: 16),
                    ),
                  if (widget.animal.requirements?.term == true)
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
                  Text("Mais sobre o ${widget.animal.name}:",
                      style: const TextStyle(
                        color: Color(0xff434343),
                        fontSize: 16,
                      )),
                  Text(
                    widget.animal.about ?? "",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: interestedController.canAdopt &&
                      ("user/$widget.animal.user" != authController.user.docID)
                  ? BoxDecoration(
                      color: const Color(0xffF5A900), borderRadius: BorderRadius.circular(20))
                  : BoxDecoration(
                      color: const Color(0xff909090), borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: interestedController.canAdopt &&
                      ("user/$widget.animal.user" != authController.user.docID)
                  ? TextButton(
                      onPressed: () async {
                        final docInterested =
                            FirebaseFirestore.instance.collection('interested').doc();
                        setState(() {
                          loadingButtonAdopt = true;
                        });
                        interested = Interested(
                          animalId: "animal/${widget.animal.id}",
                          ownerId: widget.animal.user,
                          interestedId: "user/${authController.user.docID}",
                        );
                        print(interested.toJson());
                        await docInterested.set(interested.toJson());
                        await animalController.sendNotification(widget.animal.user, widget.animal);
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
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                    )
                  : const Text(
                      "Você já sinalizou interesse por esse animal",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
