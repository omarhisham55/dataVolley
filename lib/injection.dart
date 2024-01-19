import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_volley_match/core/firebase/firebase_consumer.dart';
import 'package:data_volley_match/core/firebase/firestore/firebase_storage.dart';
import 'package:data_volley_match/core/firebase/firestore/match_firestore_consumer.dart';
import 'package:data_volley_match/core/firebase/firestore/team_firestore_consumer.dart';
import 'package:data_volley_match/core/firebase/firestore/user_firestore_consumer.dart';
import 'package:data_volley_match/core/utils/images.dart';
import 'package:data_volley_match/features/match_layout/data/datasources/image/image_datasource.dart';
import 'package:data_volley_match/features/match_layout/data/repositories/image/image_repository_impl.dart';
import 'package:data_volley_match/features/match_layout/domain/repositories/image/image_repository.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/image/image_usecase.dart';
import 'package:data_volley_match/features/match_layout/match_injection.dart';
import 'package:data_volley_match/features/registration/registration_injection.dart';
import 'package:data_volley_match/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injection = GetIt.instance;
Future<void> init() async {
  firebaseInjection();
  registrationInit();
  imgInit();
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
  injection.registerLazySingleton(() => FirebaseStorage.instance);
  injection.registerLazySingleton<FirebaseConsumer>(
    () => FirebaseConsumer(client: injection(), storage: injection()),
  );
  injection.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  injection.registerLazySingleton<FirebaseStorageConsumer>(
    () => FirebaseStorageConsumer(
      client: injection(),
      imageManager: injection(),
    ),
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

Future<void> imgInit() async {
  injection.registerLazySingleton(() => ImageManager());

  injection.registerLazySingleton<ImageRepository>(
    () => ImageRepositoryImpl(imageDatasource: injection()),
  );
  injection.registerLazySingleton<ImageDatasource>(
    () => ImageDatasourceImpl(firebaseStorageConsumer: injection()),
  );
  injection.registerLazySingleton(
    () => ImageUsecase(imageRepository: injection()),
  );
}
