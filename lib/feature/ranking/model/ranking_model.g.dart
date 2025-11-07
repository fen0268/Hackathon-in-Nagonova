// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankingModel _$RankingModelFromJson(Map<String, dynamic> json) =>
    _RankingModel(
      userId: json['userId'] as String,
      nickname: json['nickname'] as String,
      totalMatches: (json['totalMatches'] as num?)?.toInt() ?? 0,
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      winRate: (json['winRate'] as num?)?.toDouble() ?? 0.0,
      updatedAt: const DateTimeConverter().fromJson(
        json['updatedAt'] as Object,
      ),
    );

Map<String, dynamic> _$RankingModelToJson(_RankingModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'nickname': instance.nickname,
      'totalMatches': instance.totalMatches,
      'wins': instance.wins,
      'winRate': instance.winRate,
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
    };
