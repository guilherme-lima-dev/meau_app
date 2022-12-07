import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:meau/controllers/auth_controller.dart';
import 'package:meau/helpers/build_material_color_helper.dart';
import 'package:meau/http_clients/dio_client.dart';
import 'package:meau/interfaces/http_client_interface.dart';
import 'package:meau/services/auth_service.dart';
import 'package:meau/views/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IHttpClient>(create: (_) => DioClient()),
        Provider<AuthService>(create: (context) => AuthService(context.read())),
        ChangeNotifierProvider<AuthController>(create: (context) => AuthController(context.read())),
      ],
      child: MaterialApp(
        title: 'Meau',
        theme: ThemeData(
          primarySwatch: BuildMaterialColorHelper.buildMaterialColor(const Color(0xffF5A900)),
        ),
        home: const MyHomePage(title: 'Hello World!'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key ?key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      AnimatedSplashScreen(
          duration: 3500,
          centered: true,
          splash: Container(),
          nextScreen: const HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color(0xffF5A900)
      ),
      Column(
        children: [
          SizedBox(
            height: 250,
          ),
          SizedBox(
              width: 500,
              height: 300,
              /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
              child: Image.asset('assets/logos/Meau_Icone.png')
          ),
          Container(
            margin: const EdgeInsets.only(top: 170),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ],
  );
}
