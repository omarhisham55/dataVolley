import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/shared/usecases.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/team_usecases.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/team_color_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'match_layout_state.dart';

class MatchLayoutCubit extends Cubit<MatchLayoutState> {
  final CreateTeamUsecase createTeamUsecase;
  final GetTeamsUsecase getTeamsUsecase;
  final DeleteTeamUsecase deleteTeamsUsecase;
  MatchLayoutCubit({
    required this.createTeamUsecase,
    required this.getTeamsUsecase,
    required this.deleteTeamsUsecase,
  }) : super(MatchLayoutInitial());

  static MatchLayoutCubit get(context) => BlocProvider.of(context);
  final PanelController createNewTeamPanelController = PanelController();
  final GlobalKey<FormState> createNewTeamFormKey = GlobalKey<FormState>();
  final TextEditingController createNewTeamNameController =
      TextEditingController();
  final PanelController editTeamPanelController = PanelController();
  final GlobalKey<FormState> editTeamFormKey = GlobalKey<FormState>();
  final TextEditingController editTeamNameController = TextEditingController();
  String level = "";
  Map<String, List<TeamModel>> allTeams = {};
  late List<String> levels = ['15', '17', '19', '1st'];
  List<TeamModel>? combinedLevels;

  TeamModel? homeTeam;
  TeamModel? awayTeam;

  Future<void> createTeam() async {
    emit(CreateTeamLoadingState());
    final response = await createTeamUsecase(
      TeamModel(
        id: Constants.generateRandomId(),
        name: createNewTeamNameController.text,
        level: level,
        color: TeamColorPicker.color,
      ),
    );
    getTeams();
    emit(
      response.fold(
        (l) => CreateTeamErrorState(error: l.props.toString()),
        (r) => CreateTeamSuccessState(state: r),
      ),
    );
  }

  Future<void> getTeams() async {
    final response = await getTeamsUsecase(NoParam());
    emit(
      response.fold(
        (l) => GetTeamsErrorState(error: l.props.toString()),
        (r) {
          allTeams = r;
          combinedLevels = [];
          for (var value in allTeams.values) {
            combinedLevels?.addAll(value);
          }
          return GetTeamsSuccessState(count: r.length);
        },
      ),
    );
  }

  Future<void> deleteTeam() async {
    emit(DeleteTeamLoadingState());
    final response = await deleteTeamsUsecase(selectedTeam);
    getTeams();
    editTeamPanelController.close();
    emit(
      response.fold(
        (l) => DeleteTeamErrorState(error: l.props.toString()),
        (r) => DeleteTeamSuccessState(state: r),
      ),
    );
  }

  double editPanelMaxHeight = 160;
  bool isEditClicked = false;
  late TeamModel selectedTeam;
  void openEditPanel(TeamModel team) {
    selectedTeam = team;
    editTeamPanelController.isPanelClosed
        ? editTeamPanelController.open()
        : editTeamPanelController.close();
    emit(OpenEditPanel(editTeamPanelController.isPanelClosed));
  }

  void onEditClick() {
    isEditClicked = !isEditClicked;
    isEditClicked ? editPanelMaxHeight = 400 : editPanelMaxHeight = 160;
    editTeamNameController.text = selectedTeam.name;
    emit(OpenEditTeam(isEditClicked));
  }

  bool checkBeforeMatchStart() {
    if (homeTeam == null || awayTeam == null) {
      Constants.showToast(
        msg: 'No Teams Found!',
        color: MainColors.waringColor,
      );
      return false;
    } else if (homeTeam == awayTeam) {
      Constants.showToast(
        msg: 'Same Teams!',
        color: MainColors.waringColor,
      );
      return false;
    }
    return true;
  }
}
