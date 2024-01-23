import 'package:data_volley_match/features/match_layout/presentation/cubit/match_layout_cubit.dart';
import 'package:flutter/material.dart';

class TeamTable extends StatelessWidget {
  final MatchLayoutCubit manager;
  final List<List<String>> positions;
  final List<String> setterPosition;
  const TeamTable({
    super.key,
    required this.manager,
    required this.positions,
    required this.setterPosition,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowHeight: 10,
      columnSpacing: 20,
      columns: List.generate(
        7,
        (index) => DataColumn(
          label: Container(),
        ),
      ),
      rows: List.generate(
        5,
        (index) {
          final rowData = positions[index];
          final cells = List.generate(
            7,
            (cellIndex) {
              if (cellIndex == 0) {
                return DataCell(
                  Text(
                    'set ${index + 1}',
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 1,
                  ),
                );
              }
              if (cellIndex < rowData.length) {
                return DataCell(
                  CircleAvatar(
                    backgroundColor: rowData[cellIndex] == setterPosition[index]
                        ? Colors.white
                        : Colors.transparent,
                    child: Text(
                      rowData[cellIndex],
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              } else {
                return const DataCell(Text(''));
              }
            },
          );
          return DataRow(cells: cells);
        },
      ),
    );
  }
}
