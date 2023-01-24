import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
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
    final animalcontroller =
        Provider.of<AnimalController>(context, listen: false);
    final authController = Provider.of<AuthController>(context, listen: false);

    animalcontroller.setLoading();
    Future.delayed(Duration.zero, () async {
      animalcontroller.getUserAnimals(authController.user.docID);
    });
    animalcontroller.setLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final animalController = context.watch<AnimalController>();

    const IconData pets = IconData(0xe4a1, fontFamily: 'MaterialIcons');
    return Scaffold(
      appBar: AppBarComponent(
        appBar: AppBar(),
        title: "Interessados",
      ),
      body: animalController.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: animalController.animals.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(
                      bottom: 10, top: 10, left: 10, right: 10),
                  color: const Color(0xfffee29b),
                  child: Row(children: <Widget>[
                    Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xfffee29b),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: animalController.animals[index].photo !=
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
                                      animalController.animals[index].photo),
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
                        animalController.animals[index].name ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xff434343),
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ]),
                );
              }),
    );
  }
}
