// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ranking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RankingModel {

 String get userId; String get nickname; int get totalMatches; int get wins; double get winRate;@DateTimeConverter() DateTime get updatedAt;
/// Create a copy of RankingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RankingModelCopyWith<RankingModel> get copyWith => _$RankingModelCopyWithImpl<RankingModel>(this as RankingModel, _$identity);

  /// Serializes this RankingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RankingModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,nickname,totalMatches,wins,winRate,updatedAt);

@override
String toString() {
  return 'RankingModel(userId: $userId, nickname: $nickname, totalMatches: $totalMatches, wins: $wins, winRate: $winRate, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RankingModelCopyWith<$Res>  {
  factory $RankingModelCopyWith(RankingModel value, $Res Function(RankingModel) _then) = _$RankingModelCopyWithImpl;
@useResult
$Res call({
 String userId, String nickname, int totalMatches, int wins, double winRate,@DateTimeConverter() DateTime updatedAt
});




}
/// @nodoc
class _$RankingModelCopyWithImpl<$Res>
    implements $RankingModelCopyWith<$Res> {
  _$RankingModelCopyWithImpl(this._self, this._then);

  final RankingModel _self;
  final $Res Function(RankingModel) _then;

/// Create a copy of RankingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? nickname = null,Object? totalMatches = null,Object? wins = null,Object? winRate = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RankingModel].
extension RankingModelPatterns on RankingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RankingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RankingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RankingModel value)  $default,){
final _that = this;
switch (_that) {
case _RankingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RankingModel value)?  $default,){
final _that = this;
switch (_that) {
case _RankingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String nickname,  int totalMatches,  int wins,  double winRate, @DateTimeConverter()  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RankingModel() when $default != null:
return $default(_that.userId,_that.nickname,_that.totalMatches,_that.wins,_that.winRate,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String nickname,  int totalMatches,  int wins,  double winRate, @DateTimeConverter()  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RankingModel():
return $default(_that.userId,_that.nickname,_that.totalMatches,_that.wins,_that.winRate,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String nickname,  int totalMatches,  int wins,  double winRate, @DateTimeConverter()  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RankingModel() when $default != null:
return $default(_that.userId,_that.nickname,_that.totalMatches,_that.wins,_that.winRate,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RankingModel implements RankingModel {
  const _RankingModel({required this.userId, required this.nickname, this.totalMatches = 0, this.wins = 0, this.winRate = 0.0, @DateTimeConverter() required this.updatedAt});
  factory _RankingModel.fromJson(Map<String, dynamic> json) => _$RankingModelFromJson(json);

@override final  String userId;
@override final  String nickname;
@override@JsonKey() final  int totalMatches;
@override@JsonKey() final  int wins;
@override@JsonKey() final  double winRate;
@override@DateTimeConverter() final  DateTime updatedAt;

/// Create a copy of RankingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RankingModelCopyWith<_RankingModel> get copyWith => __$RankingModelCopyWithImpl<_RankingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RankingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RankingModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.totalMatches, totalMatches) || other.totalMatches == totalMatches)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,nickname,totalMatches,wins,winRate,updatedAt);

@override
String toString() {
  return 'RankingModel(userId: $userId, nickname: $nickname, totalMatches: $totalMatches, wins: $wins, winRate: $winRate, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RankingModelCopyWith<$Res> implements $RankingModelCopyWith<$Res> {
  factory _$RankingModelCopyWith(_RankingModel value, $Res Function(_RankingModel) _then) = __$RankingModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String nickname, int totalMatches, int wins, double winRate,@DateTimeConverter() DateTime updatedAt
});




}
/// @nodoc
class __$RankingModelCopyWithImpl<$Res>
    implements _$RankingModelCopyWith<$Res> {
  __$RankingModelCopyWithImpl(this._self, this._then);

  final _RankingModel _self;
  final $Res Function(_RankingModel) _then;

/// Create a copy of RankingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? nickname = null,Object? totalMatches = null,Object? wins = null,Object? winRate = null,Object? updatedAt = null,}) {
  return _then(_RankingModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,totalMatches: null == totalMatches ? _self.totalMatches : totalMatches // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
