import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreFunctions {
  static Future<void> printDataFromCollection(String path) async {
    // Get docs from collection reference
    var collectionReference = FirebaseFirestore.instance.collection(path);

    QuerySnapshot querySnapshot = await collectionReference.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    // ignore: avoid_print
    print(allData);
  }

  static Future<List<Object?>> getDataFromCollection(String path) async {
    var collectionReference = FirebaseFirestore.instance.collection(path);
    QuerySnapshot querySnapshot = await collectionReference.get();
    final allData = querySnapshot.docs.map((doc) {
      // print(doc.data().toString());
      return doc.data();
    }).toList();

    return allData;
  }
}
