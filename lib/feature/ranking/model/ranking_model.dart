import 'package:cloud_firestore/cloud_firestore.dart';
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

DateTime _timestampFromJson(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  }
  return DateTime.now();
}

dynamic _timestampToJson(DateTime dateTime) {
  return Timestamp.fromDate(dateTime);
}
