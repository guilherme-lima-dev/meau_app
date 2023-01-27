import 'package:flutter/material.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/components/custom_drawer_menu.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/views/user/auth/login_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    return Scaffold(
      drawer: authController.authenticated ? const CustomDrawer() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: authController.authenticated
          ? FloatingActionButton(
              onPressed: () {
                authController.logout();
              },
              child: const Icon(Icons.logout),
            )
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              backgroundColor: const Color(0xffF5A900),
              label: const Text(
                "LOGIN",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              icon: const Icon(
                Icons.person_sharp,
                color: Colors.white,
              )),
      appBar: AppBarComponent(
        title: "MEAU",
        appBar: AppBar(),
      ),
      body: Center(
        child: Text(
          "Bem vindo(a) \n ${authController.user.name}",
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
