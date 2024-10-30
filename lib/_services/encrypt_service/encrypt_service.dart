import 'package:auth_324/_common/constants/app_functions.dart';
import 'package:encrypt/encrypt.dart';

class EncryptService {
  static final _iv = IV.fromLength(16); // Adjusted to 16 for AES block size
  static final _secretKey = Key.fromUtf8("aklr92YH25FFls92kg765TFGHsew41ol");

  // Test function to demonstrate encryption and decryption
  test() {
    const plainText = 'hello world';

    final encryptor = Encrypter(AES(_secretKey));

    final encrypted = encryptor.encrypt(plainText, iv: _iv);
    final decrypted = encryptor.decrypt(encrypted, iv: _iv);

    superPrint(encrypted.base64);
    superPrint(decrypted);
  }

  // Method to decrypt text
  String? decryptText({required String encryptedText}) {
    String? result;
    try {
      final encryptor = Encrypter(AES(_secretKey));
      final encrypted = Encrypted.fromBase64(encryptedText);
      result = encryptor.decrypt(encrypted, iv: _iv);
    } catch (e) {
      superPrint("Decryption error: $e");
    }
    return result;
  }

  // Method to encrypt text
  String? encryptText({required String plainText}) {
    String? result;
    try {
      final encryptor = Encrypter(AES(_secretKey));
      final encrypted = encryptor.encrypt(plainText, iv: _iv);
      result = encrypted.base64;
    } catch (e) {
      superPrint("Encryption error: $e");
    }
    return result;
  }
}
