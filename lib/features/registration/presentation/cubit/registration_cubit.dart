import 'package:data_volley_match/core/shared/usecases.dart';
import 'package:data_volley_match/features/registration/domain/usecases/user_registration_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final UserEmailRegistrationUsecase userEmailRegistrationUsecase;
  final UserGoogleRegistrationUsecase googleRegistrationUsecase;
  final UserLoginUsecase userLoginusecase;
  RegistrationCubit({
    required this.userEmailRegistrationUsecase,
    required this.googleRegistrationUsecase,
    required this.userLoginusecase,
  }) : super(RegistrationInitial());

  static final GlobalKey<FormState> createEmailUserFormKey =
      GlobalKey<FormState>();
  static final GlobalKey<FormState> loginUserFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> createEmailUser() async {
    final response = await userEmailRegistrationUsecase([
      emailController.text,
      passwordController.text,
    ]);
    emit(
      response.fold(
        (l) => UserRegistrationFail(error: l),
        (r) => UserRegistrationSuccess(user: r!.email),
      ),
    );
  }

  Future<void> createGoogleUser() async {
    final response = await googleRegistrationUsecase(NoParam());
    emit(
      response.fold(
        (l) => UserRegistrationFail(error: l),
        (r) => UserRegistrationSuccess(user: r!.email),
      ),
    );
  }

  Future<void> login() async {
    emit(UserRegistrationLoading());
    final response = await userLoginusecase([
      emailController.text,
      passwordController.text,
    ]);
    emit(
      response.fold(
        (l) => UserRegistrationFail(error: l),
        (r) => UserRegistrationSuccess(user: r),
      ),
    );
  }
}
