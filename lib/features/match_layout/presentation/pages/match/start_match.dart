import 'package:flutter/material.dart';

class StartMatch extends StatelessWidget {
  const StartMatch({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar appbar(int index) => AppBar(
          automaticallyImplyLeading: false,
          title: Text('Set ${index + 1}'),
          actions: [
            IconButton(
              icon: const Icon(Icons.table_chart_outlined),
              onPressed: () {},
            ),
          ],
        );
    return PageView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Scaffold(
        appBar: appbar(index),
        body: Container(),
      ),
    );
  }
}
