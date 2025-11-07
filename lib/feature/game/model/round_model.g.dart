// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'round_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoundModel _$RoundModelFromJson(Map<String, dynamic> json) => _RoundModel(
  player1ImageUrl: json['player1ImageUrl'] as String?,
  player2ImageUrl: json['player2ImageUrl'] as String?,
  player1ImageReady: json['player1ImageReady'] as bool? ?? false,
  player2ImageReady: json['player2ImageReady'] as bool? ?? false,
  shootingAt: const NullableDateTimeConverter().fromJson(json['shootingAt']),
  player1UploadedAt: const NullableDateTimeConverter().fromJson(
    json['player1UploadedAt'],
  ),
  player2UploadedAt: const NullableDateTimeConverter().fromJson(
    json['player2UploadedAt'],
  ),
  bothReadyAt: const NullableDateTimeConverter().fromJson(json['bothReadyAt']),
  displayCountdownStartedAt: const NullableDateTimeConverter().fromJson(
    json['displayCountdownStartedAt'],
  ),
  imagesDisplayedAt: const NullableDateTimeConverter().fromJson(
    json['imagesDisplayedAt'],
  ),
  player1SmileDetectedAt: const NullableDateTimeConverter().fromJson(
    json['player1SmileDetectedAt'],
  ),
  player2SmileDetectedAt: const NullableDateTimeConverter().fromJson(
    json['player2SmileDetectedAt'],
  ),
  winner: json['winner'] as String?,
  roundEndedAt: const NullableDateTimeConverter().fromJson(
    json['roundEndedAt'],
  ),
  player1UploadTime: (json['player1UploadTime'] as num?)?.toDouble(),
  player2UploadTime: (json['player2UploadTime'] as num?)?.toDouble(),
  player1ReactionTime: (json['player1ReactionTime'] as num?)?.toDouble(),
  player2ReactionTime: (json['player2ReactionTime'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RoundModelToJson(
  _RoundModel instance,
) => <String, dynamic>{
  'player1ImageUrl': instance.player1ImageUrl,
  'player2ImageUrl': instance.player2ImageUrl,
  'player1ImageReady': instance.player1ImageReady,
  'player2ImageReady': instance.player2ImageReady,
  'shootingAt': const NullableDateTimeConverter().toJson(instance.shootingAt),
  'player1UploadedAt': const NullableDateTimeConverter().toJson(
    instance.player1UploadedAt,
  ),
  'player2UploadedAt': const NullableDateTimeConverter().toJson(
    instance.player2UploadedAt,
  ),
  'bothReadyAt': const NullableDateTimeConverter().toJson(instance.bothReadyAt),
  'displayCountdownStartedAt': const NullableDateTimeConverter().toJson(
    instance.displayCountdownStartedAt,
  ),
  'imagesDisplayedAt': const NullableDateTimeConverter().toJson(
    instance.imagesDisplayedAt,
  ),
  'player1SmileDetectedAt': const NullableDateTimeConverter().toJson(
    instance.player1SmileDetectedAt,
  ),
  'player2SmileDetectedAt': const NullableDateTimeConverter().toJson(
    instance.player2SmileDetectedAt,
  ),
  'winner': instance.winner,
  'roundEndedAt': const NullableDateTimeConverter().toJson(
    instance.roundEndedAt,
  ),
  'player1UploadTime': instance.player1UploadTime,
  'player2UploadTime': instance.player2UploadTime,
  'player1ReactionTime': instance.player1ReactionTime,
  'player2ReactionTime': instance.player2ReactionTime,
};
