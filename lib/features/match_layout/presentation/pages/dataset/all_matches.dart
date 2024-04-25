import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/expansion_panel_list.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AllMatches extends StatelessWidget {
  const AllMatches({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchLayoutCubit, MatchLayoutState>(
      listener: (context, state) {},
      builder: (context, state) {
        final MatchLayoutCubit manager = MatchLayoutCubit.get(context);
        return ConditionalBuilder(
          condition: manager.allMatches.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            return SlidingUpPanel(
              controller: manager.editMatchPanelController,
              minHeight: 0,
              // maxHeight: manager.editPanelMaxHeight,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              panel: _editMatchPanel(context, manager),
              body: Tabs(
                isScrollable: true,
                length: manager.matchlevels.length,
                tabs: manager.matchlevels,
                tabsBody: manager.allMatches.entries
                    .map(
                      (value) => _viewMatchLevel(context, value.value, manager),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }

  Widget _editMatchPanel(BuildContext context, MatchLayoutCubit manager) {
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
          SharedWidgets.outlinedButton('EDIT', () => null),
          SharedWidgets.filledButton(
            'DELETE',
            () => manager.deleteMatch(),
            color: MainColors.errorColor,
            borderRadius: 10,
            textPadding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(top: 10),
          ),
        ],
      ),
    );
  }

  Widget _viewMatchLevel(
    BuildContext context,
    List<MatchModel> matchModels,
    MatchLayoutCubit manager,
  ) {
    return BlocBuilder<MatchLayoutCubit, MatchLayoutState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: matchModels.isNotEmpty,
          fallback: (context) => Center(
            child: Text(
              "No matches Available",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state is DeleteMatchLoadingState ||
                      state is EditMatchLoadingState)
                    const LinearProgressIndicator(),
                  ExpansionPanelMatchList(
                    matchModels: matchModels,
                    manager: manager,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
