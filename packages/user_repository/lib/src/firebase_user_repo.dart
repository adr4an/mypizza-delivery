import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  // if no instance is provided, use the default FirebaseAuth instance
  FirebaseUserRepo({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser> get user {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {

      // user is not logged in
      if (firebaseUser == null) {
        // return empty user
        yield MyUser.empty; 
      } 
      
      // user is logged in
      else {
        // fetch user data from firestore
        yield await usersCollection
            .doc(firebaseUser.uid)
            .get()
            .then((value) => MyUser.fromEntity(
                MyUserEntity.fromJson(value.data()!))
            );
      }
      
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    }
    
    // log the error and rethrow it
    catch (e) {
      // print the error to console
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
          email: myUser.email, 
          password: password
        );

      // set the userId given by firebase
      myUser.userId = userCredential.user!.uid;
      return myUser;
    }

    catch (e) {
      // print the error to console
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async { 
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      // store user data in firestore
      await usersCollection
        .doc(myUser.userId)
        .set(myUser.toEntity().toJson());
    }

    catch (e) {
      // print the error to console
      log(e.toString());
      rethrow;
    }
  }

}