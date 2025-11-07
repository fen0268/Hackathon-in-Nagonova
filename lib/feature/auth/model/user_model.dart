import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String nickname,
    required DateTime createdAt,
    @Default(0) int totalMatches,
    @Default(0) int wins,
    @Default(0.0) double winRate,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

DateTime _timestampFromJson(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  }
  return DateTime.now();
}

dynamic _timestampToJson(DateTime dateTime) {
  return Timestamp.fromDate(dateTime);
}
