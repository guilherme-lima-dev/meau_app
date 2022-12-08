import 'package:flutter/material.dart';
import 'package:meau/components/app_bar_component.dart';
import 'package:meau/components/home_button.dart';
import 'package:meau/views/home/home_screen.dart';

class SuccessRegisterScreen extends StatefulWidget {
  const SuccessRegisterScreen({Key? key}) : super(key: key);

  @override
  _SuccessRegisterScreenState createState() => _SuccessRegisterScreenState();
}

class _SuccessRegisterScreenState extends State<SuccessRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              "Cadastro confirmado!",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              "Seu bichinho já está esperando por um amigo!",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Você será redirecionado para a nossa página inicial \npara que possa continuar sua navegação!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            Flexible(
              child: HomeButton(
                title: 'Vamos lá',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
