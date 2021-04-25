import 'package:dapp_voting/AdminUI/AdminUI.dart';
import 'package:dapp_voting/Blockchain/contract_linking.dart';
import 'package:dapp_voting/Drawer/Myprofile.dart';
import 'package:dapp_voting/Firebase/Providers/candidatesProvider.dart';
import 'package:dapp_voting/Sign-up/signup.dart';

import 'package:dapp_voting/homepage%20.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'AdminUI/results.dart';
import 'Firebase/Providers/privateKeyprovider.dart';
import 'Firebase/Providers/userProviders.dart';

import 'Sign-up/Login.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainscreen(),
    );
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
        child:
            // Text('kjdas'));
            Navigator(
          initialRoute: '/votescreen',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case '/signup':
                return MaterialPageRoute(builder: (context) => SignupScreen());
              case '/login':
                return MaterialPageRoute(builder: (context) => LoginScreen());
              case '/votescreen':
                return MaterialPageRoute(builder: (context) => Homepage());
              case '/result':
                return MaterialPageRoute(builder: (context) => Results());
              case '/myprofile':
                return MaterialPageRoute(builder: (context) => Myprofile());
            }
          },
        ),
      );
    }
  }
}
