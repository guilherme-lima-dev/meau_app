import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:meau/controllers/photo/photo_controller.dart';
import 'package:meau/helpers/build_material_color_helper.dart';
import 'package:meau/model/animal.dart';
import 'package:meau/services/auth_service.dart';
import 'package:meau/views/animals/success_register_screen.dart';
import 'package:meau/views/user/auth/login_screen.dart';
import 'package:meau/views/home/home_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

enum Especie { cachorro, gato }

enum Sexo { macho, femea }

enum Porte { pequeno, medio, grande }

enum Idade { filhote, adulto, idoso }

enum Accompaniment { one, three, six, not }

class RegisterAnimalScreen extends StatefulWidget {
  const RegisterAnimalScreen({Key? key}) : super(key: key);

  @override
  State<RegisterAnimalScreen> createState() => _RegisterAnimalScreenState();
}

class _RegisterAnimalScreenState extends State<RegisterAnimalScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var animal = Animal();
  final nameController = TextEditingController();
  final diseaseController = TextEditingController();
  final aboutanimalController = TextEditingController();

  int value = 0;
  String interest = "Adoção";

  Especie especie = Especie.cachorro;
  Sexo sexo = Sexo.macho;
  Porte porte = Porte.pequeno;
  Idade idade = Idade.filhote;
  Accompaniment accompaniment = Accompaniment.not;
  bool loadingButtonRegister = false;

  String temperamentText = "";
  bool brincalhaoValue = false;
  bool timidoValue = false;
  bool calmoValue = false;
  bool guardaValue = false;
  bool amorosoValue = false;
  bool preguicosoValue = false;

  String healthText = "";
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

  Widget customRadioButton(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            this.value = index;
            this.interest = text;
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

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery(PhotoController photoController) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      photoController.setPhotoAnimal(File(pickedFile.path));
      photoController.uploadFileAnimal();
    } else {
      print('No image selected.');
    }
  }

  Future imgFromCamera(PhotoController photoController) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photoController.setPhotoAnimal(File(pickedFile.path));
      photoController.uploadFileAnimal();
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final photoController = context.watch<PhotoController>();
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
              ),
              Container(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customRadioButton("ADOÇÃO", 0),
                  customRadioButton("APADRINHAR", 1),
                  customRadioButton("AJUDA", 2),
                ],
              ),
              Container(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15, bottom: 20),
                    child: Text(
                      value == 0
                          ? "Adoção"
                          : value == 1
                              ? "Apadrinhar"
                              : "Ajuda",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 21, color: Color(0xff434343)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'NOME DO ANIMAL',
                          hintText: 'Digite um nome válido, Ex: Belinha'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Fotos do animal",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _showPicker(context, photoController);
                    },
                    child: Container(
                      height: 150,
                      width: 380,
                      decoration: BoxDecoration(
                        color: const Color(0xfff1f2f2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: photoController.photoAnimal == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _showPicker(context, photoController);
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
                            )
                          : Image.file(
                              photoController.photoAnimal!,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Espécie",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
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
                      child: const Text(
                        "Sexo",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Color(0xfff7a800)),
                      )),
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
                    child: const Text(
                      "Porte",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
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
                    child: const Text(
                      "Idade",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
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
                    child: const Text(
                      "Temperamento",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xfff4a800),
                            value: brincalhaoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                brincalhaoValue = value!;
                                if (brincalhaoValue) {
                                  temperamentText += "Brincalhão;";
                                } else {
                                  temperamentText = temperamentText.replaceAll(
                                      "Brincalhão;", "");
                                }
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
                            activeColor: const Color(0xfff4a800),
                            value: timidoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                timidoValue = value!;
                                if (timidoValue) {
                                  temperamentText += "Timido;";
                                } else {
                                  temperamentText =
                                      temperamentText.replaceAll("Timido;", "");
                                }
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
                            activeColor: const Color(0xfff4a800),
                            value: calmoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                calmoValue = value!;
                                if (calmoValue) {
                                  temperamentText += "Calmo;";
                                } else {
                                  temperamentText =
                                      temperamentText.replaceAll("Calmo;", "");
                                }
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
                              activeColor: const Color(0xfff4a800),
                              value: guardaValue,
                              onChanged: (bool? value) {
                                setState(() {
                                  guardaValue = value!;
                                  if (guardaValue) {
                                    temperamentText += "Guarda;";
                                  } else {
                                    temperamentText = temperamentText
                                        .replaceAll("Guarda;", "");
                                  }
                                });
                              }),
                          const Text("Guarda"),
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xfff4a800),
                            value: amorosoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                amorosoValue = value!;
                                if (amorosoValue) {
                                  temperamentText += "Amoroso;";
                                } else {
                                  temperamentText = temperamentText.replaceAll(
                                      "Amoroso;", "");
                                }
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
                            activeColor: const Color(0xfff4a800),
                            value: preguicosoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                preguicosoValue = value!;
                                if (preguicosoValue) {
                                  temperamentText += "Preguiçoso;";
                                } else {
                                  temperamentText = temperamentText.replaceAll(
                                      "Preguiçoso;", "");
                                }
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
                    child: const Text(
                      "Saúde",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xfff4a800),
                            value: vacinadoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                vacinadoValue = value!;
                                if (vacinadoValue) {
                                  healthText += "Vacinado;";
                                } else {
                                  healthText =
                                      healthText.replaceAll("Vacinado;", "");
                                }
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
                            activeColor: const Color(0xfff4a800),
                            value: vermifugadoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                vermifugadoValue = value!;
                                if (vermifugadoValue) {
                                  healthText += "Vermifugado;";
                                } else {
                                  healthText =
                                      healthText.replaceAll("Vermifugado;", "");
                                }
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
                            activeColor: const Color(0xfff4a800),
                            value: castradoValue,
                            onChanged: (bool? value) {
                              setState(() {
                                castradoValue = value!;
                                if (castradoValue) {
                                  healthText += "Castrado;";
                                } else {
                                  healthText =
                                      healthText.replaceAll("Castrado;", "");
                                }
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
                            activeColor: const Color(0xfff4a800),
                            value: doenteValue,
                            onChanged: (bool? value) {
                              setState(() {
                                doenteValue = value!;
                                if (doenteValue) {
                                  healthText += "Doente;";
                                } else {
                                  healthText =
                                      healthText.replaceAll("Doente;", "");
                                }
                              });
                            },
                          ),
                          const Text("Doente"),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: TextField(
                      controller: diseaseController,
                      decoration:
                          const InputDecoration(labelText: 'Doenças do Animal'),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Exigências para adoção",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Row(children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: const Color(0xfff4a800),
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
                        activeColor: const Color(0xfff4a800),
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
                        activeColor: const Color(0xfff4a800),
                        value: visitaValue,
                        onChanged: (bool? value) {
                          setState(() {
                            visitaValue = value!;
                          });
                        },
                      ),
                      const Text("Visita prévia ao animal"),
                    ]),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: const Text(
                        "Tempo de acompanhamento",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xfff7a800)),
                      ),
                    ),
                  ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(children: [
                        Radio(
                          activeColor: const Color(0xfff4a800),
                          value: Accompaniment.one,
                          groupValue: accompaniment,
                          onChanged: (Accompaniment? value) {
                            setState(() {
                              accompaniment = value!;
                            });
                          },
                        ),
                        const Text("1 mês"),
                      ]),
                      Row(
                        children: [
                          Radio(
                            activeColor: const Color(0xfff4a800),
                            value: Accompaniment.three,
                            groupValue: accompaniment,
                            onChanged: (Accompaniment? value) {
                              setState(() {
                                accompaniment = value!;
                              });
                            },
                          ),
                          const Text("3 meses"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: const Color(0xfff4a800),
                            value: Accompaniment.six,
                            groupValue: accompaniment,
                            onChanged: (Accompaniment? value) {
                              setState(() {
                                accompaniment = value!;
                              });
                            },
                          ),
                          const Text("6 meses"),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            activeColor: const Color(0xfff4a800),
                            value: Accompaniment.not,
                            groupValue: accompaniment,
                            onChanged: (Accompaniment? value) {
                              setState(() {
                                accompaniment = value!;
                              });
                            },
                          ),
                          const Text("Sem acompanhamento"),
                        ],
                      )
                    ],
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      "Sobre o Animal",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xfff7a800)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: TextField(
                      maxLines: 8,
                      controller: aboutanimalController,
                      decoration: const InputDecoration(
                          labelText: 'Compartilhe a história do animal'),
                    ),
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color(0xffF5A900),
                    borderRadius: BorderRadius.circular(20)),
                margin: const EdgeInsets.only(bottom: 15),
                child: TextButton(
                  onPressed: () async {
                    final docAnimal =
                        FirebaseFirestore.instance.collection('animal').doc();
                    setState(() {
                      loadingButtonRegister = true;
                    });
                    this.animal = Animal(
                      id: docAnimal.id,
                      about: this.aboutanimalController.value.text,
                      age: this.idade.name,
                      carry: this.porte.name,
                      health: this.healthText,
                      illness: diseaseController.value.text,
                      name: nameController.value.text,
                      objective: interest,
                      porte: porte.name,
                      sex: sexo.name,
                      species: especie.name,
                      requirements: Requirements(
                          accompaniment: accompaniment.name,
                          pictureHouse: fotosValue,
                          term: termoValue,
                          visit: visitaValue),
                      temperament: temperamentText,
                      photo: basename(photoController.photoAnimal!.path),
                      user: "user/${authController.user.docID}"
                    );
                    print(animal.toJson());
                    await docAnimal.set(animal.toJson());
                    _formKey.currentState?.reset();
                    setState(() {
                      loadingButtonRegister = false;
                    });
                    Timer(const Duration(seconds: 0), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SuccessRegisterScreen()));
                    });
                  },
                  child: loadingButtonRegister
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3,
                        )
                      : const Text(
                          "Cadastrar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context, PhotoController photoController) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery(photoController);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera(photoController);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
