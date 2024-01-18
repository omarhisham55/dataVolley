import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:data_volley_match/core/utils/images.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/tabs.dart';
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
              panelBuilder: (sc) => _editTeamPanel(context, manager),
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
              return ListView.builder(
                itemCount: teamModels.length,
                itemBuilder: (context, index) => _viewTeamItem(
                  context,
                  teamModels[index],
                  manager,
                ),
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
      onLongPress: () => manager.editTeamPanelController.isPanelClosed
          ? manager.editTeamPanelController.open()
          : manager.editTeamPanelController.close(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: team.image ??
                  'https://i1.sndcdn.com/avatars-000437232558-yuo0mv-t500x500.jpg',
              height: 50,
              errorWidget: (context, url, error) => Image.asset(
                MainImages.unknownClub,
              ),
              placeholder: (context, string) => Image.asset(
                MainImages.unknownClub,
              ),
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
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

  Widget _editTeamPanel(BuildContext context, MatchLayoutCubit manager) {
    return Container();
  }
}
