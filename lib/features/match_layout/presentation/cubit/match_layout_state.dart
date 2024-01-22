part of 'match_layout_cubit.dart';

abstract class MatchLayoutState extends Equatable {
  const MatchLayoutState();

  @override
  List<Object> get props => [];
}

class MatchLayoutInitial extends MatchLayoutState {}

class ClearFormState extends MatchLayoutState {}

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

class AddImageLoadingState extends MatchLayoutState {}

class AddImageSuccessState extends MatchLayoutState {}

class AddImageErrorState extends MatchLayoutState {
  final String error;

  const AddImageErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class SetterState extends MatchLayoutState {
  final int isSetterFound;

  const SetterState({required this.isSetterFound});
  @override
  List<Object> get props => [isSetterFound];
}

class SaveMatchLoadingState extends MatchLayoutState {}

class SaveMatchSuccessState extends MatchLayoutState {
  final bool state;

  const SaveMatchSuccessState({required this.state});

  @override
  List<Object> get props => [state];
}

class SaveMatchErrorState extends MatchLayoutState {
  final String error;

  const SaveMatchErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class EditMatchLoadingState extends MatchLayoutState {}

class EditMatchSuccessState extends MatchLayoutState {
  final bool state;

  const EditMatchSuccessState({required this.state});

  @override
  List<Object> get props => [state];
}

class EditMatchErrorState extends MatchLayoutState {
  final String error;

  const EditMatchErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GetMatchesSuccessState extends MatchLayoutState {
  final int count;

  const GetMatchesSuccessState({required this.count});

  @override
  List<Object> get props => [count];
}

class GetMatchesErrorState extends MatchLayoutState {
  final String error;

  const GetMatchesErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class DeleteMatchLoadingState extends MatchLayoutState {}

class DeleteMatchSuccessState extends MatchLayoutState {
  final bool state;

  const DeleteMatchSuccessState({required this.state});

  @override
  List<Object> get props => [state];
}

class DeleteMatchErrorState extends MatchLayoutState {
  final String error;

  const DeleteMatchErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
