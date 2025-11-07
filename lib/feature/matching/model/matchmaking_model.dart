import 'package:freezed_annotation/freezed_annotation.dart';

part 'matchmaking_model.freezed.dart';
part 'matchmaking_model.g.dart';

@freezed
abstract class MatchmakingModel with _$MatchmakingModel {
  const factory MatchmakingModel({
    required String userId,
    @Default('waiting') String status,
    required DateTime createdAt,
    String? matchedWith,
    String? matchId,
  }) = _MatchmakingModel;

  factory MatchmakingModel.fromJson(Map<String, dynamic> json) =>
      _$MatchmakingModelFromJson(json);
}
