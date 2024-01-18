import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/shared/usecases.dart';
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
  MatchLayoutCubit({
    required this.createTeamUsecase,
    required this.getTeamsUsecase,
  }) : super(MatchLayoutInitial());

  static MatchLayoutCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> createNewTeamFormKey = GlobalKey<FormState>();
  final PanelController createNewTeamPanelController = PanelController();
  final TextEditingController teamNameController =
      TextEditingController();
  final PanelController editTeamPanelController = PanelController();
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
        name: teamNameController.text,
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

  bool checkBeforeMatchStart() {
    if (homeTeam == null || awayTeam == null) {
      Constants.showToast(msg: 'No Teams Found!', color: Colors.amber);
      return false;
    } else if (homeTeam == awayTeam) {
      Constants.showToast(msg: 'Same Teams!', color: Colors.amber);
      return false;
    }
    return true;
  }
}
