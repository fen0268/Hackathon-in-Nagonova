import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hackathon_app/util/datetime_converter.dart';

part 'match_model.freezed.dart';
part 'match_model.g.dart';

@freezed
abstract class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String matchId,
    required String player1,
    required String player2,
    @Default('waiting') String status,
    @DateTimeConverter() required DateTime startedAt,
    @NullableDateTimeConverter() DateTime? finishedAt,
    // 画像
    String? player1ImageUrl,
    String? player2ImageUrl,
    // タイミング
    @NullableDateTimeConverter() DateTime? shootingAt,
    @NullableDateTimeConverter() DateTime? player1UploadedAt,
    @NullableDateTimeConverter() DateTime? player2UploadedAt,
    @NullableDateTimeConverter() DateTime? imagesDisplayedAt,
    // 笑顔判定
    @NullableDateTimeConverter() DateTime? player1SmileDetectedAt,
    @NullableDateTimeConverter() DateTime? player2SmileDetectedAt,
    // 結果
    String? winner,
    @NullableDateTimeConverter() DateTime? gameEndedAt,
    // 統計
    double? player1UploadTime,
    double? player2UploadTime,
    double? player1ReactionTime,
    double? player2ReactionTime,
    @DateTimeConverter() required DateTime createdAt,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}
