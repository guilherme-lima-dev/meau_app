import 'dart:io';
import 'package:flutter/material.dart';
import 'package:meau/chat/chatpage.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
import 'package:meau/controllers/interested/interested_controller.dart';
import 'package:provider/provider.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/controllers/user/auth_controller.dart';

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
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChatPage(
                              id: interestedController.interesteds[index].interested!.docID
                                  .toString(),
                              name: interestedController.interesteds[index].interested!.name);
                        },
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 10, top: 10, left: 10, right: 10),
                    elevation: 5,
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
                                      color: const Color(0xffffffff),
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
                                        : FutureBuilder<File>(
                                            future: animalController.getFile(interestedController
                                                .interesteds[index].interested!.photo),
                                            builder: (context, snapshot) {
                                              return Container(
                                                height: 120,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  border:
                                                      Border.all(color: Colors.black, width: 0.7),
                                                  color: const Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(100),
                                                  image: !snapshot.hasData
                                                      ? const DecorationImage(
                                                          image:
                                                              AssetImage('assets/icone-pata.png'),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : DecorationImage(
                                                          image: FileImage(snapshot.data!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              );
                                            })),
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
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 18,
                            ),
                            Column(
                              children: [
                                Container(
                                    alignment: Alignment.center,
                                    height: 120,
                                    width: 120,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
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
                                        : FutureBuilder<File>(
                                            future: animalController.getFile(interestedController
                                                .interesteds[index].animal!.photo),
                                            builder: (context, snapshot) {
                                              return Container(
                                                height: 120,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  border:
                                                      Border.all(color: Colors.black, width: 0.7),
                                                  color: const Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(100),
                                                  image: !snapshot.hasData
                                                      ? const DecorationImage(
                                                          image:
                                                              AssetImage('assets/icone-pata.png'),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : DecorationImage(
                                                          image: FileImage(snapshot.data!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                              );
                                            })),
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
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.green, borderRadius: BorderRadius.circular(20)),
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
                                          fontSize: 18),
                                    ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.red, borderRadius: BorderRadius.circular(20)),
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
                                          fontSize: 18),
                                    ),
                            ),
                          ),
                        ]),
                        Center(
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                                color: const Color(0xffF5A900),
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ChatPage(
                                          id: interestedController
                                              .interesteds[index].interested!.docID
                                              .toString(),
                                          name: interestedController
                                              .interesteds[index].interested!.name);
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                "Enviar mensagem",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Widget _title({String? title, Color? color}) {
  //   return Text(
  //     title ?? "",
  //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
  //   );
  // }

  // Widget _content({String? description, Color? color}) {
  //   return Text(
  //     description ?? "",
  //     style: TextStyle(color: color),
  //   );
  // }

  // Widget _footer({Color? color}) {
  //   return Row(
  //     children: [
  //       const CircleAvatar(
  //         backgroundImage: AssetImage(
  //           'assets/avatar.png',
  //         ),
  //         radius: 12,
  //       ),
  //       const SizedBox(
  //         width: 4,
  //       ),
  //       Expanded(
  //           child: Text(
  //         'Super user',
  //         style: TextStyle(color: color),
  //       )),
  //       IconButton(onPressed: () {}, icon: const Icon(Icons.share))
  //     ],
  //   );
  // }

  // Widget _tag(String tag, VoidCallback onPressed) {
  //   return InkWell(
  //     onTap: onPressed,
  //     child: Container(
  //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.green),
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //       child: Text(
  //         tag,
  //         style: const TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }
}
