import 'package:dartz/dartz.dart';
import 'package:data_volley_match/config/error/failure.dart';
import 'package:equatable/equatable.dart';

abstract class FutureUseCase<T, Param> {
  Future<Either<Failure, T>> call(Param param);
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}
