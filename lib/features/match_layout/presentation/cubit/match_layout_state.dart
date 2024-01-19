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

class OpenEditTeam extends MatchLayoutState {
  final bool state;

  const OpenEditTeam(this.state);

  @override
  List<Object> get props => [state];
}

class OpenEditPanel extends MatchLayoutState {
  final bool state;

  const OpenEditPanel(this.state);

  @override
  List<Object> get props => [state];
}

class EditTeamLoadingState extends MatchLayoutState {}

class EditTeamSuccessState extends MatchLayoutState {
  final bool state;

  const EditTeamSuccessState({required this.state});

  @override
  List<Object> get props => [state];
}

class EditTeamErrorState extends MatchLayoutState {
  final String error;

  const EditTeamErrorState({required this.error});

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

class DeleteTeamLoadingState extends MatchLayoutState {}

class DeleteTeamSuccessState extends MatchLayoutState {
  final bool state;

  const DeleteTeamSuccessState({required this.state});

  @override
  List<Object> get props => [state];
}

class DeleteTeamErrorState extends MatchLayoutState {
  final String error;

  const DeleteTeamErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AddImageSuccessState extends MatchLayoutState {}

class AddImageErrorState extends MatchLayoutState {
  final String error;

  const AddImageErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
