import 'package:firebase_auth/firebase_auth.dart';
import 'package:sicilia_mafia_club/model/Player.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Player> signIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Player.fromFirebase(result.user);
    } catch (e) {
      return null;
    }
  }

  Future<Player> registerFirebase(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return Player.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut(){
    return _auth.signOut();
  }

  Stream<Player> get currentPlayer{
    return _auth.authStateChanges().map((User user) => user != null? Player.fromFirebase(user) : null);
  }
}
