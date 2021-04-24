import 'package:dapp_voting/Firebase/candidates.dart';
import 'package:flutter/cupertino.dart';

import '../firestore.dart';
import '../candidates.dart';

class CandidatesProvider extends ChangeNotifier {
  final firestore = Firestore_ser();

  Candidates _currentCandidate;

  String _name;
  int _id, _votes;
//getter
  String get name => _name;
  int get id => _id;
  int get votes => _votes;

  Stream<List<Candidates>> get candidates => firestore.getCandidates();
  Candidates get currentUser => _currentCandidate;
//setter

  set changename(String name) {
    _name = name;
    notifyListeners();
  }

  set changevotes(int votes) {
    _votes = votes;
    notifyListeners();
  }

  set changeid(int id) {
    _id = id;
    notifyListeners();
  }

  loadAll(Candidates candidates) {
    if (candidates != null) {
      _name = candidates.name;
      _id = candidates.id;
    } else {
      _id = null;

      _name = null;
    }
  }

  savecandidates() {
    //Edit
    var updatedUser = Candidates(name: _name, id: _id);
    firestore.setEntry(updatedUser, 'candidates');
  }
}
