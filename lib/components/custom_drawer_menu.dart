import 'package:flutter/material.dart';
import 'package:meau/views/animals/list_all_animals_screen.dart';
import 'package:meau/views/animals/register_animal_screen.dart';
import 'package:meau/views/user/profile_screen.dart';
//import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authController = context.watch<AuthController>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xffF5A900),
            ),
            child: Image.asset(
              'assets/logos/Meau_Icone.png',
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            title: const Text('Inicio'),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            title: const Text('Meu perfil'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddPersonalData()));
            },
          ),
          ListTile(
            title: const Text('Lista de animais'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListAllAnimalsScreen()));
            },
          ),
          ListTile(
            title: const Text('Cadastro de animais'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterAnimalScreen()));
            },
          ),
        ],
      ),
    );
  }
}
