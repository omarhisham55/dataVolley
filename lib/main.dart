import 'package:data_volley_match/config/routes/routes.dart';
import 'package:data_volley_match/config/theme/theme.dart';
import 'package:data_volley_match/core/shared/bloc_observer.dart';
import 'package:data_volley_match/core/utils/strings.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/registration/presentation/cubit/registration_cubit.dart';
import 'package:data_volley_match/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_volley_match/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.injection<RegistrationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.injection<MatchLayoutCubit>()..getTeams(),
        ),
      ],
      child: MaterialApp(
        title: MainStrings.appName,
        theme: appTheme,
        onGenerateRoute: (settings) =>
            OnGenerateRoute.onGenerateRoute(settings),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
