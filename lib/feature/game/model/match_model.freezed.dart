// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchModel {

 String get matchId; String get player1; String get player2; String get status;@DateTimeConverter() DateTime get startedAt;@NullableDateTimeConverter() DateTime? get finishedAt;// 画像
 String? get player1ImageUrl; String? get player2ImageUrl;// タイミング
@NullableDateTimeConverter() DateTime? get shootingAt;@NullableDateTimeConverter() DateTime? get player1UploadedAt;@NullableDateTimeConverter() DateTime? get player2UploadedAt;@NullableDateTimeConverter() DateTime? get imagesDisplayedAt;// 笑顔判定
@NullableDateTimeConverter() DateTime? get player1SmileDetectedAt;@NullableDateTimeConverter() DateTime? get player2SmileDetectedAt;// 結果
 String? get winner;@NullableDateTimeConverter() DateTime? get gameEndedAt;// 統計
 double? get player1UploadTime; double? get player2UploadTime; double? get player1ReactionTime; double? get player2ReactionTime;@DateTimeConverter() DateTime get createdAt;
/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchModelCopyWith<MatchModel> get copyWith => _$MatchModelCopyWithImpl<MatchModel>(this as MatchModel, _$identity);

  /// Serializes this MatchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchModel&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.player1, player1) || other.player1 == player1)&&(identical(other.player2, player2) || other.player2 == player2)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.player1ImageUrl, player1ImageUrl) || other.player1ImageUrl == player1ImageUrl)&&(identical(other.player2ImageUrl, player2ImageUrl) || other.player2ImageUrl == player2ImageUrl)&&(identical(other.shootingAt, shootingAt) || other.shootingAt == shootingAt)&&(identical(other.player1UploadedAt, player1UploadedAt) || other.player1UploadedAt == player1UploadedAt)&&(identical(other.player2UploadedAt, player2UploadedAt) || other.player2UploadedAt == player2UploadedAt)&&(identical(other.imagesDisplayedAt, imagesDisplayedAt) || other.imagesDisplayedAt == imagesDisplayedAt)&&(identical(other.player1SmileDetectedAt, player1SmileDetectedAt) || other.player1SmileDetectedAt == player1SmileDetectedAt)&&(identical(other.player2SmileDetectedAt, player2SmileDetectedAt) || other.player2SmileDetectedAt == player2SmileDetectedAt)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.gameEndedAt, gameEndedAt) || other.gameEndedAt == gameEndedAt)&&(identical(other.player1UploadTime, player1UploadTime) || other.player1UploadTime == player1UploadTime)&&(identical(other.player2UploadTime, player2UploadTime) || other.player2UploadTime == player2UploadTime)&&(identical(other.player1ReactionTime, player1ReactionTime) || other.player1ReactionTime == player1ReactionTime)&&(identical(other.player2ReactionTime, player2ReactionTime) || other.player2ReactionTime == player2ReactionTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,matchId,player1,player2,status,startedAt,finishedAt,player1ImageUrl,player2ImageUrl,shootingAt,player1UploadedAt,player2UploadedAt,imagesDisplayedAt,player1SmileDetectedAt,player2SmileDetectedAt,winner,gameEndedAt,player1UploadTime,player2UploadTime,player1ReactionTime,player2ReactionTime,createdAt]);

