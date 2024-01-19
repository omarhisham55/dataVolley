import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/team_color_picker.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/select_team_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamManagerPanel extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final MatchLayoutCubit manager;
  final Function() onSubmit;
  final String textButton;
  final EdgeInsets? padding;
  const TeamManagerPanel({
    super.key,
    required this.formKey,
    required this.controller,
    required this.manager,
    required this.onSubmit,
    required this.textButton,
    this.padding = EdgeInsets.zero,
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
        return Padding(
          padding: padding!,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SharedWidgets.hintTextField(
                        context: context,
                        hintText: 'Enter team name',
                        controller: controller,
                        keyboardType: TextInputType.name,
                        validate: (value) =>
                            value!.isEmpty ? 'Enter team name' : null,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const TeamColorPicker(),
                          GestureDetector(
                            onTap: () => null,
                            child:
                                const Icon(Icons.add_photo_alternate_rounded),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SelectTeamDropdown(
                  labelText: '',
                  hintText: 'Select level',
                  onChanged: (value) {
                    manager.level = value!;
                  },
                  items: manager.levels,
                  emptyListText: 'No levels found',
                ),
                ConditionalBuilder(
                  condition: state is! CreateTeamLoadingState,
                  builder: (context) => SharedWidgets.filledButton(
                    textButton,
                    onSubmit,
                    width: 200,
                    margin: const EdgeInsets.only(top: 30),
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
