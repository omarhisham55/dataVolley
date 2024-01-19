import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/features/match_layout/data/models/team_model.dart';
import 'package:flutter/material.dart';

class SelectTeamDropdown extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Function(dynamic) onChanged;
  final List<dynamic> items;
  final String emptyListText;
  const SelectTeamDropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.items,
    required this.emptyListText,
  });

  @override
  Widget build(BuildContext context) {
    items.isEmpty
        ? Constants.showToast(
            msg: emptyListText,
            color: MainColors.waringColor,
          )
        : null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<dynamic>(
        dropdownColor: MainColors.primaryColor,
        hint: Text(
          hintText,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.grey),
        ),
        style: Theme.of(context).textTheme.titleSmall,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.titleSmall,
        ),
        items: items.map(
          (item) {
            return item is TeamModel
                ? _dropDownTeams(item)
                : _dropDownItem(item);
          },
        ).toList(),
        value: null,
        onChanged: onChanged,
      ),
    );
  }

  DropdownMenuItem<String> _dropDownItem(String text) =>
      DropdownMenuItem<String>(
        value: text,
        child: Text(text),
      );

  DropdownMenuItem<TeamModel> _dropDownTeams(TeamModel team) =>
      DropdownMenuItem<TeamModel>(
        value: team,
        child: Text('${team.level} ${team.name}'),
      );
}
