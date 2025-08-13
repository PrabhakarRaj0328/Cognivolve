import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/web.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final logger = Logger();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      if (userCredential.user != null) {
        bool isNew = await isNewUser(userCredential.user!.uid);
        if (isNew) {
          return userCredential.user;
        } else {
          return userCredential.user;
        }
      }
      return null;
    } catch (e) {
      logger.e("Google Sign-In Error: $e");
      return null;
    }
  }

  Future<bool> isNewUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return !doc.exists;
  }

  Future<void> saveUserProfile({
    required String uid,
    required String email,
    required String displayName,
    required Map<String, dynamic> extraData,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
        ...extraData,
      });
      logger.i('User profile saved successfully');
    } catch (e) {
      logger.e('Error saving user profile: $e');
    }
  }

  Future<void> createUserDocument(User user) async {
    try {
      final userDoc = _firestore.collection('users').doc(user.uid);

      final docSnapshot = await userDoc.get();

      if (!docSnapshot.exists) {
        await userDoc.set({
          'uid': user.uid,
          'email': user.email,
          'displayName': user.displayName ?? 'Anonymous',
          'createdAt': FieldValue.serverTimestamp(),
        });
        logger.i('User document created successfully');
      }
    } catch (e) {
      logger.e('Error creating user document: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