@override
String toString() {
  return 'MatchModel(matchId: $matchId, player1: $player1, player2: $player2, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, player1ImageUrl: $player1ImageUrl, player2ImageUrl: $player2ImageUrl, shootingAt: $shootingAt, player1UploadedAt: $player1UploadedAt, player2UploadedAt: $player2UploadedAt, imagesDisplayedAt: $imagesDisplayedAt, player1SmileDetectedAt: $player1SmileDetectedAt, player2SmileDetectedAt: $player2SmileDetectedAt, winner: $winner, gameEndedAt: $gameEndedAt, player1UploadTime: $player1UploadTime, player2UploadTime: $player2UploadTime, player1ReactionTime: $player1ReactionTime, player2ReactionTime: $player2ReactionTime, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MatchModelCopyWith<$Res>  {
  factory $MatchModelCopyWith(MatchModel value, $Res Function(MatchModel) _then) = _$MatchModelCopyWithImpl;
@useResult
$Res call({
 String matchId, String player1, String player2, String status,@DateTimeConverter() DateTime startedAt,@NullableDateTimeConverter() DateTime? finishedAt, String? player1ImageUrl, String? player2ImageUrl,@NullableDateTimeConverter() DateTime? shootingAt,@NullableDateTimeConverter() DateTime? player1UploadedAt,@NullableDateTimeConverter() DateTime? player2UploadedAt,@NullableDateTimeConverter() DateTime? imagesDisplayedAt,@NullableDateTimeConverter() DateTime? player1SmileDetectedAt,@NullableDateTimeConverter() DateTime? player2SmileDetectedAt, String? winner,@NullableDateTimeConverter() DateTime? gameEndedAt, double? player1UploadTime, double? player2UploadTime, double? player1ReactionTime, double? player2ReactionTime,@DateTimeConverter() DateTime createdAt
});




}
/// @nodoc
class _$MatchModelCopyWithImpl<$Res>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._self, this._then);

  final MatchModel _self;
  final $Res Function(MatchModel) _then;

