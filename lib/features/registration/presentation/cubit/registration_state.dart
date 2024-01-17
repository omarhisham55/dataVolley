part of 'registration_cubit.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class UserRegistrationLoading extends RegistrationState {}

class UserRegistrationSuccess extends RegistrationState {
  final Object? user;

  const UserRegistrationSuccess({this.user});

  @override
  List<Object?> get props => [user];
}

class UserRegistrationFail extends RegistrationState {
  final Object? error;

  const UserRegistrationFail({this.error});

  @override
  List<Object?> get props => [error];
}
