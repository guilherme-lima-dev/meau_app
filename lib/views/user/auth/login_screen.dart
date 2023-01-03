import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/controllers/photo/photo_controller.dart';
import 'package:meau/services/auth_service.dart';
import 'package:meau/views/user/auth/sign_up_screen.dart';
import 'package:meau/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final photoController = context.watch<PhotoController>();
    return Scaffold(
      appBar: AppBarComponent(
        title: "LOGIN",
        appBar: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/logos/Meau_Icone.png')),
                ),
              ),
              Container(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Digite um e-mail válido, EX: abc@gmail.com'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Digite uma senha segura'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Esqueci minha senha.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: const Color(0xffF5A900),
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () async {
                    Map login = {
                      "email": emailController.text,
                      "password": passwordController.text,
                      "returnSecureToken": true
                    };
                    authController.setLoading();
                    var res = await authController.auth(login);
                    photoController.setPhotoUser(authController.user.image);
                    photoController.setUser(authController.user);
                    authController.setLoading();
                    if (res != null) {
                      _formKey.currentState?.reset();
                      Timer(const Duration(seconds: 0), () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      });
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: const Text('Não autorizado'),
                                content:
                                const Text('Usuário ou senha incorretos!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    }
                  },
                  child: authController.loading
                      ? const CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 3,
                  )
                      : const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              GestureDetector(
                child: const Text(
                  'Não tem conta? Crie uma!',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
