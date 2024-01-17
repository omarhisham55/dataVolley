import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/create_new_team_panel.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/select_team_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SelectTeams extends StatelessWidget {
  const SelectTeams({super.key});

  @override
  Widget build(BuildContext context) {
    MatchLayoutCubit manager = MatchLayoutCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: SlidingUpPanel(
        controller: manager.createNewTeamPanelController,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        minHeight: 0,
        maxHeight: 240,
        body: _bodyContent(manager),
        panelBuilder: (sc) => _buildPanel(manager),
      ),
    );
  }

  Widget _bodyContent(MatchLayoutCubit manager) =>
      BlocBuilder<MatchLayoutCubit, MatchLayoutState>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: manager.combinedLevels != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            builder: (context) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectTeamDropdown(
                          labelText: 'Home Team',
                          hintText: 'choose home team',
                          onChanged: (value) {},
                          items: manager.combinedLevels!,
                        ),
                        SelectTeamDropdown(
                          labelText: 'Away Team',
                          hintText: 'choose away team',
                          onChanged: (value) {},
                          items: manager.combinedLevels!,
                        ),
                        SharedWidgets.filledButton(
                          "Create new team",
                          () => manager.createNewTeamPanelController.isAttached
                              ? manager.createNewTeamPanelController
                                      .isPanelClosed
                                  ? manager.createNewTeamPanelController.open()
                                  : manager.createNewTeamPanelController.close()
                              : null,
                          width: 200,
                          margin: const EdgeInsets.only(top: 30),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SharedWidgets.filledButton(
                          'Start Match',
                          () => null,
                          margin: const EdgeInsets.only(
                            top: 40,
                            left: 10,
                            right: 10,
                          ),
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      );

  Widget _buildPanel(MatchLayoutCubit manager) => Container(
        decoration: const BoxDecoration(
          gradient: MainColors.primaryGradient,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: CreateNewTeamPanel(manager: manager),
      );
}
