import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranking_model.freezed.dart';
part 'ranking_model.g.dart';

@freezed
abstract class RankingModel with _$RankingModel {
  const factory RankingModel({
    required String userId,
    required String nickname,
    @Default(0) int totalMatches,
    @Default(0) int wins,
    @Default(0.0) double winRate,
    required DateTime updatedAt,
  }) = _RankingModel;

  factory RankingModel.fromJson(Map<String, dynamic> json) =>
      _$RankingModelFromJson(json);
}
