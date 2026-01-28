import 'package:user_repository/src/models/models.dart';

abstract class UserRepository 
{
  Stream <MyUser> get user;

  // sign up
  Future <MyUser> signUp (MyUser myUser, String password);

  // set user data
  Future <void> setUserData (MyUser myUser);

  // sign in 
  Future <void> signIn (String email, String password);

  // logout 
  Future <void> logOut ();

}