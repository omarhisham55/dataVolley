part of 'match_layout_cubit.dart';

abstract class MatchLayoutState extends Equatable {
  const MatchLayoutState();

  @override
  List<Object> get props => [];
}

class MatchLayoutInitial extends MatchLayoutState {}

class CreateTeamLoadingState extends MatchLayoutState {}

class CreateTeamSuccessState extends MatchLayoutState {
  final bool state;

  const CreateTeamSuccessState({required this.state});

  @override
  List<Object> get props => [state];
}

class CreateTeamErrorState extends MatchLayoutState {
  final String error;

  const CreateTeamErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GetTeamsSuccessState extends MatchLayoutState {
  final int count;

  const GetTeamsSuccessState({required this.count});

  @override
  List<Object> get props => [count];
}

class GetTeamsErrorState extends MatchLayoutState {
  final String error;

  const GetTeamsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
