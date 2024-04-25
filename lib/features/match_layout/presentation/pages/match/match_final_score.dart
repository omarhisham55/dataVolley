import 'package:data_volley_match/config/routes/routes.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
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
                  SharedWidgets.score(
                    context: context,
                    manager: manager,
                  ),
                  SharedWidgets.viewSets(
                    context: context,
                    manager: manager,
                  ),
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
}