/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? player1 = null,Object? player2 = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? player1ImageUrl = freezed,Object? player2ImageUrl = freezed,Object? shootingAt = freezed,Object? player1UploadedAt = freezed,Object? player2UploadedAt = freezed,Object? imagesDisplayedAt = freezed,Object? player1SmileDetectedAt = freezed,Object? player2SmileDetectedAt = freezed,Object? winner = freezed,Object? gameEndedAt = freezed,Object? player1UploadTime = freezed,Object? player2UploadTime = freezed,Object? player1ReactionTime = freezed,Object? player2ReactionTime = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,player1: null == player1 ? _self.player1 : player1 // ignore: cast_nullable_to_non_nullable
as String,player2: null == player2 ? _self.player2 : player2 // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1ImageUrl: freezed == player1ImageUrl ? _self.player1ImageUrl : player1ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,player2ImageUrl: freezed == player2ImageUrl ? _self.player2ImageUrl : player2ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,shootingAt: freezed == shootingAt ? _self.shootingAt : shootingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadedAt: freezed == player1UploadedAt ? _self.player1UploadedAt : player1UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2UploadedAt: freezed == player2UploadedAt ? _self.player2UploadedAt : player2UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,imagesDisplayedAt: freezed == imagesDisplayedAt ? _self.imagesDisplayedAt : imagesDisplayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1SmileDetectedAt: freezed == player1SmileDetectedAt ? _self.player1SmileDetectedAt : player1SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2SmileDetectedAt: freezed == player2SmileDetectedAt ? _self.player2SmileDetectedAt : player2SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String?,gameEndedAt: freezed == gameEndedAt ? _self.gameEndedAt : gameEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadTime: freezed == player1UploadTime ? _self.player1UploadTime : player1UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player2UploadTime: freezed == player2UploadTime ? _self.player2UploadTime : player2UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player1ReactionTime: freezed == player1ReactionTime ? _self.player1ReactionTime : player1ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,player2ReactionTime: freezed == player2ReactionTime ? _self.player2ReactionTime : player2ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchModel].
extension MatchModelPatterns on MatchModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchModel value)  $default,){
final _that = this;
switch (_that) {
case _MatchModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchModel value)?  $default,){
final _that = this;
switch (_that) {
case _MatchModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  String player1,  String player2,  String status, @DateTimeConverter()  DateTime startedAt, @NullableDateTimeConverter()  DateTime? finishedAt,  String? player1ImageUrl,  String? player2ImageUrl, @NullableDateTimeConverter()  DateTime? shootingAt, @NullableDateTimeConverter()  DateTime? player1UploadedAt, @NullableDateTimeConverter()  DateTime? player2UploadedAt, @NullableDateTimeConverter()  DateTime? imagesDisplayedAt, @NullableDateTimeConverter()  DateTime? player1SmileDetectedAt, @NullableDateTimeConverter()  DateTime? player2SmileDetectedAt,  String? winner, @NullableDateTimeConverter()  DateTime? gameEndedAt,  double? player1UploadTime,  double? player2UploadTime,  double? player1ReactionTime,  double? player2ReactionTime, @DateTimeConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchModel() when $default != null:
return $default(_that.matchId,_that.player1,_that.player2,_that.status,_that.startedAt,_that.finishedAt,_that.player1ImageUrl,_that.player2ImageUrl,_that.shootingAt,_that.player1UploadedAt,_that.player2UploadedAt,_that.imagesDisplayedAt,_that.player1SmileDetectedAt,_that.player2SmileDetectedAt,_that.winner,_that.gameEndedAt,_that.player1UploadTime,_that.player2UploadTime,_that.player1ReactionTime,_that.player2ReactionTime,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  String player1,  String player2,  String status, @DateTimeConverter()  DateTime startedAt, @NullableDateTimeConverter()  DateTime? finishedAt,  String? player1ImageUrl,  String? player2ImageUrl, @NullableDateTimeConverter()  DateTime? shootingAt, @NullableDateTimeConverter()  DateTime? player1UploadedAt, @NullableDateTimeConverter()  DateTime? player2UploadedAt, @NullableDateTimeConverter()  DateTime? imagesDisplayedAt, @NullableDateTimeConverter()  DateTime? player1SmileDetectedAt, @NullableDateTimeConverter()  DateTime? player2SmileDetectedAt,  String? winner, @NullableDateTimeConverter()  DateTime? gameEndedAt,  double? player1UploadTime,  double? player2UploadTime,  double? player1ReactionTime,  double? player2ReactionTime, @DateTimeConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MatchModel():
return $default(_that.matchId,_that.player1,_that.player2,_that.status,_that.startedAt,_that.finishedAt,_that.player1ImageUrl,_that.player2ImageUrl,_that.shootingAt,_that.player1UploadedAt,_that.player2UploadedAt,_that.imagesDisplayedAt,_that.player1SmileDetectedAt,_that.player2SmileDetectedAt,_that.winner,_that.gameEndedAt,_that.player1UploadTime,_that.player2UploadTime,_that.player1ReactionTime,_that.player2ReactionTime,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  String player1,  String player2,  String status, @DateTimeConverter()  DateTime startedAt, @NullableDateTimeConverter()  DateTime? finishedAt,  String? player1ImageUrl,  String? player2ImageUrl, @NullableDateTimeConverter()  DateTime? shootingAt, @NullableDateTimeConverter()  DateTime? player1UploadedAt, @NullableDateTimeConverter()  DateTime? player2UploadedAt, @NullableDateTimeConverter()  DateTime? imagesDisplayedAt, @NullableDateTimeConverter()  DateTime? player1SmileDetectedAt, @NullableDateTimeConverter()  DateTime? player2SmileDetectedAt,  String? winner, @NullableDateTimeConverter()  DateTime? gameEndedAt,  double? player1UploadTime,  double? player2UploadTime,  double? player1ReactionTime,  double? player2ReactionTime, @DateTimeConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MatchModel() when $default != null:
return $default(_that.matchId,_that.player1,_that.player2,_that.status,_that.startedAt,_that.finishedAt,_that.player1ImageUrl,_that.player2ImageUrl,_that.shootingAt,_that.player1UploadedAt,_that.player2UploadedAt,_that.imagesDisplayedAt,_that.player1SmileDetectedAt,_that.player2SmileDetectedAt,_that.winner,_that.gameEndedAt,_that.player1UploadTime,_that.player2UploadTime,_that.player1ReactionTime,_that.player2ReactionTime,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchModel implements MatchModel {
  const _MatchModel({required this.matchId, required this.player1, required this.player2, this.status = 'waiting', @DateTimeConverter() required this.startedAt, @NullableDateTimeConverter() this.finishedAt, this.player1ImageUrl, this.player2ImageUrl, @NullableDateTimeConverter() this.shootingAt, @NullableDateTimeConverter() this.player1UploadedAt, @NullableDateTimeConverter() this.player2UploadedAt, @NullableDateTimeConverter() this.imagesDisplayedAt, @NullableDateTimeConverter() this.player1SmileDetectedAt, @NullableDateTimeConverter() this.player2SmileDetectedAt, this.winner, @NullableDateTimeConverter() this.gameEndedAt, this.player1UploadTime, this.player2UploadTime, this.player1ReactionTime, this.player2ReactionTime, @DateTimeConverter() required this.createdAt});
  factory _MatchModel.fromJson(Map<String, dynamic> json) => _$MatchModelFromJson(json);

@override final  String matchId;
@override final  String player1;
@override final  String player2;
@override@JsonKey() final  String status;
@override@DateTimeConverter() final  DateTime startedAt;
@override@NullableDateTimeConverter() final  DateTime? finishedAt;
// 画像
@override final  String? player1ImageUrl;
@override final  String? player2ImageUrl;
// タイミング
@override@NullableDateTimeConverter() final  DateTime? shootingAt;
@override@NullableDateTimeConverter() final  DateTime? player1UploadedAt;
@override@NullableDateTimeConverter() final  DateTime? player2UploadedAt;
@override@NullableDateTimeConverter() final  DateTime? imagesDisplayedAt;
// 笑顔判定
@override@NullableDateTimeConverter() final  DateTime? player1SmileDetectedAt;
@override@NullableDateTimeConverter() final  DateTime? player2SmileDetectedAt;
// 結果
@override final  String? winner;
@override@NullableDateTimeConverter() final  DateTime? gameEndedAt;
// 統計
@override final  double? player1UploadTime;
@override final  double? player2UploadTime;
@override final  double? player1ReactionTime;
@override final  double? player2ReactionTime;
@override@DateTimeConverter() final  DateTime createdAt;

/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchModelCopyWith<_MatchModel> get copyWith => __$MatchModelCopyWithImpl<_MatchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchModel&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.player1, player1) || other.player1 == player1)&&(identical(other.player2, player2) || other.player2 == player2)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.player1ImageUrl, player1ImageUrl) || other.player1ImageUrl == player1ImageUrl)&&(identical(other.player2ImageUrl, player2ImageUrl) || other.player2ImageUrl == player2ImageUrl)&&(identical(other.shootingAt, shootingAt) || other.shootingAt == shootingAt)&&(identical(other.player1UploadedAt, player1UploadedAt) || other.player1UploadedAt == player1UploadedAt)&&(identical(other.player2UploadedAt, player2UploadedAt) || other.player2UploadedAt == player2UploadedAt)&&(identical(other.imagesDisplayedAt, imagesDisplayedAt) || other.imagesDisplayedAt == imagesDisplayedAt)&&(identical(other.player1SmileDetectedAt, player1SmileDetectedAt) || other.player1SmileDetectedAt == player1SmileDetectedAt)&&(identical(other.player2SmileDetectedAt, player2SmileDetectedAt) || other.player2SmileDetectedAt == player2SmileDetectedAt)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.gameEndedAt, gameEndedAt) || other.gameEndedAt == gameEndedAt)&&(identical(other.player1UploadTime, player1UploadTime) || other.player1UploadTime == player1UploadTime)&&(identical(other.player2UploadTime, player2UploadTime) || other.player2UploadTime == player2UploadTime)&&(identical(other.player1ReactionTime, player1ReactionTime) || other.player1ReactionTime == player1ReactionTime)&&(identical(other.player2ReactionTime, player2ReactionTime) || other.player2ReactionTime == player2ReactionTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,matchId,player1,player2,status,startedAt,finishedAt,player1ImageUrl,player2ImageUrl,shootingAt,player1UploadedAt,player2UploadedAt,imagesDisplayedAt,player1SmileDetectedAt,player2SmileDetectedAt,winner,gameEndedAt,player1UploadTime,player2UploadTime,player1ReactionTime,player2ReactionTime,createdAt]);

