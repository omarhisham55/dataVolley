import 'package:data_volley_match/core/utils/hex_color.dart';
import 'package:data_volley_match/features/match_layout/domain/entities/team.dart';

class TeamModel extends Team {
  const TeamModel({
    required super.name,
    required super.level,
    required super.color,
    super.image,
  });
  

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        name: json['name'],
        level: json['level'],
        color: HexColor(json['color']),
        image: json['image'],
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'color': color.value.toRadixString(16),
      'image': image,
    };
  }
}
