import 'package:data_volley_match/config/routes/routes.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/view_team_position_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MatchFinalScore extends StatelessWidget {
  const MatchFinalScore({super.key});

  _openFreindlyDialog(BuildContext context, MatchLayoutCubit manager) {
    return Constants.openDialog(
      context: context,
      msgTitle: 'Friendly Match?',
      msgContent: 'Is this a friendly match?',
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SharedWidgets.filledButton(
            'Yes',
            () {
              manager.changeFriendly();
              return _openVideoDialog(context, manager);
            },
            height: 50,
            borderRadius: 12,
          ),
        ),
        SharedWidgets.outlinedButton(
            'No', () => _openVideoDialog(context, manager)),
      ],
    );
  }

  _openVideoDialog(BuildContext context, MatchLayoutCubit manager) {
    return Constants.openDialog(
      context: context,
      msgTitle: 'Match Captured?',
      msgContent: 'Did you record the match?',
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SharedWidgets.filledButton(
            'Yes',
            () async {
              manager.changeVideoState();
              manager.saveMatch();
            },
            height: 50,
            borderRadius: 12,
          ),
        ),
        SharedWidgets.outlinedButton(
          'No',
          () => manager.saveMatch(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MatchLayoutCubit manager = MatchLayoutCubit.get(context);
    return BlocConsumer<MatchLayoutCubit, MatchLayoutState>(
        listener: (context, state) {
      if (state is SaveMatchSuccessState) {
        if (state.state) {
          Constants.goBackTo(context, Routes.createAccount);
        }
      }
    }, builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state is SaveMatchLoadingState)
                    const LinearProgressIndicator(),
                  _title(context, manager),
                  _score(context, manager),
                  _viewSets(context, manager),
                  SharedWidgets.filledButton(
                    'Save Match',
                    () => _openFreindlyDialog(context, manager),
                    height: 60,
                    margin: const EdgeInsets.all(16),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _title(BuildContext context, MatchLayoutCubit manager) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              manager.homeTeam!.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'vs',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              manager.awayTeam!.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.adaptive.arrow_back),
        ),
      ],
    );
  }

  Widget _score(BuildContext context, MatchLayoutCubit manager) {
    return Column(
      children: [
        Text(
          '${manager.homeTotalWonSets.length} : ${manager.awayTotalWonSets.length}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SizedBox(
          height: 30,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: manager.homeMatchScore.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                manager.homeMatchScore[index].text.isNotEmpty &&
                        manager.awayMatchScore[index].text.isNotEmpty
                    ? '${manager.homeMatchScore[index].text} : ${manager.awayMatchScore[index].text}'
                    : '',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _viewSets(
    BuildContext context,
    MatchLayoutCubit manager,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            manager.homeTeam!.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TeamTable(
            manager: manager,
            positions: manager.playedHomeTeamPositions,
            setterPosition: manager.homeSetterPositions,
          ),
          Text(
            manager.awayTeam!.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          TeamTable(
            manager: manager,
            positions: manager.playedAwayTeamPositions,
            setterPosition: manager.awaySetterPositions,
          ),
        ],
      ),
    );
  }
}
