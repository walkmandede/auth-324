import 'package:auth_324/_common/constants/app_functions.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DatabaseService {
  final String _connectionString = "mongodb+srv://walkmandede:kokolusoepotato@uosbuc.c0oppu4.mongodb.net/cet324/";
  final String _collectionName = "users";

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      final user = await collection.findOne({
        "email": email,
        "password": password, // Note: Storing plain text passwords is insecure.
      });

      if (user != null) {
        return null; // Success: return null
      } else {
        return "Invalid email or password"; // Failure: return error message
      }
    } catch (e) {
      return "Error during login: $e"; // Failure: return error message
    } finally {
      await db?.close(); // Ensure the database is closed
    }
  }

  Future<String?> register({
    required String email,
    required String password,
  }) async {
    Db? db;
    try {
      db = await Db.create(_connectionString);
      await db.open();
      final collection = db.collection(_collectionName);

      final existingUser = await collection.findOne({"email": email});
      if (existingUser != null) {
        return "Email already registered"; // Failure: return error message
      }

      final writeResult = await collection.insertOne({
        "email": email,
        "password": password, // Consider hashing the password for security
      });
      superPrint(writeResult.errmsg);
      if(writeResult.isSuccess || writeResult.isSuspendedSuccess || writeResult.isPartialSuccess){
        return null; // Success: return null
      }
      else{
        return writeResult.errmsg??"Something went wrong!";
      }
    } catch (e) {
      return "Error during registration: $e"; // Failure: return error message
    } finally {
      await db?.close(); // Ensure the database is closed
    }
  }
}
