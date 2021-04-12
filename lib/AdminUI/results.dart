import 'package:dapp_voting/Blockchain/contract_linking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var linkPorvider = Provider.of<ContractLinking>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Congratulation",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
    );
  }
}
