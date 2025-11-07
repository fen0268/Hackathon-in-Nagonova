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
  shootingAt: _timestampFromJsonNullable(json['shootingAt']),
  player1UploadedAt: _timestampFromJsonNullable(json['player1UploadedAt']),
  player2UploadedAt: _timestampFromJsonNullable(json['player2UploadedAt']),
  bothReadyAt: _timestampFromJsonNullable(json['bothReadyAt']),
  displayCountdownStartedAt: _timestampFromJsonNullable(
    json['displayCountdownStartedAt'],
  ),
  imagesDisplayedAt: _timestampFromJsonNullable(json['imagesDisplayedAt']),
  player1SmileDetectedAt: _timestampFromJsonNullable(
    json['player1SmileDetectedAt'],
  ),
  player2SmileDetectedAt: _timestampFromJsonNullable(
    json['player2SmileDetectedAt'],
  ),
  winner: json['winner'] as String?,
  roundEndedAt: _timestampFromJsonNullable(json['roundEndedAt']),
  player1UploadTime: (json['player1UploadTime'] as num?)?.toDouble(),
  player2UploadTime: (json['player2UploadTime'] as num?)?.toDouble(),
  player1ReactionTime: (json['player1ReactionTime'] as num?)?.toDouble(),
  player2ReactionTime: (json['player2ReactionTime'] as num?)?.toDouble(),
);

Map<String, dynamic> _$RoundModelToJson(_RoundModel instance) =>
    <String, dynamic>{
      'player1ImageUrl': instance.player1ImageUrl,
      'player2ImageUrl': instance.player2ImageUrl,
      'player1ImageReady': instance.player1ImageReady,
      'player2ImageReady': instance.player2ImageReady,
      'shootingAt': _timestampToJsonNullable(instance.shootingAt),
      'player1UploadedAt': _timestampToJsonNullable(instance.player1UploadedAt),
      'player2UploadedAt': _timestampToJsonNullable(instance.player2UploadedAt),
      'bothReadyAt': _timestampToJsonNullable(instance.bothReadyAt),
      'displayCountdownStartedAt': _timestampToJsonNullable(
        instance.displayCountdownStartedAt,
      ),
      'imagesDisplayedAt': _timestampToJsonNullable(instance.imagesDisplayedAt),
      'player1SmileDetectedAt': _timestampToJsonNullable(
        instance.player1SmileDetectedAt,
      ),
      'player2SmileDetectedAt': _timestampToJsonNullable(
        instance.player2SmileDetectedAt,
      ),
      'winner': instance.winner,
      'roundEndedAt': _timestampToJsonNullable(instance.roundEndedAt),
      'player1UploadTime': instance.player1UploadTime,
      'player2UploadTime': instance.player2UploadTime,
      'player1ReactionTime': instance.player1ReactionTime,
      'player2ReactionTime': instance.player2ReactionTime,
    };
