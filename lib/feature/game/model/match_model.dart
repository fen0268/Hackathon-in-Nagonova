import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hackathon_app/feature/game/model/round_model.dart';
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
    @Default(1) int currentRound,
    RoundModel? round1,
    RoundModel? round2,
    String? finalWinner,
    @DateTimeConverter() required DateTime createdAt,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}
