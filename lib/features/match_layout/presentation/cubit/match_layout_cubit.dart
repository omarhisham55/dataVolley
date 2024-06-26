import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/shared/usecases.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/image/image_usecase.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/match/match_usecase.dart';
import 'package:data_volley_match/features/match_layout/domain/usecases/team/team_usecases.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/team_color_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'match_layout_state.dart';

class MatchLayoutCubit extends Cubit<MatchLayoutState> {
  final CreateTeamUsecase createTeamUsecase;
  final GetTeamsUsecase getTeamsUsecase;
  final EditTeamUsecase editTeamUsecase;
  final DeleteTeamUsecase deleteTeamsUsecase;
  final ImageUsecase imageUsecase;
  final SaveMatchUsecase saveMatchUsecase;
  final GetMatchesUsecase getMatchesUsecase;
  final EditMatchUsecase editMatchUsecase;
  final DeleteMatchUsecase deleteMatchUsecase;
  MatchLayoutCubit({
    required this.createTeamUsecase,
    required this.getTeamsUsecase,
    required this.editTeamUsecase,
    required this.deleteTeamsUsecase,
    required this.imageUsecase,
    required this.saveMatchUsecase,
    required this.getMatchesUsecase,
    required this.editMatchUsecase,
    required this.deleteMatchUsecase,
  }) : super(MatchLayoutInitial());

  static MatchLayoutCubit get(context) => BlocProvider.of(context);
  final PanelController createNewTeamPanelController = PanelController();
  final GlobalKey<FormState> createNewTeamFormKey = GlobalKey<FormState>();
  final TextEditingController createNewTeamNameController =
      TextEditingController();
  final PanelController editTeamPanelController = PanelController();
  final GlobalKey<FormState> editTeamFormKey = GlobalKey<FormState>();
  final TextEditingController editTeamNameController = TextEditingController();
  final PanelController editMatchPanelController = PanelController();
  final GlobalKey<FormState> editMatchFormKey = GlobalKey<FormState>();
  String level = '';
  String? createdTeamImage;
  String? editedTeamImage;
  Map<String, List<TeamModel>> allTeams = {};
  Map<String, List<MatchModel>> allMatches = {};
  late List<String> teamlevels = ['15', '17', '19', '1st'];
  late List<String> matchlevels = ['15', '17', '19', '1st', 'friendly'];
  List<TeamModel>? combinedLevels;

  TeamModel? homeTeam;
  TeamModel? awayTeam;

  void resetForm() {
    level = '';
    createNewTeamNameController.text = '';
    createdTeamImage = null;
    editTeamNameController.text = '';
    emit(ClearFormState());
  }

