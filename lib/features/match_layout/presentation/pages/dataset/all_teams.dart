import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/core/utils/images.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/tabs.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/team_manager_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AllTeams extends StatelessWidget {
  const AllTeams({super.key});

  @override
  Widget build(BuildContext context) {
    final MatchLayoutCubit manager = MatchLayoutCubit.get(context);
    return BlocBuilder<MatchLayoutCubit, MatchLayoutState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: manager.allTeams.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          builder: (context) {
            return SlidingUpPanel(
              controller: manager.editTeamPanelController,
              minHeight: 0,
              maxHeight: manager.editPanelMaxHeight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              panel: _editTeamPanel(context, manager),
              body: Tabs(
                length: manager.levels.length,
                tabs: manager.levels,
                tabsBody: manager.allTeams.entries
                    .map(
                      (value) => _viewTeamLevel(context, value.value, manager),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _viewTeamLevel(
    BuildContext context,
    List<TeamModel> teamModels,
    MatchLayoutCubit manager,
  ) {
    return BlocBuilder<MatchLayoutCubit, MatchLayoutState>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: teamModels.isNotEmpty,
            fallback: (context) => Center(
                  child: Text(
                    "No Teams Available",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
            builder: (context) {
              return Column(
                children: [
                  if (state is DeleteTeamLoadingState ||
                      state is EditTeamLoadingState)
                    const LinearProgressIndicator(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: teamModels.length,
                    itemBuilder: (context, index) => _viewTeamItem(
                      context,
                      teamModels[index],
                      manager,
                    ),
                  ),
                ],
              );
            });
      },
    );
  }

  Widget _viewTeamItem(
    BuildContext context,
    TeamModel team,
    MatchLayoutCubit manager,
  ) {
    return InkWell(
      onTap: () => manager.editTeamPanelController.isPanelOpen
          ? manager.editTeamPanelController.close()
          : null,
      onLongPress: () => manager.openEditPanel(team),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: team.image == null
                    ? const DecorationImage(
                        image: AssetImage(MainImages.unknownClub))
                    : DecorationImage(
                        image: NetworkImage(team.image ?? ''),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  team.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            Container(
              width: 20,
              height: 20,
              color: team.color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _editTeamPanel(
    BuildContext context,
    MatchLayoutCubit manager,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        gradient: MainColors.primaryGradient,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SharedWidgets.outlinedButton('EDIT', () => manager.onEditClick()),
          SharedWidgets.filledButton(
            'DELETE',
            () => manager.deleteTeam(),
            color: MainColors.errorColor,
            borderRadius: 10,
            textPadding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(top: 10),
          ),
          Visibility(
            visible: manager.isEditClicked,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 200),
              scale: manager.isEditClicked ? 1 : 0,
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Material(
                  color: MainColors.secondaryColor,
                  borderRadius: BorderRadius.circular(24),
                  child: TeamManagerPanel(
                    formKey: manager.editTeamFormKey,
                    controller: manager.editTeamNameController,
                    manager: manager,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    textButton: 'Submit',
                    onSubmit: () =>
                        manager.editTeamFormKey.currentState!.validate() &&
                                manager.level.isNotEmpty
                            ? manager.editTeam()
                            : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
