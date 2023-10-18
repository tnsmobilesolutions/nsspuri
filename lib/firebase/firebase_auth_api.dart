import 'package:firebase_auth/firebase_auth.dart';
import 'package:sammilani_delegate/API/get_devotee.dart';
import 'package:sammilani_delegate/model/devotte_model.dart';

class FirebaseAuthentication {
  Future<Map<String,dynamic>> signinWithFirebase(
      String email, String password) async {
    try {
        String? uid;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uid = value.user?.uid;
    }).onError((error, stackTrace) {
      print("Error ${error.toString()}");
    });
    DevoteeModel devotee =await GetDevoteeAPI().signInDevoteebyUID(uid.toString());
    return {"data" : devotee};
    } catch (e) {
      return {"error" : e};
    }
  }

  Future<String?> signupWithpassword(String email, String password) async {
    try {
      String? uid;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => uid = value.user?.uid);
//  return uid;
      return uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
