import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart' as fire;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://172.24.13.21:9999/";
  String _privateKey;
  // String _results = "Not yet declared";
  List _ans;
  String get privatekey => _privateKey;
  List get ans => _ans;

  set changekey(String key) {
    _privateKey = key;
    // print("Your Key $_privateKey");
    notifyListeners();
  }

  Web3Client _client;
  bool isLoading = true;

  String _abiCode;
  EthereumAddress _contractAddress;
  EthereumAddress _accountAddress;

  Credentials _credentials;

  DeployedContract _contract;
  ContractFunction _start_voting;
  ContractFunction _end_voting;
  ContractFunction _givevoteright;
  ContractFunction _givevoteTo;
  ContractFunction _declareResults;
  String deployedName;
  int _no_auth_done;
  int _no_auth_error;
  String get accountaddress => _accountAddress.toString();
  int get no_auth_done => _no_auth_done;
  int get no_auth_error => _no_auth_error;

  set changenumber(int n) {
    _no_auth_done = n;
    _no_auth_error = n;
  }

  ContractLinking() {
    initialSetup();
    print("pub key$accountaddress");
  }

  initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcUrl, Client());
    print("Setting up connection with BlockChain");
    await getAbi();
    print("hello1");
    // await getCredentials(true);
    // print("hello2");
    await getDeployedContract();
    print("hello3");
  }

  Future<void> getAbi() async {
    print("Inside abi functions");
    // final response = await http.get(Uri.http('172.30.73.0', 'Voting.json'));
    // Reading the contract abi
    String abiStringFile = await rootBundle.loadString("assests/Voting.json");
    //String abiStringFile = response.body;
    print("got from internet ${abiStringFile.substring(0, 20)}");
    //  print("got  ${abiString.substring(0, 20)}");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<EthereumAddress> getCredentials(bool flag, {String mykey}) async {
    Credentials _cred;
    EthereumAddress _account;
    if (flag) {
      _credentials = await _client.credentialsFromPrivateKey(_privateKey);

      _accountAddress = await _credentials.extractAddress();
    } else {
      _cred = await _client.credentialsFromPrivateKey(mykey);
      _account = await _cred.extractAddress();
    }
    return _account;
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Hello"), _contractAddress);

    // Extracting the functions, declared in contract.
    _start_voting = _contract.function("start_voting");
    _end_voting = _contract.function("end_voting");
    _givevoteright = _contract.function("givevoteright");
    _givevoteTo = _contract.function("givevoteTo");
    _declareResults = _contract.function("declareResults");
  }

  // ignore: non_constant_identifier_names
  start_voting(Function mytoast) async {
    isLoading = true;
    notifyListeners();
    String result = "";
    try {
      await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract, function: _start_voting, parameters: []));
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
    }
  }

  // ignore: non_constant_identifier_names
  end_voting(Function mytoast) async {
    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();
    String result = "";
    try {
      await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract, function: _end_voting, parameters: []));
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
    }
  }

  Future<String> givevoterights(
      Function mytoast, EthereumAddress address) async {
    isLoading = true;
    notifyListeners();
    String result = "";
    try {
      String x = await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract,
              function: _givevoteright,
              parameters: [address]));
      _no_auth_done++;
      return x;
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
      _no_auth_error++;
    }
    return "";
  }

  givevoteTo(BigInt id, Function mytoast, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    String result = "";
    try {
      String hash = await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract, function: _givevoteTo, parameters: [id]));
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Thank you for voting"),
              actions: [
                Text(hash),
                Align(
                  alignment: Alignment.center,
                  child: RaisedButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            );
          });

      print("Your hash $hash");
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
    }
  }

  Future<dynamic> declareResults(Function mytoast) async {
    String result = "";
    print("hello23");
    try {
      _ans = await _client
          .call(contract: _contract, function: _declareResults, params: []);
      print("${_ans}");
      int bi = _ans[0][0].toInt();

      print("your ids $bi     ${_ans[0][0].runtimeType}");
      // print("your votes $votes");
      int i = 0;
      for (i = 0; i < _ans[0].length; i++) {
        fire.QuerySnapshot snap = await fire.FirebaseFirestore.instance
            .collection('candidates')
            .where("id", isEqualTo: _ans[0][i].toInt())
            .get();
        fire.DocumentReference ref = snap.docs[0].reference;

        ref.set({"votes": _ans[1][i].toInt()}, fire.SetOptions(merge: true));
      }
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
      _ans = null;
    } catch (e) {
      print("Some error for show results $e");
    }
  }
}
