import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:flutter/material.dart';

class TeamTable extends StatelessWidget {
  final MatchLayoutCubit manager;
  final List<List<TextEditingController>> positions;
  const TeamTable({super.key, required this.manager, required this.positions});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: List.generate(
              positions.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'set ${index + 1}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: DataTable(
            columnSpacing: 0,
            columns: List.generate(
              6,
              (index) => DataColumn(
                label: Container(),
              ),
            ),
            rows: List.generate(
              5,
              (index) {
                final rowData = positions[index];
                final cells = List.generate(
                  6,
                  (cellIndex) {
                    if (cellIndex < rowData.length) {
                      return DataCell(Text(
                        rowData[cellIndex].text,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ));
                    } else {
                      return const DataCell(Text(''));
                    }
                  },
                );
                return DataRow(cells: cells);
              },
            ),
          ),
        ),
      ],
    );
  }
}
