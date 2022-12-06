import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/controllers/auth_controller.dart';
import 'package:meau/services/auth_service.dart';
import 'package:meau/views/auth/login_screen.dart';
import 'package:meau/views/home/home_screen.dart';
import 'package:provider/provider.dart';

enum Especie { cachorro, gato }

enum Sexo { macho, femea }

enum Porte { pequeno, medio, grande }

enum Idade { filhote, adulto, idoso }

class RegisterAnimalScreen extends StatefulWidget {
  const RegisterAnimalScreen({Key? key}) : super(key: key);

  @override
  State<RegisterAnimalScreen> createState() => _RegisterAnimalScreenState();
}

class _RegisterAnimalScreenState extends State<RegisterAnimalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final diseaseController = TextEditingController();
  final medicineController = TextEditingController();
  final objectsController = TextEditingController();
  final aboutanimalController = TextEditingController();

  int value = 0;

  Especie especie = Especie.cachorro;
  Sexo sexo = Sexo.macho;
  Porte porte = Porte.pequeno;
  Idade idade = Idade.filhote;

  bool brincalhaoValue = false;
  bool timidoValue = false;
  bool calmoValue = false;
  bool guardaValue = false;
  bool amorosoValue = false;
  bool preguicosoValue = false;

  bool vacinadoValue = false;
  bool vermifugadoValue = false;
  bool castradoValue = false;
  bool doenteValue = false;

  bool termoValue = false;
  bool fotosValue = false;
  bool visitaValue = false;
  bool acompanhamentoValue = false;

  bool tempo1Acompanhamento = false;
  bool tempo3Acompanhamento = false;
  bool tempo6Acompanhamento = false;

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
                      child: const Text("Fotos do animal",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Container(
                      height: 150,
                      width: 380,
                      decoration: BoxDecoration(
                        color: const Color(0xfff1f2f2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                print("add image");
                              },
                              icon: const Icon(Icons.control_point,
                                  color: Color(0Xff434343))),
                          const Text(
                            "Adicionar fotos",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0Xff434343)),
                          ),
                        ],
                        // Icon(Icons.control_point, color: Color(0xff757575)),
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
                        Row(
                          children: [
                            Radio(
                                value: Especie.cachorro,
                                groupValue: especie,
                                onChanged: (Especie? especieSelected) {
                                  setState(() {
                                    especie = especieSelected!;
                                  });
                                }),
                            const Text("Cachorro"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: Especie.gato,
                                groupValue: especie,
                                onChanged: (Especie? especieSelected) {
                                  setState(() {
                                    especie = especieSelected!;
                                  });
                                }),
                            const Text("Gato"),
                          ],
                        ),
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
                        Row(
                          children: [
                            Radio(
                                value: Sexo.macho,
                                groupValue: sexo,
                                onChanged: (Sexo? sexoSelected) {
                                  setState(() {
                                    sexo = sexoSelected!;
                                  });
                                }),
                            const Text("Macho"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: Sexo.femea,
                                groupValue: sexo,
                                onChanged: (Sexo? sexoSelected) {
                                  setState(() {
                                    sexo = sexoSelected!;
                                  });
                                }),
                            const Text("Fêmea"),
                          ],
                        ),
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
                        Row(
                          children: [
                            Radio(
                                value: Porte.pequeno,
                                groupValue: porte,
                                onChanged: (Porte? porteSelected) {
                                  setState(() {
                                    porte = porteSelected!;
                                  });
                                }),
                            const Text("Pequeno"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: Porte.medio,
                                groupValue: porte,
                                onChanged: (Porte? porteSelected) {
                                  setState(() {
                                    porte = porteSelected!;
                                  });
                                }),
                            const Text("Médio"),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: Porte.grande,
                                groupValue: porte,
                                onChanged: (Porte? porteSelected) {
                                  setState(() {
                                    porte = porteSelected!;
                                  });
                                }),
                            const Text("Grande"),
                          ],
                        ),
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
                            value: Idade.filhote,
                            groupValue: idade,
                            onChanged: (Idade? idadeSelected) {
                              setState(() {
                                idade = idadeSelected!;
                              });
                            }),
                        const Text("Filhote"),
                        Radio(
                            value: Idade.adulto,
                            groupValue: idade,
                            onChanged: (Idade? idadeSelected) {
                              setState(() {
                                idade = idadeSelected!;
                              });
                            }),
                        const Text("Adulto"),
                        Radio(
                            value: Idade.idoso,
                            groupValue: idade,
                            onChanged: (Idade? idadeSelected) {
                              setState(() {
                                idade = idadeSelected!;
                              });
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
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: brincalhaoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  brincalhaoValue = value!;
                                });
                              },
                            ),
                            const Text("Brincalhão"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: timidoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  timidoValue = value!;
                                });
                              },
                            ),
                            const Text("Tímido"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: calmoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  calmoValue = value!;
                                });
                              },
                            ),
                            const Text("Calmo"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      //Aqui pode ser usado o Wrap
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: Color(0xfff4a800),
                                value: guardaValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    guardaValue = value!;
                                  });
                                }),
                            const Text("Guarda"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: amorosoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  amorosoValue = value!;
                                });
                              },
                            ),
                            const Text("Amoroso"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: preguicosoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  preguicosoValue = value!;
                                });
                              },
                            ),
                            const Text("Preguiçoso"),
                          ],
                        ),
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
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: vacinadoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  vacinadoValue = value!;
                                });
                              },
                            ),
                            const Text("Vacinado"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: vermifugadoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  vermifugadoValue = value!;
                                });
                              },
                            ),
                            const Text("Vermifugado"),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      //Aqui pode ser usado o Wrap
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: castradoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  castradoValue = value!;
                                });
                              },
                            ),
                            const Text("Castrado"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: doenteValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  doenteValue = value!;
                                });
                              },
                            ),
                            const Text("Doente"),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: TextField(
                        controller: diseaseController,
                        decoration: const InputDecoration(
                            labelText: 'Doenças do Animal'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Exigências para adoção",
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
                              value: termoValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  termoValue = value!;
                                });
                              },
                            ),
                            const Text("Termo de Adoção"),
                          ]),
                          Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: fotosValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  fotosValue = value!;
                                });
                              },
                            ),
                            const Text("Fotos da casa"),
                          ]),
                          Row(children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: visitaValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  visitaValue = value!;
                                });
                              },
                            ),
                            const Text("Visita prévia ao animal"),
                          ]),
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: Color(0xfff4a800),
                                value: acompanhamentoValue,
                                onChanged: (bool? value) {
                                  setState(() {
                                    acompanhamentoValue = value!;
                                  });
                                },
                              ),
                              const Text("Acompanhamento pós adoção"),
                            ],
                          ),
                        ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xfff4a800),
                            value: tempo1Acompanhamento,
                            onChanged: (bool? value) {
                              setState(() {
                                tempo1Acompanhamento = value!;
                              });
                            },
                          ),
                          const Text("1 mês"),
                        ]),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: tempo3Acompanhamento,
                              onChanged: (bool? value) {
                                setState(() {
                                  tempo3Acompanhamento = value!;
                                });
                              },
                            ),
                            const Text("3 meses"),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Color(0xfff4a800),
                              value: tempo6Acompanhamento,
                              onChanged: (bool? value) {
                                setState(() {
                                  tempo6Acompanhamento = value!;
                                });
                              },
                            ),
                            const Text("6 meses"),
                          ],
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text("Sobre o Animal",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xfff7a800)),
                          selectionColor: Color(0Xff434343)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: TextField(
                        controller: aboutanimalController,
                        decoration: const InputDecoration(
                            labelText: 'Compartilhe a história do animal'),
                      ),
                    ),
                    Container(
                        height: 60,
                        width: 320,
                        decoration: BoxDecoration(
                          color: const Color(0xffffd358),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextButton(
                          onPressed: () {
                            print("button - colocar para adocao");
                          },
                          child: const Text(
                            "Colocar para adoção",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0Xff434343),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        )),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
