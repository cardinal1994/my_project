import 'package:firebase_auth/firebase_auth.dart';

class Player {
  String id;
  String username;
  String imageURL;
  String search;
  String city;
  int balance;
  String role;
  String phoneNumber;

  Player.fromFirebase(User user) {
    id = user.uid;
  }
}
