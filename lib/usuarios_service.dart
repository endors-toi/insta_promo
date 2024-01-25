import 'package:cloud_firestore/cloud_firestore.dart';

class UsuariosService {
  static final _collection = FirebaseFirestore.instance.collection('usuarios');

  static Stream<QuerySnapshot> get() {
    return _collection.snapshots();
  }

  static Future<void> add(String user) async {
    await _collection.doc().set({'usuario': user});
  }

  static Future<bool> exists(String user) async {
    var querySnapshot =
        await _collection.where('usuario', isEqualTo: user).limit(1).get();
    return querySnapshot.docs.isNotEmpty;
  }

  static Future<void> clear() async {
    var querySnapshot = await _collection.get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
