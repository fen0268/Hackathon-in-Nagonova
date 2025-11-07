// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchModel _$MatchModelFromJson(Map<String, dynamic> json) => _MatchModel(
  matchId: json['matchId'] as String,
  player1: json['player1'] as String,
  player2: json['player2'] as String,
  status: json['status'] as String? ?? 'waiting',
  startedAt: const DateTimeConverter().fromJson(json['startedAt'] as Object),
  finishedAt: const NullableDateTimeConverter().fromJson(json['finishedAt']),
  player1ImageUrl: json['player1ImageUrl'] as String?,
  player2ImageUrl: json['player2ImageUrl'] as String?,
  shootingAt: const NullableDateTimeConverter().fromJson(json['shootingAt']),
  player1UploadedAt: const NullableDateTimeConverter().fromJson(
    json['player1UploadedAt'],
  ),
  player2UploadedAt: const NullableDateTimeConverter().fromJson(
    json['player2UploadedAt'],
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
  gameEndedAt: const NullableDateTimeConverter().fromJson(json['gameEndedAt']),
  player1UploadTime: (json['player1UploadTime'] as num?)?.toDouble(),
  player2UploadTime: (json['player2UploadTime'] as num?)?.toDouble(),
  player1ReactionTime: (json['player1ReactionTime'] as num?)?.toDouble(),
  player2ReactionTime: (json['player2ReactionTime'] as num?)?.toDouble(),
  createdAt: const DateTimeConverter().fromJson(json['createdAt'] as Object),
);

Map<String, dynamic> _$MatchModelToJson(
  _MatchModel instance,
) => <String, dynamic>{
  'matchId': instance.matchId,
  'player1': instance.player1,
  'player2': instance.player2,
  'status': instance.status,
  'startedAt': const DateTimeConverter().toJson(instance.startedAt),
  'finishedAt': const NullableDateTimeConverter().toJson(instance.finishedAt),
  'player1ImageUrl': instance.player1ImageUrl,
  'player2ImageUrl': instance.player2ImageUrl,
  'shootingAt': const NullableDateTimeConverter().toJson(instance.shootingAt),
  'player1UploadedAt': const NullableDateTimeConverter().toJson(
    instance.player1UploadedAt,
  ),
  'player2UploadedAt': const NullableDateTimeConverter().toJson(
    instance.player2UploadedAt,
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
  'gameEndedAt': const NullableDateTimeConverter().toJson(instance.gameEndedAt),
  'player1UploadTime': instance.player1UploadTime,
  'player2UploadTime': instance.player2UploadTime,
  'player1ReactionTime': instance.player1ReactionTime,
  'player2ReactionTime': instance.player2ReactionTime,
  'createdAt': const DateTimeConverter().toJson(instance.createdAt),
};
