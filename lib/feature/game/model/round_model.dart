import 'package:freezed_annotation/freezed_annotation.dart';

part 'round_model.freezed.dart';
part 'round_model.g.dart';

@freezed
abstract class RoundModel with _$RoundModel {
  const factory RoundModel({
    String? player1ImageUrl,
    String? player2ImageUrl,
    @Default(false) bool player1ImageReady,
    @Default(false) bool player2ImageReady,
    DateTime? shootingAt,
    DateTime? player1UploadedAt,
    DateTime? player2UploadedAt,
    DateTime? bothReadyAt,
    DateTime? displayCountdownStartedAt,
    DateTime? imagesDisplayedAt,
    DateTime? player1SmileDetectedAt,
    DateTime? player2SmileDetectedAt,
    String? winner,
    DateTime? roundEndedAt,
    double? player1UploadTime,
    double? player2UploadTime,
    double? player1ReactionTime,
    double? player2ReactionTime,
  }) = _RoundModel;

  factory RoundModel.fromJson(Map<String, dynamic> json) =>
      _$RoundModelFromJson(json);
}
