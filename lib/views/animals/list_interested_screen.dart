import 'dart:io';

import 'package:flutter/material.dart';
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
    final interestedController =
        Provider.of<InterestedController>(context, listen: false);
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

    const IconData pets = IconData(0xe4a1, fontFamily: 'MaterialIcons');
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
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(
                      bottom: 10, top: 10, left: 10, right: 10),
                  color: const Color(0xfffee29b),
                  child: Column(
                    children: [
                      Row(children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xfffee29b),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: interestedController.interesteds[index].animal!.photo !=
                                    null //Alterar aqui para == null
                                ? Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff1f2f2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Icon(pets))
                                : Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: const Color(0xfff1f2f2),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: FutureBuilder<File>(
                                      future: animalController.getFile(
                                          interestedController.interesteds[index].animal!.photo),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        } // or some other placeholder
                                        return Image.file(snapshot.data!);
                                      },
                                    ),
                                  )),
                        Column(
                          children: [
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
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text("INTERESSADO: ",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Color(0xff434343),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
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
                                )
                              ],
                            )
                          ],
                        ),
                      ]),
                    ],
                  ),
                );
              }),
    );
  }
}
