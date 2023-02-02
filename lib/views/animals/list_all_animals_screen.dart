import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';
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
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShowAnimal(
                              animal: animalController
                                  .animals[index])),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 5,
                      child: FutureBuilder<Object>(
                          future: animalController
                              .getFile(animalController.animals[index].photo),
                          builder: (context, snapshot) {
                            return !snapshot.hasData
                                ? FillImageCard(
                                    width: MediaQuery.of(context).size.width * 1,
                                    heightImage: 140,
                                    imageProvider:
                                        const AssetImage('assets/icone-pata.png'),
                                    tags: [
                                      _tag(animalController.animals[index].sex ?? "", () {}),
                                      _tag(animalController.animals[index].porte ?? "", () {}),
                                      _tag(animalController.animals[index].age ?? "", () {})
                                    ],
                                    title: _title(title: animalController.animals[index].name),
                                    description: _content(description: animalController.animals[index].about),
                                  )
                                : FillImageCard(
                                    width: MediaQuery.of(context).size.width * 1,
                                    heightImage: MediaQuery.of(context).size.height * 0.3,
                                    imageProvider:
                                        FileImage(snapshot.data! as File),
                                    tags: [
                                      _tag(animalController.animals[index].sex ?? "", () {}),
                                      _tag(animalController.animals[index].porte ?? "", () {}),
                                      _tag(animalController.animals[index].age ?? "", () {})
                                    ],
                                    title: _title(title: animalController.animals[index].name),
                                    description: _content(description: animalController.animals[index].about),
                                  );
                          }),
                    ),
                  ),
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

  Widget _title({String? title, Color? color}) {
    return Text(
      title ?? "",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    );
  }

  Widget _content({String? description, Color? color}) {
    return Text(
      description ?? "",
      style: TextStyle(color: color),
    );
  }

  Widget _footer({Color? color}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            'assets/avatar.png',
          ),
          radius: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
            child: Text(
          'Super user',
          style: TextStyle(color: color),
        )),
        IconButton(onPressed: () {}, icon: Icon(Icons.share))
      ],
    );
  }

  Widget _tag(String tag, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          tag,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
