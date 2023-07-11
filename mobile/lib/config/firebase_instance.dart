import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:front/config/firebase_options.dart';

class FirebaseInstance {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseAuth get auth => _firebaseAuth;
  static FirebaseFirestore get firestore => _firestore;

  static final Future<FirebaseApp> initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
