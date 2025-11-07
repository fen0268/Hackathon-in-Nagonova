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
  shootingAt: json['shootingAt'] == null
      ? null
      : DateTime.parse(json['shootingAt'] as String),
  player1UploadedAt: json['player1UploadedAt'] == null
      ? null
      : DateTime.parse(json['player1UploadedAt'] as String),
  player2UploadedAt: json['player2UploadedAt'] == null
      ? null
      : DateTime.parse(json['player2UploadedAt'] as String),
  bothReadyAt: json['bothReadyAt'] == null
      ? null
      : DateTime.parse(json['bothReadyAt'] as String),
  displayCountdownStartedAt: json['displayCountdownStartedAt'] == null
      ? null
      : DateTime.parse(json['displayCountdownStartedAt'] as String),
  imagesDisplayedAt: json['imagesDisplayedAt'] == null
      ? null
      : DateTime.parse(json['imagesDisplayedAt'] as String),
  player1SmileDetectedAt: json['player1SmileDetectedAt'] == null
      ? null
      : DateTime.parse(json['player1SmileDetectedAt'] as String),
  player2SmileDetectedAt: json['player2SmileDetectedAt'] == null
      ? null
      : DateTime.parse(json['player2SmileDetectedAt'] as String),
  winner: json['winner'] as String?,
  roundEndedAt: json['roundEndedAt'] == null
      ? null
      : DateTime.parse(json['roundEndedAt'] as String),
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
  'shootingAt': instance.shootingAt?.toIso8601String(),
  'player1UploadedAt': instance.player1UploadedAt?.toIso8601String(),
  'player2UploadedAt': instance.player2UploadedAt?.toIso8601String(),
  'bothReadyAt': instance.bothReadyAt?.toIso8601String(),
  'displayCountdownStartedAt': instance.displayCountdownStartedAt
      ?.toIso8601String(),
  'imagesDisplayedAt': instance.imagesDisplayedAt?.toIso8601String(),
  'player1SmileDetectedAt': instance.player1SmileDetectedAt?.toIso8601String(),
  'player2SmileDetectedAt': instance.player2SmileDetectedAt?.toIso8601String(),
  'winner': instance.winner,
  'roundEndedAt': instance.roundEndedAt?.toIso8601String(),
  'player1UploadTime': instance.player1UploadTime,
  'player2UploadTime': instance.player2UploadTime,
  'player1ReactionTime': instance.player1ReactionTime,
  'player2ReactionTime': instance.player2ReactionTime,
};
