import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hackathon_app/util/datetime_converter.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String nickname,
    @DateTimeConverter() required DateTime createdAt,
    @Default(0) int totalMatches,
    @Default(0) int wins,
    @Default(0.0) double winRate,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