@override
String toString() {
  return 'MatchModel(matchId: $matchId, player1: $player1, player2: $player2, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, player1ImageUrl: $player1ImageUrl, player2ImageUrl: $player2ImageUrl, shootingAt: $shootingAt, player1UploadedAt: $player1UploadedAt, player2UploadedAt: $player2UploadedAt, imagesDisplayedAt: $imagesDisplayedAt, player1SmileDetectedAt: $player1SmileDetectedAt, player2SmileDetectedAt: $player2SmileDetectedAt, winner: $winner, gameEndedAt: $gameEndedAt, player1UploadTime: $player1UploadTime, player2UploadTime: $player2UploadTime, player1ReactionTime: $player1ReactionTime, player2ReactionTime: $player2ReactionTime, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MatchModelCopyWith<$Res> implements $MatchModelCopyWith<$Res> {
  factory _$MatchModelCopyWith(_MatchModel value, $Res Function(_MatchModel) _then) = __$MatchModelCopyWithImpl;
@override @useResult
$Res call({
 String matchId, String player1, String player2, String status,@DateTimeConverter() DateTime startedAt,@NullableDateTimeConverter() DateTime? finishedAt, String? player1ImageUrl, String? player2ImageUrl,@NullableDateTimeConverter() DateTime? shootingAt,@NullableDateTimeConverter() DateTime? player1UploadedAt,@NullableDateTimeConverter() DateTime? player2UploadedAt,@NullableDateTimeConverter() DateTime? imagesDisplayedAt,@NullableDateTimeConverter() DateTime? player1SmileDetectedAt,@NullableDateTimeConverter() DateTime? player2SmileDetectedAt, String? winner,@NullableDateTimeConverter() DateTime? gameEndedAt, double? player1UploadTime, double? player2UploadTime, double? player1ReactionTime, double? player2ReactionTime,@DateTimeConverter() DateTime createdAt
});




}
/// @nodoc
class __$MatchModelCopyWithImpl<$Res>
    implements _$MatchModelCopyWith<$Res> {
  __$MatchModelCopyWithImpl(this._self, this._then);

  final _MatchModel _self;
  final $Res Function(_MatchModel) _then;

/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? player1 = null,Object? player2 = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? player1ImageUrl = freezed,Object? player2ImageUrl = freezed,Object? shootingAt = freezed,Object? player1UploadedAt = freezed,Object? player2UploadedAt = freezed,Object? imagesDisplayedAt = freezed,Object? player1SmileDetectedAt = freezed,Object? player2SmileDetectedAt = freezed,Object? winner = freezed,Object? gameEndedAt = freezed,Object? player1UploadTime = freezed,Object? player2UploadTime = freezed,Object? player1ReactionTime = freezed,Object? player2ReactionTime = freezed,Object? createdAt = null,}) {
  return _then(_MatchModel(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,player1: null == player1 ? _self.player1 : player1 // ignore: cast_nullable_to_non_nullable
as String,player2: null == player2 ? _self.player2 : player2 // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1ImageUrl: freezed == player1ImageUrl ? _self.player1ImageUrl : player1ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,player2ImageUrl: freezed == player2ImageUrl ? _self.player2ImageUrl : player2ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,shootingAt: freezed == shootingAt ? _self.shootingAt : shootingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadedAt: freezed == player1UploadedAt ? _self.player1UploadedAt : player1UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2UploadedAt: freezed == player2UploadedAt ? _self.player2UploadedAt : player2UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,imagesDisplayedAt: freezed == imagesDisplayedAt ? _self.imagesDisplayedAt : imagesDisplayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1SmileDetectedAt: freezed == player1SmileDetectedAt ? _self.player1SmileDetectedAt : player1SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2SmileDetectedAt: freezed == player2SmileDetectedAt ? _self.player2SmileDetectedAt : player2SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String?,gameEndedAt: freezed == gameEndedAt ? _self.gameEndedAt : gameEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadTime: freezed == player1UploadTime ? _self.player1UploadTime : player1UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player2UploadTime: freezed == player2UploadTime ? _self.player2UploadTime : player2UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player1ReactionTime: freezed == player1ReactionTime ? _self.player1ReactionTime : player1ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,player2ReactionTime: freezed == player2ReactionTime ? _self.player2ReactionTime : player2ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
