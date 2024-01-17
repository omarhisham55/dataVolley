import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/team_color_picker.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/select_team_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNewTeamPanel extends StatelessWidget {
  final MatchLayoutCubit manager;
  const CreateNewTeamPanel({
    super.key,
    required this.manager,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchLayoutCubit, MatchLayoutState>(
      listener: (context, state) {
        if (state is CreateTeamSuccessState) {
          if (state.state == true) {
            BlocProvider.of<MatchLayoutCubit>(context)
                .createNewTeamPanelController
                .close();
          }
        }
      },
      builder: (context, state) {
        return Form(
          key: manager.createNewTeamFormKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SharedWidgets.hintTextField(
                      context: context,
                      hintText: 'Enter team name',
                      controller: manager.createNewTeamNameController,
                      keyboardType: TextInputType.name,
                      validate: (value) =>
                          value!.isEmpty ? 'Enter team name' : null,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: TeamColorPicker(),
                  ),
                ],
              ),
              SelectTeamDropdown(
                labelText: '',
                hintText: 'Select level',
                onChanged: (value) {
                  manager.level = value!;
                },
                items: const ['15', '17', '19', '1st'],
              ),
              ConditionalBuilder(
                condition: state is! CreateTeamLoadingState,
                builder: (context) => SharedWidgets.filledButton(
                  'Create',
                  () => manager.createNewTeamFormKey.currentState!.validate() &&
                          manager.level.isNotEmpty
                      ? manager.createTeam()
                      : null,
                  width: 200,
                  margin: const EdgeInsets.only(top: 30),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
