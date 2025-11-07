import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hackathon_app/util/datetime_converter.dart';

part 'round_model.freezed.dart';
part 'round_model.g.dart';

@freezed
abstract class RoundModel with _$RoundModel {
  const factory RoundModel({
    String? player1ImageUrl,
    String? player2ImageUrl,
    @Default(false) bool player1ImageReady,
    @Default(false) bool player2ImageReady,
    @NullableDateTimeConverter() DateTime? shootingAt,
    @NullableDateTimeConverter() DateTime? player1UploadedAt,
    @NullableDateTimeConverter() DateTime? player2UploadedAt,
    @NullableDateTimeConverter() DateTime? bothReadyAt,
    @NullableDateTimeConverter() DateTime? displayCountdownStartedAt,
    @NullableDateTimeConverter() DateTime? imagesDisplayedAt,
    @NullableDateTimeConverter() DateTime? player1SmileDetectedAt,
    @NullableDateTimeConverter() DateTime? player2SmileDetectedAt,
    String? winner,
    @NullableDateTimeConverter() DateTime? roundEndedAt,
    double? player1UploadTime,
    double? player2UploadTime,
    double? player1ReactionTime,
    double? player2ReactionTime,
  }) = _RoundModel;

  factory RoundModel.fromJson(Map<String, dynamic> json) =>
      _$RoundModelFromJson(json);
}
