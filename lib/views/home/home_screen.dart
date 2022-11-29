import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/components/custom_drawer_menu.dart';
import 'package:meau/views/auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          backgroundColor: Color(0xffF5A900),
          label: const Text(
            "LOGIN",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          icon: const Icon(Icons.person_sharp, color: Colors.white,)),
      appBar: AppBarComponent(
        title: "MEAU",
        appBar: AppBar(),
      ),
      body: const Center(
        child: Text(
          "Hello World!",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
