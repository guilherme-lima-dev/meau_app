import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/controllers/auth_controller.dart';
import 'package:meau/services/auth_service.dart';
import 'package:meau/views/auth/login_screen.dart';
import 'package:meau/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class RegisterAnimalScreen extends StatefulWidget {
  const RegisterAnimalScreen({Key? key}) : super(key: key);

  @override
  State<RegisterAnimalScreen> createState() => _RegisterAnimalScreenState();
}

class _RegisterAnimalScreenState extends State<RegisterAnimalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  int value = 0;

  Widget CustomRadioButton(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
          });
        },
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
              color: (value == index) ? const Color(0xffF5A900) : Colors.black),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? const Color(0xffF5A900) : Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    return Scaffold(
      appBar: AppBarComponent(
        title: "Cadastro de Pet",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                height: 21,
              ),
              const Text(
                "Tenho interesse em cadastrar o animal para:",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
                selectionColor: Color(0Xff757575),
              ),
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRadioButton("ADOÇÃO", 0),
                  CustomRadioButton("APADRINHAR", 1),
                  CustomRadioButton("AJUDA", 2),
                ],
              ),
              Container(
                height: 10,
              ),
              if (value == 0)
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Adoção",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 21, color: Color(0xff434343)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'NOME DO ANIMAL',
                            hintText: 'Digite um nome válido, Ex: Belinha'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Espécie",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Cachorro"),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Gato"),
                      ],
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text("Sexo",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Color(0xfff7a800)),
                            selectionColor: Color(0Xff434343))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Macho"),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Fêmea"),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Porte",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Pequeno"),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Médio"),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Grande"),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Idade",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Filhote"),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Adulto"),
                        Radio(
                            value: "radio value",
                            groupValue: "group value",
                            onChanged: (value) {
                              print(value); //selected value
                            }),
                        const Text("Idoso"),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Temperamento",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Brincalhão"),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Tímido"),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Calmo"),
                      ],
                    ),
                    Row(
                      //Aqui pode ser usado o Wrap
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Guarda"),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Amoroso"),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Preguiçoso"),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Saúde",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Vacinado"),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Vermifugado"),
                      ],
                    ),
                    Row(
                      //Aqui pode ser usado o Wrap
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Castrado"),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Color(0xfff4a800),
                          value: false,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const Text("Doente"),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Necessidades do Animal",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: false,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            const Text("Alimento"),
                          ]),
                          Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: false,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            const Text("Auxílio financeiro"),
                          ]),
                          Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: false,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            const Text("Medicamento"),
                          ]),
                          Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: false,
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                            const Text("Objetos"),
                          ]),
                        ]),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Sobre o Animal",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    //   Checkbox(
                    //     checkColor: Colors.white,
                    //     activeColor: Color(0xfff4a800),
                    //     value: false,
                    //     onChanged: (value) {
                    //       print(value);
                    //     },
                    //   ),
                    //   const Text("Vacinado"),
                    // ]),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
