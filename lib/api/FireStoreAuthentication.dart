
import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreAuthentication {

  // Future<bool> createUserAccount({required String email, required String password}) async{
  Future<UserCredential?> createMotherAccount({required String email, required String password, required String name, required bool pregnancyStatus}) async{
    try {
     // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Motherdata mData = Motherdata();
      mData.init(email: email, isPregnant: pregnancyStatus, name: name);
      FireStoreConnect().saveMotherData(motherdata: mData);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signInUser({required String email, required String password}) async{
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      if(credential.user != null) {
        print('Login was successful . . .');
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return false;
    }
  }

  void signout() async{
    await FirebaseAuth.instance.signOut();
  }

  void deleteUser() async{
    await FirebaseAuth.instance.currentUser!.delete();
  }

  String? getUserUid(){
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser?.uid;
    }
  }
}