import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hackathon_app/util/datetime_converter.dart';

part 'matchmaking_model.freezed.dart';
part 'matchmaking_model.g.dart';

@freezed
abstract class MatchmakingModel with _$MatchmakingModel {
  const factory MatchmakingModel({
    required String userId,
    @Default('waiting') String status,
    @DateTimeConverter() required DateTime createdAt,
    String? matchedWith,
    String? matchId,
  }) = _MatchmakingModel;

  factory MatchmakingModel.fromJson(Map<String, dynamic> json) =>
      _$MatchmakingModelFromJson(json);
}
