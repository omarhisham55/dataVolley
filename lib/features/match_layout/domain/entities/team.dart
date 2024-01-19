import 'dart:ui';

import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final String id;
  final String name;
  final String level;
  final Color color;
  final String? image;

  const Team({
    required this.id,
    required this.name,
    required this.level,
    required this.color,
    this.image,
  });

  @override
  List<Object?> get props => [name, level];
}
