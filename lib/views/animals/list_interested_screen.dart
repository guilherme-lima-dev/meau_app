import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
import 'package:meau/controllers/interested/interested_controller.dart';
import 'package:provider/provider.dart';

import '../../components/app_bar_component.dart';
import '../../controllers/user/auth_controller.dart';

class ListInterestedSreen extends StatefulWidget {
  const ListInterestedSreen({Key? key}) : super(key: key);

  @override
  State<ListInterestedSreen> createState() => _ListInterestedSreenState();
}

class _ListInterestedSreenState extends State<ListInterestedSreen> {
  @override
  void initState() {
    final interestedController = Provider.of<InterestedController>(context, listen: false);
    final authController = Provider.of<AuthController>(context, listen: false);

    interestedController.setLoading();

    interestedController.getAll(authController.user.docID);
    // Future.delayed(Duration.zero, () async {
    // });

    interestedController.setLoading();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final interestedController = context.watch<InterestedController>();
    final animalController = context.watch<AnimalController>();
    bool loadingButtonAccept = false;
    bool loadingButtonRefuse = false;

    const IconData pets = IconData(0xe4a1, fontFamily: 'MaterialIcons');
    const IconData person = IconData(0xe252, fontFamily: 'MaterialIcons');

    return Scaffold(
      appBar: AppBarComponent(
        appBar: AppBar(),
        title: "Interessados",
      ),
      body: interestedController.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: interestedController.interesteds.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  margin: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                  color: const Color(0xfffee29b),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 120,
                                  width: 120,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xfffee29b),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: interestedController.interesteds[index].animal!.photo ==
                                          null //Alterar aqui para == null
                                      ? Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: const Color(0xfff1f2f2),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: const Icon(pets))
                                      : Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: const Color(0xfffee29b),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: FutureBuilder<File>(
                                            future: animalController.getFile(interestedController
                                                .interesteds[index].animal!.photo),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } // or some other placeholder
                                              return Image.file(snapshot.data!);
                                            },
                                          ),
                                        )),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  interestedController.interesteds[index].animal!.name ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff434343),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 120,
                                  width: 120,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xfffee29b),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: interestedController.interesteds[index].animal!.photo ==
                                          null //Alterar aqui para == null
                                      ? Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: const Color(0xfff1f2f2),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: const Icon(person))
                                      : Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: const Color(0xfffee29b),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: FutureBuilder<File>(
                                            future: animalController.getFile(interestedController
                                                .interesteds[index].interested!.photo),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return Container();
                                              } // or some other placeholder
                                              return Image.file(snapshot.data!);
                                            },
                                          ),
                                        )),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  interestedController.interesteds[index].interested!.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xff434343),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xFF00FF00),
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                loadingButtonAccept = true;
                              });

                              print(interestedController.interesteds[index].interested?.docID);
                              // //Trocar dono
                              animalController.changeOwner(
                                  interestedController.interesteds[index].animal!.id!,
                                  interestedController.interesteds[index].interested?.docID);

                              // //Apagar todos os interessados nesse animal
                              interestedController.removeAllInterestedInThisAnimal(
                                  interestedController.interesteds[index].animal!.id!);

                              // //Notificar interessado

                              setState(() {
                                loadingButtonAccept = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content:
                                    Text('Já estamos finalizando o processo de adoção, aguarde!'),
                              ));
                            },
                            child: loadingButtonAccept
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 3,
                                  )
                                : const Text(
                                    "Aceitar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xFFFF0000),
                              borderRadius: BorderRadius.circular(20)),
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                loadingButtonAccept = true;
                              });
                              print("NOTIFICAR INTERESSADO");
                              print("APAGAR ESSE REGISTRO DE INTERESSE");

                              interestedController.removeThisInterested(
                                  interestedController.interesteds[index].animal!.id!,
                                  interestedController.interesteds[index].interested?.docID);

                              setState(() {
                                loadingButtonAccept = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Tudo bem, vamos continuar procurando!'),
                              ));
                            },
                            child: loadingButtonAccept
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    strokeWidth: 3,
                                  )
                                : const Text(
                                    "Recusar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                          ),
                        ),
                      ])
                    ],
                  ),
                );
              },
            ),
    );
  }
}
