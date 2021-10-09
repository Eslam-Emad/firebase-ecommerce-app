import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../helpers/Exceptions/user_exception.dart';

class FirebaseServices {
   // Future<FirebaseApp> _initialization ;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static UserCredential userCredential;
  static final CollectionReference reference =
      FirebaseFirestore.instance.collection('photos');
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  // Future<FirebaseApp> initializingApp() {
  //   _initialization = Firebase.initializeApp();
  //   return _initialization;
  // }

  // user => userID(doc) => cart => productID(doc)
  Future addToCart(String productID) async {
    _userReference
        .doc(getUserId)
        .collection('cart')
        .doc(productID)
        .set({'size': 2});
  }

  Stream getCartItems() {
    return _userReference.doc(getUserId).collection('cart').snapshots();
  }

  Future<QuerySnapshot> get getProducts async {
    return await reference.get();
  }

  Future getProduct(String id) async {
    return await reference.doc(id).get();
  }

  String get getUserId {
    return auth.currentUser.uid;
  }

  static String get getUserName {
    return auth.currentUser.displayName;
  }

  static String get getUserEmail {
    return auth.currentUser.email;
  }

  static String get getUserPhoto {
    return auth.currentUser.photoURL;
  }

  static Future get signOut async {
    await auth.signOut();
  }

  static Future get deleteUser async {
    await auth.currentUser.delete();
  }

  static Future updateEmail(String email) async {
    await auth.currentUser.updateEmail(email);
  }

  static Future updatePassword(String password) async {
    await auth.currentUser.updatePassword(password);
  }

  static Future login(String email, String password) async {
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserException('No user found.');
      } else if (e.code == 'wrong-password') {
        throw UserException('Wrong password.');
      }
      return false;
    } // TODO retrieve a message
    catch (error) {
      throw UserException("Error");
    }
  }

  static Future signUp(String email, String password) async {
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw UserException('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw UserException('account already exists.');
      }
    } // TODO retrieve a message
    catch (error) {
      throw UserException(error.toString());
    }
  }

  static Future updateProfile(String displayName, photoURL) async {
    await auth.currentUser
        .updateProfile(displayName: displayName, photoURL: photoURL);
  }
}
