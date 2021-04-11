import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://172.30.68.239:9999/";
  final String _privateKey =
      "0x432b469ca985c0aac786ee6e38d50c1418b40dffb4527aa3e80e8179ec83d86f";

  Web3Client _client;
  bool isLoading = true;

  String _abiCode;
  EthereumAddress _contractAddress;

  Credentials _credentials;

  DeployedContract _contract;
  ContractFunction _yourName;
  ContractFunction _setName;

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
    String abiStringFile = await rootBundle.loadString("assests/Hello.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress = EthereumAddress.fromHex(
        jsonAbi["networks"]["1617890874639"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Hello"), _contractAddress);

    // Extracting the functions, declared in contract.
    _yourName = _contract.function("getname");
    _setName = _contract.function("setname");
    getName();
  }

  getName() async {
    // Getting the current name declared in the smart contract.
    var currentName = await _client
        .call(contract: _contract, function: _yourName, params: []);
    deployedName = currentName[0];
    print(deployedName);
    isLoading = false;
    notifyListeners();
  }

  setName(String nameToSet) async {
    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract, function: _setName, parameters: [nameToSet]));
    getName();
  }
}
