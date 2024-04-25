import 'package:data_volley_match/core/shared/widgets.dart';
import 'package:data_volley_match/core/utils/colors.dart';
import 'package:data_volley_match/features/match_layout/data/models/match_model.dart';
import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:flutter/material.dart';

class ExpansionPanelMatchList extends StatefulWidget {
  final List<MatchModel> matchModels;
  final MatchLayoutCubit manager;
  const ExpansionPanelMatchList({
    super.key,
    required this.matchModels,
    required this.manager,
  });

  @override
  State<ExpansionPanelMatchList> createState() =>
      _ExpansionPanelMatchListState();
}

class _ExpansionPanelMatchListState extends State<ExpansionPanelMatchList> {
  int expand = -1;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: const Duration(milliseconds: 1000),
      expansionCallback: (panelIndex, isExpanded) {},
      children: widget.matchModels
          .map(
            (match) => _viewMatchItem(
              context,
              widget.matchModels.indexOf(match),
              match,
              widget.manager,
            ),
          )
          .toList(),
    );
  }

  ExpansionPanel _viewMatchItem(
    BuildContext context,
    int expand,
    MatchModel match,
    MatchLayoutCubit manager,
  ) {
    return ExpansionPanel(
      backgroundColor: MainColors.secondaryColor,
      isExpanded: expand == this.expand,
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) => InkWell(
        onTap: () => setState(() {
          this.expand == expand ? this.expand = -1 : this.expand = expand;
        }),
        child: ListTile(
          title: Text(
            '${match.homeTeam.name} vs ${match.awayTeam.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            match.dateTime,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
      body: _buildViewMatchBody(context, match, manager),
    );
  }

  Widget _buildViewMatchBody(
      BuildContext context, MatchModel match, MatchLayoutCubit manager) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SharedWidgets.score(
            context: context,
            manager: manager,
            match: match,
          ),
          SharedWidgets.viewSets(
            context: context,
            manager: manager,
            match: match,
          ),
        ],
      ),
    );
  }
}
