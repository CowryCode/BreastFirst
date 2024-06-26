
import 'package:breastfirst/api/FireStore.dart';
import 'package:breastfirst/api/model/diskstorage.dart';
import 'package:breastfirst/api/model/motherdata.dart';
import 'package:breastfirst/api/network.dart';
import 'package:breastfirst/api/networkUtilities.dart';
import 'package:breastfirst/statemanagement/valuenotifiers/NotifierCentral.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreAuthentication {

  //Future<UserCredential?> createMotherAccount({required String email, required String password, required String name, required bool pregnancyStatus}) async{
  Future<UserCredential?> createMotherAccount({required String email, required String name, required bool pregnancyStatus}) async{
    try {
     // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: General_Password,
      );
      Motherdata mData = Motherdata();
      mData.init(email: email, isPregnant: pregnancyStatus, name: name);
      await FireStoreConnect().saveMotherData(motherdata: mData);
      await ApiAccess().creatUserProfile(email: email, name: name);
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

 // Future<bool> signInUser({required String email, required String password}) async{
  Future<bool> signInUser({required String email}) async{
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: General_Password
      );

      if(credential.user != null) {
        print('Login was successful . . .');
        //motherDataNotifier.updateEmail(email: email);
        ApiAccess().getAwsUserPrfoile(userID:email);
        Localstorage().saveUserIDLocal(email);
        Localstorage().savePasswordLocal(password: General_Password);
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