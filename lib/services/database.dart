import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection = FirebaseFirestore.instance.collection("users");

  Future<void> editUser(String name, String photo, String country) async {
    return await userCollection.doc(uid).set(
        {'name': name, 'photo': photo,'country':country}
    );
  }

}
