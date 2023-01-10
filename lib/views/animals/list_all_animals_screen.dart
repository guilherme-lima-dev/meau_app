import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/controllers/animal/animal_controller.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/model/animal.dart';
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
    return Scaffold(
      appBar: AppBarComponent(
        appBar: AppBar(),
        title: animalController.todos ? "Todos os animais" : "Meus animais",
      ),
      body: animalController.loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: animalController.animals.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(10.0),
                  leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: animalController.animals[index].photo == null
                          ? Image.network(
                              "https://img.lovepik.com/free_png/32/23/59/70358PIC95iAmhU4dc0VY_PIC2018.png_860.png",
                              fit: BoxFit.cover)
                          : FutureBuilder<File>(
                              future: animalController.getFile(
                                  animalController.animals[index].photo),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Container(); // or some other placeholder
                                return new Image.file(snapshot.data!);
                              },
                            )),
                  title: Text(animalController.animals[index].name ?? ""),
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
              label: Text(
                "Todos",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.border_all,
                size: MediaQuery.of(context).size.width * 0.08,
                color: Colors.white,
              ),
              onPressed: () async{
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
              label: Text("Meus pets", style: TextStyle(color: Colors.white)),
              icon: Icon(
                Icons.pets,
                size: MediaQuery.of(context).size.width * 0.1,
                color: Colors.white,
              ),
              onPressed: () async{
                animalController.setLoading();
                await animalController.getUserAnimals(authController.user.docID);
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
