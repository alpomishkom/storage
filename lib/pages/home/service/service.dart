import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storege {
  static final storage = FirebaseStorage.instance;
  static final String path = "Images";
  static Future<String> upload(String path, File file) async {
    Reference reference = storage.ref(path).child('${DateTime.now().toIso8601String()} ${file.path.substring(file.path.lastIndexOf('.'))}');
    UploadTask task = reference.putFile(file);
    await task.whenComplete((){});
    return reference.getDownloadURL();
  }

  static Future<List<String>> gedAll(String path) async {
    List<String> getList = [];
    ListResult items = await storage.ref(path).listAll();
    for (var e in items.items)  {
      getList.add(await e.getDownloadURL());
    }
    return getList;
  }

  static Future<Reference> delet(String path) async {
    Reference res = await storage.ref(path);
    res.delete();
    return res;
  }
}
