import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myspot/utils/keyFiles.dart';

final storage = FlutterSecureStorage();

void storageSaveEmail(String email){
  storage.write(key: emailKey, value: email);
}

void storageSavePassword(String password){
  storage.write(key: passwordKey, value: password);
}

Future<String?> storageReadEmail() async {
  return await storage.read(key: emailKey);
}

Future<String?> storageReadPassword() async {
  return await storage.read(key: passwordKey);
}