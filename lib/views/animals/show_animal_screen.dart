import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/model/interested.dart';
import 'package:provider/provider.dart';
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
    // final animalController = Provider.of<AnimalController>(context, listen: false);

    interestedController.setLoading();

    interestedController.verifyExistance(widget.animal.id, authController.user.docID);

    interestedController.setLoading();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animalController = context.watch<AnimalController>();
    final interestedController = context.watch<InterestedController>();
    final authController = context.watch<AuthController>();

    const LinearProgressIndicator(
        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
        value: 3,
        valueColor: AlwaysStoppedAnimation(Colors.green));

    Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        "${widget.animal.sex![0].toString().toUpperCase()}${widget.animal.sex.toString().substring(1).toLowerCase()}",
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );

    final topContentText = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 105.0),
          Row(
            children: [
              const Icon(
                Icons.pets,
                color: Colors.white,
                size: 40.0,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${widget.animal.species![0].toString().toUpperCase()}${widget.animal.species.toString().substring(1).toLowerCase()}",
                style: TextStyle(
                    color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.05),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Text(
            widget.animal.name ?? "",
            style:
                TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.09),
          ),
          const SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1.5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "${widget.animal.sex![0].toString().toUpperCase()}${widget.animal.sex.toString().substring(1).toLowerCase()}",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1.5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "${widget.animal.porte![0].toString().toUpperCase()}${widget.animal.porte.toString().substring(1).toLowerCase()}",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 1.5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "${widget.animal.age![0].toString().toUpperCase()}${widget.animal.age.toString().substring(1).toLowerCase()}",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.animal.health?.contains("Castrado") == true
                                  ? Colors.green
                                  : Colors.red,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Castrado",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: widget.animal.health?.contains("Castrado") == true
                                ? TextDecoration.none
                                : TextDecoration.lineThrough),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.animal.health?.contains("Vermifugado") == true
                                  ? Colors.green
                                  : Colors.red,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Vermifugado",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: widget.animal.health?.contains("Vermifugado") == true
                                ? TextDecoration.none
                                : TextDecoration.lineThrough),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.animal.health?.contains("Vacinado") == true
                                  ? Colors.green
                                  : Colors.red,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Vacinado",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: widget.animal.health?.contains("Vacinado") == true
                                ? TextDecoration.none
                                : TextDecoration.lineThrough),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );

    final topContent = Stack(
      children: <Widget>[
        FutureBuilder(
            future: animalController.getFile(widget.animal.photo),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icone-pata.png'),
                        fit: BoxFit.cover,
                      ),
                    ));
              }
              return Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(snapshot.data! as File),
                      fit: BoxFit.fitHeight,
                    ),
                  ));
            }),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            padding: const EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
            child: Center(
              child: topContentText,
            ),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      widget.animal.about ?? "",
      style: const TextStyle(fontSize: 16.0),
    );
    Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          onPressed: () => {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(245, 169, 0, 1.0)),
          ),
          child: const Text("Adotar", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  children: [
                    const Text(
                      "Doenças: ",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.animal.illness.toString().isNotEmpty == true
                          ? widget.animal.illness?.split(';').join(',')
                              // .substring(
                              //     0,
                              //     (widget.animal.illness
                              //         ?.toString()
                              //         .lastIndexOf(';'))
                              // )
                              ??
                              "Nenhuma"
                          : "Nenhuma",
                      style: const TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  children: [
                    const Text(
                      "Temperamento: ",
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  widget.animal.temperament.toString().isNotEmpty == true
                      ? widget.animal.temperament?.split(';').join(',').substring(
                              0, (widget.animal.temperament?.toString().lastIndexOf(';'))) ??
                          "Nada a dizer"
                      : "Nada a dizer",
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Exigencias do doador: ",
                          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
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
                            "SEM tempo de acompanhamento",
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
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Prazer, sou ${widget.animal.name}: ",
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              bottomContentText,
              // readButton,
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
                            docId: docInterested.id,
                            animalId: "animal/${widget.animal.id}",
                            ownerId: widget.animal.user,
                            interestedId: "user/${authController.user.docID}",
                          );
                          print(interested.toJson());
                          await docInterested.set(interested.toJson());
                          await animalController.sendNotification(
                              widget.animal.user, widget.animal);
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
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
              )
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      // appBar: AppBarComponent(
      //   appBar: AppBar(),
      //   title: "${widget.animal.name}",
      // ),
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
      // SingleChildScrollView(
      //   child: Column(
      //     children: <Widget>[
      //       Container(
      //         height: 285,
      //         width: 380,
      //         decoration: BoxDecoration(
      //           color: const Color(0xfff1f2f2),
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         child: FutureBuilder<File>(
      //           future: animalController.getFile(widget.animal.photo),
      //           builder: (context, snapshot) {
      //             if (!snapshot.hasData) {
      //               return Container();
      //             } // or some other placeholder
      //             return Image.file(snapshot.data!);
      //           },
      //         ),
      //       ),
      //       Container(
      //         alignment: Alignment.topLeft,
      //         padding: const EdgeInsets.only(left: 15),
      //         margin: const EdgeInsets.only(bottom: 10, top: 10),
      //         child: Text(
      //           widget.animal.name ?? "",
      //           textAlign: TextAlign.center,
      //           style: const TextStyle(
      //             color: Color(0xff434343),
      //             fontSize: 25,
      //           ),
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
      //         padding: const EdgeInsets.only(left: 20),
      //         alignment: Alignment.topLeft,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             Text("${widget.animal.name} precisa de ${widget.animal.objective}",
      //                 style: const TextStyle(
      //                   color: Color(0xff434343),
      //                   fontSize: 16,
      //                 )),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         alignment: Alignment.topLeft,
      //         margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20, left: 20),
      //         child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text("Sexo", style: TextStyle(fontSize: 16)),
      //               Text(widget.animal.sex ?? "", style: const TextStyle(fontSize: 16)),
      //             ],
      //           ),
      //           Container(
      //             margin: const EdgeInsets.only(right: 80),
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text("Porte", style: TextStyle(fontSize: 16)),
      //               Text(widget.animal.porte ?? "", style: const TextStyle(fontSize: 16)),
      //             ],
      //           ),
      //           Container(
      //             margin: const EdgeInsets.only(right: 80),
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text("Idade", style: TextStyle(fontSize: 16)),
      //               Text(widget.animal.age ?? "", style: const TextStyle(fontSize: 16)),
      //             ],
      //           ),
      //         ]),
      //       ),
      //       Container(
      //         alignment: Alignment.topLeft,
      //         margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20, left: 20),
      //         child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text("Castrado", style: TextStyle(fontSize: 16)),
      //               widget.animal.health?.contains("Castrado") == true
      //                   ? const Text("Sim", style: TextStyle(fontSize: 16))
      //                   : const Text("Não", style: TextStyle(fontSize: 16)),
      //             ],
      //           ),
      //           Container(
      //             margin: const EdgeInsets.only(right: 60),
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text("Vermifugado", style: TextStyle(fontSize: 16)),
      //               widget.animal.health?.contains("Vermifugado") == true
      //                   ? const Text("Sim", style: TextStyle(fontSize: 16))
      //                   : const Text("Não", style: TextStyle(fontSize: 16)),
      //             ],
      //           ),
      //           Container(
      //             margin: const EdgeInsets.only(right: 35),
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text("Vacinado", style: TextStyle(fontSize: 16)),
      //               widget.animal.health?.contains("Vacinado") == true
      //                   ? const Text("Sim", style: TextStyle(fontSize: 16))
      //                   : const Text("Não", style: TextStyle(fontSize: 16)),
      //             ],
      //           ),
      //         ]),
      //       ),
      //       Container(
      //         alignment: Alignment.topLeft,
      //         margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20, left: 20),
      //         child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Text("Doenças", style: TextStyle(fontSize: 16)),
      //               widget.animal.illness != ''
      //                   ? Text(widget.animal.illness ?? "", style: const TextStyle(fontSize: 16))
      //                   : const Text("Nenhuma", style: TextStyle(fontSize: 16))
      //             ],
      //           ),
      //         ]),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
      //         padding: const EdgeInsets.only(left: 20),
      //         alignment: Alignment.topLeft,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             const Text("Temperamento", style: TextStyle(fontSize: 16)),
      //             if (widget.animal.temperament?.contains("Brincalhão") == true)
      //               const Text("Brincalhão", style: TextStyle(fontSize: 16)),
      //             if (widget.animal.temperament?.contains("Guarda") == true)
      //               const Text("Guarda", style: TextStyle(fontSize: 16)),
      //             if (widget.animal.temperament?.contains("Amoroso") == true)
      //               const Text("Amoroso", style: TextStyle(fontSize: 16)),
      //             if (widget.animal.temperament?.contains("Preguiçoso") == true)
      //               const Text("Preguiçoso", style: TextStyle(fontSize: 16)),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
      //         padding: const EdgeInsets.only(left: 20),
      //         alignment: Alignment.topLeft,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             const Text("Exigências do doador", style: TextStyle(fontSize: 16)),
      //             if (widget.animal.requirements?.accompaniment == 'one')
      //               const Text(
      //                 "Tempo de acompanhamento: Um mês",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //             if (widget.animal.requirements?.accompaniment == 'three')
      //               const Text(
      //                 "Tempo de acompanhamento: Três meses",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //             if (widget.animal.requirements?.accompaniment == 'six')
      //               const Text(
      //                 "Tempo de acompanhamento: Seis meses",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //             if (widget.animal.requirements?.accompaniment == 'not')
      //               const Text(
      //                 "Não é necessário tempo de acompanhamento",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //             if (widget.animal.requirements?.pictureHouse == true)
      //               const Text(
      //                 "Fotos da Casa",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //             if (widget.animal.requirements?.term == true)
      //               const Text(
      //                 "Assinatura do termo",
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         margin: const EdgeInsets.only(bottom: 10, top: 10, right: 20),
      //         padding: const EdgeInsets.only(left: 20),
      //         alignment: Alignment.topLeft,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text("Mais sobre o ${widget.animal.name}:",
      //                 style: const TextStyle(
      //                   color: Color(0xff434343),
      //                   fontSize: 16,
      //                 )),
      //             Text(
      //               widget.animal.about ?? "",
      //               style: const TextStyle(fontSize: 16),
      //             ),
      //           ],
      //         ),
      //       ),

      //     ],
      //   ),
      // ),
    );
  }
}
