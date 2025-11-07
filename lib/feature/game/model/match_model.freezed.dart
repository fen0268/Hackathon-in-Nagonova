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

 String get matchId; String get player1; String get player2; String get status;@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime get startedAt;@JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable) DateTime? get finishedAt; int get currentRound; RoundModel? get round1; RoundModel? get round2; String? get finalWinner;@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime get createdAt;
/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchModelCopyWith<MatchModel> get copyWith => _$MatchModelCopyWithImpl<MatchModel>(this as MatchModel, _$identity);

  /// Serializes this MatchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchModel&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.player1, player1) || other.player1 == player1)&&(identical(other.player2, player2) || other.player2 == player2)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.round1, round1) || other.round1 == round1)&&(identical(other.round2, round2) || other.round2 == round2)&&(identical(other.finalWinner, finalWinner) || other.finalWinner == finalWinner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,player1,player2,status,startedAt,finishedAt,currentRound,round1,round2,finalWinner,createdAt);

@override
String toString() {
  return 'MatchModel(matchId: $matchId, player1: $player1, player2: $player2, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, currentRound: $currentRound, round1: $round1, round2: $round2, finalWinner: $finalWinner, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $MatchModelCopyWith<$Res>  {
  factory $MatchModelCopyWith(MatchModel value, $Res Function(MatchModel) _then) = _$MatchModelCopyWithImpl;
@useResult
$Res call({
 String matchId, String player1, String player2, String status,@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime startedAt,@JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable) DateTime? finishedAt, int currentRound, RoundModel? round1, RoundModel? round2, String? finalWinner,@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime createdAt
});


$RoundModelCopyWith<$Res>? get round1;$RoundModelCopyWith<$Res>? get round2;

}
/// @nodoc
class _$MatchModelCopyWithImpl<$Res>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._self, this._then);

  final MatchModel _self;
  final $Res Function(MatchModel) _then;

/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchId = null,Object? player1 = null,Object? player2 = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? currentRound = null,Object? round1 = freezed,Object? round2 = freezed,Object? finalWinner = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,player1: null == player1 ? _self.player1 : player1 // ignore: cast_nullable_to_non_nullable
as String,player2: null == player2 ? _self.player2 : player2 // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentRound: null == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as int,round1: freezed == round1 ? _self.round1 : round1 // ignore: cast_nullable_to_non_nullable
as RoundModel?,round2: freezed == round2 ? _self.round2 : round2 // ignore: cast_nullable_to_non_nullable
as RoundModel?,finalWinner: freezed == finalWinner ? _self.finalWinner : finalWinner // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoundModelCopyWith<$Res>? get round1 {
    if (_self.round1 == null) {
    return null;
  }

  return $RoundModelCopyWith<$Res>(_self.round1!, (value) {
    return _then(_self.copyWith(round1: value));
  });
}/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoundModelCopyWith<$Res>? get round2 {
    if (_self.round2 == null) {
    return null;
  }

  return $RoundModelCopyWith<$Res>(_self.round2!, (value) {
    return _then(_self.copyWith(round2: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String matchId,  String player1,  String player2,  String status, @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)  DateTime startedAt, @JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable)  DateTime? finishedAt,  int currentRound,  RoundModel? round1,  RoundModel? round2,  String? finalWinner, @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchModel() when $default != null:
return $default(_that.matchId,_that.player1,_that.player2,_that.status,_that.startedAt,_that.finishedAt,_that.currentRound,_that.round1,_that.round2,_that.finalWinner,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String matchId,  String player1,  String player2,  String status, @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)  DateTime startedAt, @JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable)  DateTime? finishedAt,  int currentRound,  RoundModel? round1,  RoundModel? round2,  String? finalWinner, @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _MatchModel():
return $default(_that.matchId,_that.player1,_that.player2,_that.status,_that.startedAt,_that.finishedAt,_that.currentRound,_that.round1,_that.round2,_that.finalWinner,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String matchId,  String player1,  String player2,  String status, @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)  DateTime startedAt, @JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable)  DateTime? finishedAt,  int currentRound,  RoundModel? round1,  RoundModel? round2,  String? finalWinner, @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _MatchModel() when $default != null:
return $default(_that.matchId,_that.player1,_that.player2,_that.status,_that.startedAt,_that.finishedAt,_that.currentRound,_that.round1,_that.round2,_that.finalWinner,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchModel implements MatchModel {
  const _MatchModel({required this.matchId, required this.player1, required this.player2, this.status = 'waiting', @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required this.startedAt, @JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable) this.finishedAt, this.currentRound = 1, this.round1, this.round2, this.finalWinner, @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required this.createdAt});
  factory _MatchModel.fromJson(Map<String, dynamic> json) => _$MatchModelFromJson(json);

@override final  String matchId;
@override final  String player1;
@override final  String player2;
@override@JsonKey() final  String status;
@override@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) final  DateTime startedAt;
@override@JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable) final  DateTime? finishedAt;
@override@JsonKey() final  int currentRound;
@override final  RoundModel? round1;
@override final  RoundModel? round2;
@override final  String? finalWinner;
@override@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) final  DateTime createdAt;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchModel&&(identical(other.matchId, matchId) || other.matchId == matchId)&&(identical(other.player1, player1) || other.player1 == player1)&&(identical(other.player2, player2) || other.player2 == player2)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.round1, round1) || other.round1 == round1)&&(identical(other.round2, round2) || other.round2 == round2)&&(identical(other.finalWinner, finalWinner) || other.finalWinner == finalWinner)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchId,player1,player2,status,startedAt,finishedAt,currentRound,round1,round2,finalWinner,createdAt);