  //* Team CRUD methods
  Future<void> createTeam() async {
    emit(CreateTeamLoadingState());
    final response = await createTeamUsecase(
      TeamModel(
        id: Constants.generateRandomId(),
        name: createNewTeamNameController.text,
        level: level,
        color: TeamColorPicker.color,
        image: createdTeamImage,
      ),
    );
    getTeams();
    resetForm();
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

  Future<void> editTeam() async {
    emit(EditTeamLoadingState());
    final response = await editTeamUsecase(
      TeamModel(
        id: selectedTeam.id,
        name: editTeamNameController.text,
        level: level.isNotEmpty ? level : selectedTeam.level,
        color: TeamColorPicker.color,
        image: createdTeamImage ?? selectedTeam.image,
      ),
    );
    resetForm();
    getTeams();
    onEditClick();
    emit(
      response.fold(
        (l) => EditTeamErrorState(error: l.props.toString()),
        (r) => EditTeamSuccessState(state: r),
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

  //* Images
  Future<void> addTeamImage() async {
    emit(AddImageLoadingState());
    final response = await imageUsecase(NoParam());
    emit(
      response.fold(
        (l) => AddImageErrorState(error: l.props.toString()),
        (r) {
          createdTeamImage = r;
          return AddImageSuccessState();
        },
      ),
    );
  }

  //* handle edit panel
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
    TeamColorPicker.color = selectedTeam.color;
    emit(OpenEditTeam(isEditClicked));
  }

  //* checking teams avavilability
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

  //* match positions
  final List<List<TextEditingController>> homeTeamPositions = List.generate(
    5,
    (index) => List.generate(
      6,
      (index) => TextEditingController(),
    ),
  );
  late final List<List<String>> playedHomeTeamPositions = homeTeamPositions
      .map(
        (e) => e
            .map((e) => e.text)
            .toList()
            .takeWhile(
              (value) => value.isNotEmpty,
            )
            .toList(),
      )
      .toList();

  final List<TextEditingController> homeTeamSetter = List.generate(
    5,
    (index) => TextEditingController(),
  );

  final List<TextEditingController> awayTeamSetter = List.generate(
    5,
    (index) => TextEditingController(),
  );

  final List<List<TextEditingController>> awayTeamPositions = List.generate(
    5,
    (index) => List.generate(
      6,
      (index) => TextEditingController(),
    ),
  );

  late final List<List<String>> playedAwayTeamPositions = awayTeamPositions
      .map(
        (e) => e
            .map((e) => e.text)
            .toList()
            .takeWhile(
              (value) => value.isNotEmpty,
            )
            .toList(),
      )
      .toList();

  //* match score
  final List<TextEditingController> homeMatchScore = List.generate(
    5,
    (index) => TextEditingController(),
  );
  final List<TextEditingController> awayMatchScore = List.generate(
    5,
    (index) => TextEditingController(),
  );
  late final homeTotalWonSets = homeMatchScore.takeWhile(
    (value) => value.text == '25',
  );
  late final awayTotalWonSets = awayMatchScore.takeWhile(
    (value) => value.text == '25',
  );

  late final String matchLevel =
      homeTeam!.level == awayTeam!.level ? homeTeam!.level : 'friendly';
  late final List<String> homeSetterPositions = homeTeamSetter
      .map((e) => e.text)
      .toList()
      .takeWhile((value) => value.isNotEmpty)
      .toList();
  late final List<String> awaySetterPositions = awayTeamSetter
      .map((e) => e.text)
      .toList()
      .takeWhile((value) => value.isNotEmpty)
      .toList();

  //* setter in position
  void setSetters() {
    emit(SetterState(isSetterFound: DateTime.now().second));
  }

  List<String> combinedScore(
    List<TextEditingController> homeScore,
    List<TextEditingController> awayScore,
  ) {
    List<String> finalList = [];
    final List<String> h = homeScore.map((e) => e.text).toList();
    final List<String> a = awayScore.map((e) => e.text).toList();
    if (h.length == a.length) {
      for (int i = 0; i < h.length; i++) {
        finalList.add('${h[i]}:${a[i]}');
      }
    } else {
      Constants.showToast(
        msg: 'check your score',
        color: MainColors.errorColor,
      );
      throw Exception();
    }
    return finalList;
  }

  //* match CRUD methods
  bool isFriendly = false;
  bool isVideoCaptured = false;
  Future<void> saveMatch() async {
    emit(SaveMatchLoadingState());
    final response = await saveMatchUsecase(
      MatchModel(
        id: Constants.generateRandomId(),
        level: matchLevel,
        homeTeam: homeTeam!,
        awayTeam: awayTeam!,
        homeSetters: homeSetterPositions,
        homeTeamPosition: MatchModel.positionSet(playedHomeTeamPositions),
        awaySetters: awaySetterPositions,
        awayTeamPosition: MatchModel.positionSet(playedAwayTeamPositions),
        score: combinedScore(homeMatchScore, awayMatchScore),
        dateTime: DateTime.now().toString(),
        isFriendly: isFriendly,
        videoExist: isVideoCaptured,
      ),
    );
    getMatches();
    isFriendly = false;
    isVideoCaptured = false;
    emit(
      response.fold(
        (l) => SaveMatchErrorState(error: l.props.toString()),
        (r) => SaveMatchSuccessState(state: r),
      ),
    );
  }

  void changeFriendly() {
    isFriendly = true;
    emit(ChangeFriendly());
  }

  void changeVideoState() {
    isFriendly = true;
    emit(ChangeVideoState());
  }

  Future<void> getMatches() async {
    final response = await getMatchesUsecase(NoParam());
    emit(
      response.fold(
        (l) => GetMatchesErrorState(error: l.props.toString()),
        (r) {
          allMatches = r;
          return GetMatchesSuccessState(count: r.length);
        },
      ),
    );
  }

  Future<void> editMatch() async {
    emit(EditTeamLoadingState());
    // final response = await editMatchUsecase();
  }

  Future<void> deleteMatch() async {
    emit(DeleteTeamLoadingState());
    final response = await deleteMatchUsecase(selectedMatch);
    emit(
      response.fold(
        (l) => DeleteMatchErrorState(error: l.props.toString()),
        (r) => DeleteMatchSuccessState(state: r),
      ),
    );
  }

  late MatchModel selectedMatch;
  bool isMatchEditOpen = false;
  String? getScoreFromMatch(List<dynamic>? matchScore) {
    List<String> homeList = [];
    List<String> awayList = [];
    for (var element in matchScore ?? []) {
      if (element is String) {
        // if (int.parse(element.split(':')[0]) > 25 &&
        //     int.parse(element.split(':')[1]) > 25) {
        //   if (int.parse(element.split(':')[0]) >
        //       int.parse(element.split(':')[1])) {
        //     homeList.add(element.split(':')[0]);
        //   } else {
        //     awayList.add(element.split(':')[1]);
        //   }
        // } else
        if (element.split(':')[0] == '25') {
          homeList.add(element.split(':')[0]);
        } else if (element.split(':')[1] == '25') {
          awayList.add(element.split(':')[1]);
        }
      }
    }
    return '${homeList.length} - ${awayList.length}';
  }
}
