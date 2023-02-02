import 'package:flutter/material.dart';
import 'package:meau/chat/homepage.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/components/custom_drawer_menu.dart';
import 'package:meau/controllers/user/auth_controller.dart';
import 'package:meau/views/animals/list_all_animals_screen.dart';
import 'package:meau/views/animals/list_interested_screen.dart';
import 'package:meau/views/animals/register_animal_screen.dart';
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
      body: authController.authenticated
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Bem vindo(a) \n ${authController.user.name}",
                  style: const TextStyle(fontSize: 40),
                  textAlign: TextAlign.center,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: const Color(0xffF5A900), borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterAnimalScreen()));
                        },
                        child: const Text(
                          "Cadastrar animal",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: const Color(0xffF5A900), borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ListAllAnimalsScreen()));
                        },
                        child: const Text(
                          "Exibir animais dispoíveis",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: const Color(0xffF5A900), borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const ListInterestedSreen()));
                        },
                        child: const Text(
                          "Interessados em adotar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: const Color(0xffF5A900), borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                        },
                        child: const Text(
                          "Chat com interessados",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: const Color(0xff909090), borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Você precisa estar logado para cadastrar um animal!'),
                      ));
                    },
                    child: const Text(
                      "Cadastrar animal",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: const Color(0xff909090), borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Você precisa estar logado para ver os animais!'),
                      ));
                    },
                    child: const Text(
                      "Exibir animais dispoíveis",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: const Color(0xff909090), borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Você precisa estar logado para ver os interessados!'),
                      ));
                    },
                    child: const Text(
                      "Interessados em adotar",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                      color: const Color(0xff909090), borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Você precisa estar logado para acessar o chat!'),
                      ));
                    },
                    child: const Text(
                      "Chat com interessados",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
              ],
            )),
    );
  }
}
