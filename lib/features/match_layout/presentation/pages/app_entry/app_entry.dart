import 'package:data_volley_match/config/routes/routes.dart';
import 'package:data_volley_match/core/firebase/firebase_consumer.dart';
import 'package:data_volley_match/core/shared/constants.dart';
import 'package:data_volley_match/features/match_layout/presentation/widgets/start_container.dart';
import 'package:flutter/material.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              // onTap: () => Constants.goTo(context, Routes.allTeams),
              onTap: () => FirebaseConsumer.logout(),
              child: const Icon(Icons.people),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StartContainer(
              text: 'Start Match',
              onTap: () => Constants.goTo(context, Routes.selectTeams),
            ),
          ),
          Expanded(
            child: StartContainer(
              text: 'All Matches',
              onTap: () => Constants.goTo(context, Routes.allMatches),
            ),
          ),
        ],
      ),
    );
  }
}
