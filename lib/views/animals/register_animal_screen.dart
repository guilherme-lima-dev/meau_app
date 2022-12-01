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
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? const Color(0xffF5A900) : Colors.black,
          ),
        ),
        style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(
              color: (value == index) ? const Color(0xffF5A900) : Colors.black),
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
              // Padding(
              //   padding: const EdgeInsets.only(top: 60.0),
              //   child: Center(
              //     child: SizedBox(
              //         width: 200,
              //         height: 150,
              //         /*decoration: BoxDecoration(
              //             color: Colors.red,
              //             borderRadius: BorderRadius.circular(50.0)),*/
              //         child: Image.asset('assets/logos/Meau_Icone.png')),
              //   ),
              // ),
              Container(
                height: 50,
              ),
              Text("Seu cadastro será para:", textAlign: TextAlign.left),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRadioButton("ADOÇÃO", 0),
                  CustomRadioButton("APADRINHAR", 1),
                  CustomRadioButton("AJUDA", 2),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                      hintText: 'Digite um nome válido, EX: João da Silva'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Exemplo checkbox"),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Color(0xffF5A900),
                    value: true,
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Exemplo radio"),
                  Radio(
                      value: "radio value",
                      groupValue: "group value",
                      onChanged: (value){
                        print(value); //selected value
                      }
                  ),
                ],
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color(0xffF5A900),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    print("indo");
                    Map register = {
                      "email": emailController.text,
                      "password": passwordController.text,
                      "returnSecureToken": true
                    };
                    authController.setLoading();
                    var res = await authController.register(register);
                    authController.setLoading();
                    if (res != null) {
                      _formKey.currentState?.reset();
                      Timer(const Duration(seconds: 0), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      });
                    }
                  },
                  child: authController.loading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 3,
                        )
                      : const Text(
                          "CADASTRAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
