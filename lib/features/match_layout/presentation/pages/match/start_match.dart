import 'package:data_volley_match/config/routes/routes.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/single_box_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartMatch extends StatelessWidget {
  const StartMatch({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar appbar(int index) => AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Set ${index + 1}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.table_chart_outlined),
              onPressed: () {},
            ),
          ],
        );
    final PageController controller = PageController();
    final MatchLayoutCubit manager = MatchLayoutCubit.get(context);
    FocusScope.of(context).addListener(() {
      if (!FocusScope.of(context).hasFocus) {
        manager.setSetters();
      }
    });
    return PageView.builder(
      controller: controller,
      itemCount: 5,
      itemBuilder: (context, index) => Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: appbar(index),
        body: _singlePageView(context, manager, index),
      ),
    );
  }

  Widget _singlePageView(
    BuildContext context,
    MatchLayoutCubit manager,
    int index,
  ) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _teamReviewPosition(
            context,
            manager.homeTeam!,
            manager.homeTeamPositions[index],
            manager.homeTeamSetter[index],
          ),
          _finalScore(
            context,
            manager.homeMatchScore[index],
            manager.awayMatchScore[index],
          ),
          _teamReviewPosition(
            context,
            manager.awayTeam!,
            manager.awayTeamPositions[index],
            manager.awayTeamSetter[index],
          ),
          SharedWidgets.filledButton(
            'End Match',
            () => Constants.goTo(context, Routes.matchFinalScore),
            height: 60,
            margin: const EdgeInsets.all(16),
          ),
        ],
      ),
    );
  }

  Widget _teamReviewPosition(
    BuildContext context,
    TeamModel team,
    List<TextEditingController> positions,
    TextEditingController teamSetter,
  ) {
    return BlocBuilder<MatchLayoutCubit, MatchLayoutState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        team.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: SingleBoxInput(
                        hintText: 'S',
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        controller: teamSetter,
                        borderRadius: 12,
                        color: Colors.white,
                        contentPadding: const EdgeInsets.all(6),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: positions
                    .map(
                      (position) => SingleBoxInput(
                        hintText: position.text,
                        textStyle:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: position.text == teamSetter.text &&
                                          teamSetter.text.isNotEmpty
                                      ? MainColors.primaryColor
                                      : null,
                                ),
                        controller: position,
                        color: position.text == teamSetter.text &&
                                teamSetter.text.isNotEmpty
                            ? Colors.white
                            : MainColors.secondaryColor,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _finalScore(
    BuildContext context,
    TextEditingController homeScoreController,
    TextEditingController awayScoreController,
  ) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 100,
            height: 100,
            child: SingleBoxInput(
              controller: homeScoreController,
              hintText: '00',
              textStyle: Theme.of(context).textTheme.displayLarge,
              hintStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.grey),
            ),
          ),
        ),
        Text(
          ':',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Expanded(
          child: SizedBox(
            width: 100,
            height: 100,
            child: SingleBoxInput(
              controller: awayScoreController,
              hintText: '00',
              textStyle: Theme.of(context).textTheme.displayLarge,
              hintStyle: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
