import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

/// DateTime と Firestore Timestamp の相互変換コンバーター
///
/// Firestoreでは日時を Timestamp 型で保存するため、
/// DateTime と Timestamp の変換を自動化する
class DateTimeConverter implements JsonConverter<DateTime, Object> {
  const DateTimeConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) {
      // Firestore Timestamp から DateTime に変換
      return json.toDate();
    } else if (json is int) {
      // Unix timestamp (milliseconds) から DateTime に変換
      return DateTime.fromMillisecondsSinceEpoch(json);
    } else if (json is String) {
      // ISO 8601 文字列から DateTime に変換
      return DateTime.parse(json);
    }
    throw ArgumentError('Cannot convert $json to DateTime');
  }

  @override
  Object toJson(DateTime dateTime) {
    // DateTime を Firestore Timestamp に変換
    return Timestamp.fromDate(dateTime);
  }
}

/// Nullable DateTime と Firestore Timestamp の相互変換コンバーター
class NullableDateTimeConverter implements JsonConverter<DateTime?, Object?> {
  const NullableDateTimeConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) {
      return null;
    }
    if (json is Timestamp) {
      return json.toDate();
    } else if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    } else if (json is String) {
      return DateTime.parse(json);
    }
    throw ArgumentError('Cannot convert $json to DateTime');
  }

  @override
  Object? toJson(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    return Timestamp.fromDate(dateTime);
  }
}
