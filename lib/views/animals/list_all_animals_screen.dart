import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/views/animals/show_animal_screen.dart';
import 'package:provider/provider.dart';

class ListAllAnimalsScreen extends StatefulWidget {
  const ListAllAnimalsScreen({Key? key}) : super(key: key);

  @override
  _ListAllAnimalsScreenState createState() => _ListAllAnimalsScreenState();
}

class _ListAllAnimalsScreenState extends State<ListAllAnimalsScreen> {
  @override
  void initState() {
    final animalcontroller =
        Provider.of<AnimalController>(context, listen: false);
    animalcontroller.setLoading();
    animalcontroller.getAnimals();
    animalcontroller.setLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final animalController = context.watch<AnimalController>();
    final authController = context.watch<AuthController>();
    const IconData pets = IconData(0xe4a1, fontFamily: 'MaterialIcons');
    return Scaffold(
      appBar: AppBarComponent(
        appBar: AppBar(),
        title: animalController.todos ? "Todos os animais" : "Meus animais",
      ),
      body: animalController.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: animalController.animals.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 5, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xfffee29b),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        animalController.animals[index].name ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xff434343),
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(
                          minWidth: 100,
                          minHeight: 100,
                          maxWidth: double.infinity,
                          maxHeight: 230,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xfffee29b),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: animalController.animals[index].photo == null
                            ? Container(
                                constraints: const BoxConstraints(
                                  minWidth: double.infinity,
                                  minHeight: 230,
                                  maxWidth: double.infinity,
                                  maxHeight: double.infinity,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xfff1f2f2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(pets))
                            : GestureDetector(
                                onTap: () {
                                  print(
                                      animalController.animals[index].toJson());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowAnimal(
                                            animal: animalController
                                                .animals[index])),
                                  );
                                  print(animalController.animals[index].name);
                                },
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
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(animalController.animals[index].sex ?? "",
                                style: const TextStyle(fontSize: 16)),
                            Container(
                              margin: const EdgeInsets.only(right: 80),
                            ),
                            Text(animalController.animals[index].porte ?? "",
                                style: const TextStyle(fontSize: 16)),
                            Container(
                              margin: const EdgeInsets.only(right: 80),
                            ),
                            Text(animalController.animals[index].age ?? "",
                                style: const TextStyle(fontSize: 16)),
                          ]),
                    ),
                  ]),
                );
              }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
            child: FloatingActionButton.extended(
              // backgroundColor: Colors.red,
              isExtended: true,
              label: const Text(
                "Todos",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.border_all,
                size: MediaQuery.of(context).size.width * 0.08,
                color: Colors.white,
              ),
              onPressed: () async {
                animalController.setLoading();
                await animalController.getAnimals();
                animalController.setLoading();
                animalController.setTodos(true);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.02),
            child: FloatingActionButton.extended(
              // backgroundColor: Colors.green,
              label: const Text("Meus pets",
                  style: TextStyle(color: Colors.white)),
              icon: Icon(
                Icons.pets,
                size: MediaQuery.of(context).size.width * 0.1,
                color: Colors.white,
              ),
              onPressed: () async {
                animalController.setLoading();
                await animalController
                    .getUserAnimals(authController.user.docID);
                animalController.setLoading();
                animalController.setTodos(false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