@override
String toString() {
  return 'MatchModel(matchId: $matchId, player1: $player1, player2: $player2, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, currentRound: $currentRound, round1: $round1, round2: $round2, finalWinner: $finalWinner, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$MatchModelCopyWith<$Res> implements $MatchModelCopyWith<$Res> {
  factory _$MatchModelCopyWith(_MatchModel value, $Res Function(_MatchModel) _then) = __$MatchModelCopyWithImpl;
@override @useResult
$Res call({
 String matchId, String player1, String player2, String status,@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime startedAt,@JsonKey(fromJson: _timestampFromJsonNullable, toJson: _timestampToJsonNullable) DateTime? finishedAt, int currentRound, RoundModel? round1, RoundModel? round2, String? finalWinner,@JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime createdAt
});


@override $RoundModelCopyWith<$Res>? get round1;@override $RoundModelCopyWith<$Res>? get round2;

}
/// @nodoc
class __$MatchModelCopyWithImpl<$Res>
    implements _$MatchModelCopyWith<$Res> {
  __$MatchModelCopyWithImpl(this._self, this._then);

  final _MatchModel _self;
  final $Res Function(_MatchModel) _then;

/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchId = null,Object? player1 = null,Object? player2 = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? currentRound = null,Object? round1 = freezed,Object? round2 = freezed,Object? finalWinner = freezed,Object? createdAt = null,}) {
  return _then(_MatchModel(
matchId: null == matchId ? _self.matchId : matchId // ignore: cast_nullable_to_non_nullable
as String,player1: null == player1 ? _self.player1 : player1 // ignore: cast_nullable_to_non_nullable
as String,player2: null == player2 ? _self.player2 : player2 // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,currentRound: null == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as int,round1: freezed == round1 ? _self.round1 : round1 // ignore: cast_nullable_to_non_nullable
as RoundModel?,round2: freezed == round2 ? _self.round2 : round2 // ignore: cast_nullable_to_non_nullable
as RoundModel?,finalWinner: freezed == finalWinner ? _self.finalWinner : finalWinner // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoundModelCopyWith<$Res>? get round1 {
    if (_self.round1 == null) {
    return null;
  }

  return $RoundModelCopyWith<$Res>(_self.round1!, (value) {
    return _then(_self.copyWith(round1: value));
  });
}/// Create a copy of MatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoundModelCopyWith<$Res>? get round2 {
    if (_self.round2 == null) {
    return null;
  }

  return $RoundModelCopyWith<$Res>(_self.round2!, (value) {
    return _then(_self.copyWith(round2: value));
  });
}
}

// dart format on
