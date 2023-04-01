import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseWork {
/*Sign-up Fun */

  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code.length < 6) {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

/*SignOut Fun */

  static Future<String>? signOut() {
    FirebaseAuth.instance.signOut();
  }

/*SignIn Fun */

  static Future<String?> signAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  /*Sign in Anonymous */
  static Future<DocumentSnapshot> signInAnonymous(String id) {
    var result = FirebaseFirestore.instance.collection("admin").doc(id).get();
    return result;
  }
}
