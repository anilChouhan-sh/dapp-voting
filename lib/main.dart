import 'package:dapp_voting/AdminUI/AdminUI.dart';
import 'package:dapp_voting/AdminUI/results.dart';
import 'package:dapp_voting/Blockchain/contract_linking.dart';
import 'package:dapp_voting/Firebase/Providers/candidatesProvider.dart';

import 'package:dapp_voting/homepage%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'Firebase/Providers/privateKeyprovider.dart';
import 'Firebase/Providers/userProviders.dart';

import 'Sign-up/Login.dart';
import 'Sign-up/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> f = new GlobalKey();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return UserProvider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return Keyprovider();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return ContractLinking();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return CandidatesProvider();
            },
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => mainscreen(),
              '/signup': (context) => SignupScreen(),
              '/login': (context) => LoginScreen(),
              '/votescreen': (context) => Homepage(),
              '/AdminUI': (context) => AdminUI(),
              '/result': (context) => Results(),
            }));
  }
}

class mainscreen extends StatefulWidget {
  const mainscreen({
    Key key,
  }) : super(key: key);

  @override
  _mainscreenState createState() => _mainscreenState();
}

class _mainscreenState extends State<mainscreen> {
  bool obscure = true;
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginScreen();
    } else {
      return Homepage();
    }
  }
}
