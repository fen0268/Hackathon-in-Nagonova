// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matchmaking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchmakingModel {

 String get userId; String get status;@DateTimeConverter() DateTime get createdAt; String? get matchedWith; String? get matchId;
/// Create a copy of MatchmakingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchmakingModelCopyWith<MatchmakingModel> get copyWith => _$MatchmakingModelCopyWithImpl<MatchmakingModel>(this as MatchmakingModel, _$identity);

  /// Serializes this MatchmakingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchmakingModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.matchedWith, matchedWith) || other.matchedWith == matchedWith)&&(identical(other.matchId, matchId) || other.matchId == matchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,status,createdAt,matchedWith,matchId);

@override
String toString() {
  return 'MatchmakingModel(userId: $userId, status: $status, createdAt: $createdAt, matchedWith: $matchedWith, matchId: $matchId)';
}


}

/// @nodoc
abstract mixin class $MatchmakingModelCopyWith<$Res>  {
  factory $MatchmakingModelCopyWith(MatchmakingModel value, $Res Function(MatchmakingModel) _then) = _$MatchmakingModelCopyWithImpl;
@useResult
$Res call({
 String userId, String status,@DateTimeConverter() DateTime createdAt, String? matchedWith, String? matchId
});




}
/// @nodoc
class _$MatchmakingModelCopyWithImpl<$Res>
    implements $MatchmakingModelCopyWith<$Res> {
  _$MatchmakingModelCopyWithImpl(this._self, this._then);

  final MatchmakingModel _self;
  final $Res Function(MatchmakingModel) _then;

/// Create a copy of MatchmakingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? status = null,Object? createdAt = null,Object? matchedWith = freezed,Object? matchId = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,matchedWith: freezed == matchedWith ? _self.matchedWith : matchedWith // ignore: cast_nullable_to_non_nullable
as String?,matchId: freezed == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchmakingModel].
extension MatchmakingModelPatterns on MatchmakingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchmakingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchmakingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchmakingModel value)  $default,){
final _that = this;
switch (_that) {
case _MatchmakingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchmakingModel value)?  $default,){
final _that = this;
switch (_that) {
case _MatchmakingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String status, @DateTimeConverter()  DateTime createdAt,  String? matchedWith,  String? matchId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchmakingModel() when $default != null:
return $default(_that.userId,_that.status,_that.createdAt,_that.matchedWith,_that.matchId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String status, @DateTimeConverter()  DateTime createdAt,  String? matchedWith,  String? matchId)  $default,) {final _that = this;
switch (_that) {
case _MatchmakingModel():
return $default(_that.userId,_that.status,_that.createdAt,_that.matchedWith,_that.matchId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String status, @DateTimeConverter()  DateTime createdAt,  String? matchedWith,  String? matchId)?  $default,) {final _that = this;
switch (_that) {
case _MatchmakingModel() when $default != null:
return $default(_that.userId,_that.status,_that.createdAt,_that.matchedWith,_that.matchId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchmakingModel implements MatchmakingModel {
  const _MatchmakingModel({required this.userId, this.status = 'waiting', @DateTimeConverter() required this.createdAt, this.matchedWith, this.matchId});
  factory _MatchmakingModel.fromJson(Map<String, dynamic> json) => _$MatchmakingModelFromJson(json);

@override final  String userId;
@override@JsonKey() final  String status;
@override@DateTimeConverter() final  DateTime createdAt;
@override final  String? matchedWith;
@override final  String? matchId;

/// Create a copy of MatchmakingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchmakingModelCopyWith<_MatchmakingModel> get copyWith => __$MatchmakingModelCopyWithImpl<_MatchmakingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchmakingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchmakingModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.matchedWith, matchedWith) || other.matchedWith == matchedWith)&&(identical(other.matchId, matchId) || other.matchId == matchId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,status,createdAt,matchedWith,matchId);

@override
String toString() {
  return 'MatchmakingModel(userId: $userId, status: $status, createdAt: $createdAt, matchedWith: $matchedWith, matchId: $matchId)';
}


}

/// @nodoc
abstract mixin class _$MatchmakingModelCopyWith<$Res> implements $MatchmakingModelCopyWith<$Res> {
  factory _$MatchmakingModelCopyWith(_MatchmakingModel value, $Res Function(_MatchmakingModel) _then) = __$MatchmakingModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String status,@DateTimeConverter() DateTime createdAt, String? matchedWith, String? matchId
});




}
/// @nodoc
class __$MatchmakingModelCopyWithImpl<$Res>
    implements _$MatchmakingModelCopyWith<$Res> {
  __$MatchmakingModelCopyWithImpl(this._self, this._then);

  final _MatchmakingModel _self;
  final $Res Function(_MatchmakingModel) _then;

/// Create a copy of MatchmakingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? status = null,Object? createdAt = null,Object? matchedWith = freezed,Object? matchId = freezed,}) {
  return _then(_MatchmakingModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,matchedWith: freezed == matchedWith ? _self.matchedWith : matchedWith // ignore: cast_nullable_to_non_nullable
as String?,matchId: freezed == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
