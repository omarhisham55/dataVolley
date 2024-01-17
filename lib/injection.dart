import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_volley_match/core/firebase/firebase_consumer.dart';
import 'package:data_volley_match/core/firebase/firestore/match_firestore_consumer.dart';
import 'package:data_volley_match/core/firebase/firestore/team_firestore_consumer.dart';
import 'package:data_volley_match/core/firebase/firestore/user_firestore_consumer.dart';
import 'package:data_volley_match/features/match_layout/match_injection.dart';
import 'package:data_volley_match/features/registration/registration_injection.dart';
import 'package:data_volley_match/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injection = GetIt.instance;
Future<void> init() async {
  firebaseInjection();
  registrationInit();
  matchInit();

  final sharedPreferences = await SharedPreferences.getInstance();
  injection.registerLazySingleton(() => sharedPreferences);
}

Future<void> firebaseInjection() async {
  final firebaseInit = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  injection.registerLazySingleton(() => firebaseInit);

  injection.registerLazySingleton(() => FirebaseAuth.instance);
  injection.registerLazySingleton<FirebaseConsumer>(
    () => FirebaseConsumer(client: injection(), storage: injection()),
  );
  injection.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  injection.registerLazySingleton<UserFirestoreConsumer>(
    () => UserFirestoreConsumer(client: injection()),
  );
  injection.registerLazySingleton<TeamFirestoreConsumer>(
    () => TeamFirestoreConsumer(client: injection()),
  );
  injection.registerLazySingleton<MatchFirestoreConsumer>(
    () => MatchFirestoreConsumer(client: injection()),
  );
}
