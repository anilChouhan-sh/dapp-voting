import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://34.93.210.173:9999/";
  String _privateKey;
  String _results = "Not yet declared";
  String get privatekey => _privateKey;

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

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcUrl, Client());

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile = await rootBundle.loadString("assests/Voting.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _accountAddress = await _credentials.extractAddress();
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

  givevoterights(Function mytoast) async {
    isLoading = true;
    notifyListeners();
    String result = "";
    try {
      await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract, function: _givevoteright, parameters: []));
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
    }
  }

  givevoteTo(BigInt id, Function mytoast) async {
    isLoading = true;
    notifyListeners();
    String result = "";
    try {
      await _client.sendTransaction(
          _credentials,
          Transaction.callContract(
              contract: _contract, function: _givevoteTo, parameters: [id]));
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
    }
  }

  Future<dynamic> declareResults(Function mytoast) async {
    String result = "";
    try {
      var ans = await _client
          .call(contract: _contract, function: _declareResults, params: []);
      print("$ans");
    } on RPCError catch (e) {
      result = e.message.split(':')[1].substring(7);
      mytoast(result);
      print(result);
    }
  }
}
