import 'package:dapp_voting/Blockchain/contract_linking.dart';
import 'package:dapp_voting/Firebase/Providers/userProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class Myprofile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('MY PROFILE'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
            height: 300,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange, Colors.yellow]),
            ),
            child: Card(
              margin: EdgeInsets.fromLTRB(20, 40, 20, 5),
              elevation: 5,
              child: Image.asset('images/profile.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 8, 30, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${userProvider.currentUser.name}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${userProvider.currentUser.email}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "id - ${userProvider.currentUser.voterID}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Account Address -".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text(
                  "${contractLink.accountaddress}".toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
