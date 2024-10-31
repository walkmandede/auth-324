import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = "users";

  // Login function to check email and password in Firestore
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where("email", isEqualTo: email)
          .where("password", isEqualTo: password) // Store hashed passwords for security
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data(); // Success: return user data
      } else {
        return "Invalid email or password"; // Failure: return error message
      }
    } catch (e) {
      return "Error during login: $e"; // Failure: return error message
    }
  }

  // Register function to add a new user to Firestore
  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      // Check if the user already exists
      final existingUser = await _firestore
          .collection(_collectionName)
          .where("email", isEqualTo: email)
          .get();

      if (existingUser.docs.isNotEmpty) {
        return "Email already registered"; // Failure: return error message
      }

      // Add new user if email is not registered
      await _firestore.collection(_collectionName).add({
        "email": email,
        "password": password, // Consider hashing the password for security
      });

      return null; // Success: return null
    } catch (e) {
      return "Error during registration: $e"; // Failure: return error message
    }
  }

  /// Checks if an email is already registered
  /// Returns null if there is no user, or a string error message if email is registered
  Future<String?> isEmailRegistered(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where("email", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return "This email is already registered!";
      } else {
        return null; // Email not registered
      }
    } catch (e) {
      return "Unable to connect to the server!"; // Return error message on failure
    }
  }
}
