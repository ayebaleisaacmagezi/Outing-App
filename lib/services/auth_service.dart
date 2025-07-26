// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Get an instance of Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;
  // SIGN UP with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password, String displayName) async {
    try {
      // Create the user in Firebase Auth
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After creating the user, update their profile with the display name
      if (credential.user != null) {
        await credential.user!.updateDisplayName(displayName);
        // We need to reload the user to get the updated info
        await credential.user!.reload();
        return _auth.currentUser;
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase errors (e.g., email-already-in-use)
      print("Firebase Auth Exception: ${e.message}");
      return null;
    } catch (e) {
      // Handle any other errors
      print("An unexpected error occurred: $e");
      return null;
    }
  }
  
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Use the FirebaseAuth instance to sign in.
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Handle errors like wrong password, user not found, etc.
       if (kIsWeb && e is FirebaseAuthException) {
        print("Firebase Auth Exception on Sign In (Web): ${e.message}");
      } else if (e is FirebaseAuthException) {
        print("Firebase Auth Exception on Sign In (Mobile): ${e.message}");
      }
      else {
        print("An unexpected error occurred during sign in: $e");
      }
      return null;
    }
  }
  
  // --- 2. ADD THE NEW signInWithGoogle METHOD ---
  Future<User?> signInWithGoogle() async {
    try {
      // 2a. Trigger the Google Authentication flow.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If the user cancels the flow, googleUser will be null.
      if (googleUser == null) {
        return null;
      }

      // 2b. Obtain the auth details from the request.
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // 2c. Create a new credential for Firebase.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 2d. Once signed in, return the UserCredential from Firebase.
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
      
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Exception on Google Sign In: ${e.message}");
      return null;
    } catch (e) {
      print("An unexpected error occurred during Google sign in: $e");
      return null;
    }
  }
  
  Future<void> signOut() async {
  try {
    await _auth.signOut();
  } catch (e) {
    print("An error occurred during sign out: $e");
  }
}
  // We will add more methods here later (signIn, signOut, etc.)
}