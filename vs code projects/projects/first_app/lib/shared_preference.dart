import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserPreference(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);

    User? user = _auth.currentUser;

    if (user != null) {
      await _firestore
          .collection('user_preferences')
          .doc(user.uid)
          .set({key: value}, SetOptions(merge: true));
    }
  }

  Future<String?> getUserPreference(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key);

    User? user = _auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('user_preferences')
          .doc(user.uid)
          .get();

      Map<String, dynamic>? data = snapshot.data();

      if (data != null && data.containsKey(key)) {
        return data[key];
      }
    }

    return value;
  }
}
