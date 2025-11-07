// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'round_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoundModel {

 String? get player1ImageUrl; String? get player2ImageUrl; bool get player1ImageReady; bool get player2ImageReady; DateTime? get shootingAt; DateTime? get player1UploadedAt; DateTime? get player2UploadedAt; DateTime? get bothReadyAt; DateTime? get displayCountdownStartedAt; DateTime? get imagesDisplayedAt; DateTime? get player1SmileDetectedAt; DateTime? get player2SmileDetectedAt; String? get winner; DateTime? get roundEndedAt; double? get player1UploadTime; double? get player2UploadTime; double? get player1ReactionTime; double? get player2ReactionTime;
/// Create a copy of RoundModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoundModelCopyWith<RoundModel> get copyWith => _$RoundModelCopyWithImpl<RoundModel>(this as RoundModel, _$identity);

  /// Serializes this RoundModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoundModel&&(identical(other.player1ImageUrl, player1ImageUrl) || other.player1ImageUrl == player1ImageUrl)&&(identical(other.player2ImageUrl, player2ImageUrl) || other.player2ImageUrl == player2ImageUrl)&&(identical(other.player1ImageReady, player1ImageReady) || other.player1ImageReady == player1ImageReady)&&(identical(other.player2ImageReady, player2ImageReady) || other.player2ImageReady == player2ImageReady)&&(identical(other.shootingAt, shootingAt) || other.shootingAt == shootingAt)&&(identical(other.player1UploadedAt, player1UploadedAt) || other.player1UploadedAt == player1UploadedAt)&&(identical(other.player2UploadedAt, player2UploadedAt) || other.player2UploadedAt == player2UploadedAt)&&(identical(other.bothReadyAt, bothReadyAt) || other.bothReadyAt == bothReadyAt)&&(identical(other.displayCountdownStartedAt, displayCountdownStartedAt) || other.displayCountdownStartedAt == displayCountdownStartedAt)&&(identical(other.imagesDisplayedAt, imagesDisplayedAt) || other.imagesDisplayedAt == imagesDisplayedAt)&&(identical(other.player1SmileDetectedAt, player1SmileDetectedAt) || other.player1SmileDetectedAt == player1SmileDetectedAt)&&(identical(other.player2SmileDetectedAt, player2SmileDetectedAt) || other.player2SmileDetectedAt == player2SmileDetectedAt)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.roundEndedAt, roundEndedAt) || other.roundEndedAt == roundEndedAt)&&(identical(other.player1UploadTime, player1UploadTime) || other.player1UploadTime == player1UploadTime)&&(identical(other.player2UploadTime, player2UploadTime) || other.player2UploadTime == player2UploadTime)&&(identical(other.player1ReactionTime, player1ReactionTime) || other.player1ReactionTime == player1ReactionTime)&&(identical(other.player2ReactionTime, player2ReactionTime) || other.player2ReactionTime == player2ReactionTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,player1ImageUrl,player2ImageUrl,player1ImageReady,player2ImageReady,shootingAt,player1UploadedAt,player2UploadedAt,bothReadyAt,displayCountdownStartedAt,imagesDisplayedAt,player1SmileDetectedAt,player2SmileDetectedAt,winner,roundEndedAt,player1UploadTime,player2UploadTime,player1ReactionTime,player2ReactionTime);

@override
String toString() {
  return 'RoundModel(player1ImageUrl: $player1ImageUrl, player2ImageUrl: $player2ImageUrl, player1ImageReady: $player1ImageReady, player2ImageReady: $player2ImageReady, shootingAt: $shootingAt, player1UploadedAt: $player1UploadedAt, player2UploadedAt: $player2UploadedAt, bothReadyAt: $bothReadyAt, displayCountdownStartedAt: $displayCountdownStartedAt, imagesDisplayedAt: $imagesDisplayedAt, player1SmileDetectedAt: $player1SmileDetectedAt, player2SmileDetectedAt: $player2SmileDetectedAt, winner: $winner, roundEndedAt: $roundEndedAt, player1UploadTime: $player1UploadTime, player2UploadTime: $player2UploadTime, player1ReactionTime: $player1ReactionTime, player2ReactionTime: $player2ReactionTime)';
}


}

/// @nodoc
abstract mixin class $RoundModelCopyWith<$Res>  {
  factory $RoundModelCopyWith(RoundModel value, $Res Function(RoundModel) _then) = _$RoundModelCopyWithImpl;
@useResult
$Res call({
 String? player1ImageUrl, String? player2ImageUrl, bool player1ImageReady, bool player2ImageReady, DateTime? shootingAt, DateTime? player1UploadedAt, DateTime? player2UploadedAt, DateTime? bothReadyAt, DateTime? displayCountdownStartedAt, DateTime? imagesDisplayedAt, DateTime? player1SmileDetectedAt, DateTime? player2SmileDetectedAt, String? winner, DateTime? roundEndedAt, double? player1UploadTime, double? player2UploadTime, double? player1ReactionTime, double? player2ReactionTime
});




}
/// @nodoc
class _$RoundModelCopyWithImpl<$Res>
    implements $RoundModelCopyWith<$Res> {
  _$RoundModelCopyWithImpl(this._self, this._then);

  final RoundModel _self;
  final $Res Function(RoundModel) _then;

/// Create a copy of RoundModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? player1ImageUrl = freezed,Object? player2ImageUrl = freezed,Object? player1ImageReady = null,Object? player2ImageReady = null,Object? shootingAt = freezed,Object? player1UploadedAt = freezed,Object? player2UploadedAt = freezed,Object? bothReadyAt = freezed,Object? displayCountdownStartedAt = freezed,Object? imagesDisplayedAt = freezed,Object? player1SmileDetectedAt = freezed,Object? player2SmileDetectedAt = freezed,Object? winner = freezed,Object? roundEndedAt = freezed,Object? player1UploadTime = freezed,Object? player2UploadTime = freezed,Object? player1ReactionTime = freezed,Object? player2ReactionTime = freezed,}) {
  return _then(_self.copyWith(
player1ImageUrl: freezed == player1ImageUrl ? _self.player1ImageUrl : player1ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,player2ImageUrl: freezed == player2ImageUrl ? _self.player2ImageUrl : player2ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,player1ImageReady: null == player1ImageReady ? _self.player1ImageReady : player1ImageReady // ignore: cast_nullable_to_non_nullable
as bool,player2ImageReady: null == player2ImageReady ? _self.player2ImageReady : player2ImageReady // ignore: cast_nullable_to_non_nullable
as bool,shootingAt: freezed == shootingAt ? _self.shootingAt : shootingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadedAt: freezed == player1UploadedAt ? _self.player1UploadedAt : player1UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2UploadedAt: freezed == player2UploadedAt ? _self.player2UploadedAt : player2UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bothReadyAt: freezed == bothReadyAt ? _self.bothReadyAt : bothReadyAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayCountdownStartedAt: freezed == displayCountdownStartedAt ? _self.displayCountdownStartedAt : displayCountdownStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,imagesDisplayedAt: freezed == imagesDisplayedAt ? _self.imagesDisplayedAt : imagesDisplayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1SmileDetectedAt: freezed == player1SmileDetectedAt ? _self.player1SmileDetectedAt : player1SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2SmileDetectedAt: freezed == player2SmileDetectedAt ? _self.player2SmileDetectedAt : player2SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String?,roundEndedAt: freezed == roundEndedAt ? _self.roundEndedAt : roundEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadTime: freezed == player1UploadTime ? _self.player1UploadTime : player1UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player2UploadTime: freezed == player2UploadTime ? _self.player2UploadTime : player2UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player1ReactionTime: freezed == player1ReactionTime ? _self.player1ReactionTime : player1ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,player2ReactionTime: freezed == player2ReactionTime ? _self.player2ReactionTime : player2ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoundModel].
extension RoundModelPatterns on RoundModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoundModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoundModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoundModel value)  $default,){
final _that = this;
switch (_that) {
case _RoundModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoundModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoundModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? player1ImageUrl,  String? player2ImageUrl,  bool player1ImageReady,  bool player2ImageReady,  DateTime? shootingAt,  DateTime? player1UploadedAt,  DateTime? player2UploadedAt,  DateTime? bothReadyAt,  DateTime? displayCountdownStartedAt,  DateTime? imagesDisplayedAt,  DateTime? player1SmileDetectedAt,  DateTime? player2SmileDetectedAt,  String? winner,  DateTime? roundEndedAt,  double? player1UploadTime,  double? player2UploadTime,  double? player1ReactionTime,  double? player2ReactionTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoundModel() when $default != null:
return $default(_that.player1ImageUrl,_that.player2ImageUrl,_that.player1ImageReady,_that.player2ImageReady,_that.shootingAt,_that.player1UploadedAt,_that.player2UploadedAt,_that.bothReadyAt,_that.displayCountdownStartedAt,_that.imagesDisplayedAt,_that.player1SmileDetectedAt,_that.player2SmileDetectedAt,_that.winner,_that.roundEndedAt,_that.player1UploadTime,_that.player2UploadTime,_that.player1ReactionTime,_that.player2ReactionTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? player1ImageUrl,  String? player2ImageUrl,  bool player1ImageReady,  bool player2ImageReady,  DateTime? shootingAt,  DateTime? player1UploadedAt,  DateTime? player2UploadedAt,  DateTime? bothReadyAt,  DateTime? displayCountdownStartedAt,  DateTime? imagesDisplayedAt,  DateTime? player1SmileDetectedAt,  DateTime? player2SmileDetectedAt,  String? winner,  DateTime? roundEndedAt,  double? player1UploadTime,  double? player2UploadTime,  double? player1ReactionTime,  double? player2ReactionTime)  $default,) {final _that = this;
switch (_that) {
case _RoundModel():
return $default(_that.player1ImageUrl,_that.player2ImageUrl,_that.player1ImageReady,_that.player2ImageReady,_that.shootingAt,_that.player1UploadedAt,_that.player2UploadedAt,_that.bothReadyAt,_that.displayCountdownStartedAt,_that.imagesDisplayedAt,_that.player1SmileDetectedAt,_that.player2SmileDetectedAt,_that.winner,_that.roundEndedAt,_that.player1UploadTime,_that.player2UploadTime,_that.player1ReactionTime,_that.player2ReactionTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? player1ImageUrl,  String? player2ImageUrl,  bool player1ImageReady,  bool player2ImageReady,  DateTime? shootingAt,  DateTime? player1UploadedAt,  DateTime? player2UploadedAt,  DateTime? bothReadyAt,  DateTime? displayCountdownStartedAt,  DateTime? imagesDisplayedAt,  DateTime? player1SmileDetectedAt,  DateTime? player2SmileDetectedAt,  String? winner,  DateTime? roundEndedAt,  double? player1UploadTime,  double? player2UploadTime,  double? player1ReactionTime,  double? player2ReactionTime)?  $default,) {final _that = this;
switch (_that) {
case _RoundModel() when $default != null:
return $default(_that.player1ImageUrl,_that.player2ImageUrl,_that.player1ImageReady,_that.player2ImageReady,_that.shootingAt,_that.player1UploadedAt,_that.player2UploadedAt,_that.bothReadyAt,_that.displayCountdownStartedAt,_that.imagesDisplayedAt,_that.player1SmileDetectedAt,_that.player2SmileDetectedAt,_that.winner,_that.roundEndedAt,_that.player1UploadTime,_that.player2UploadTime,_that.player1ReactionTime,_that.player2ReactionTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoundModel implements RoundModel {
  const _RoundModel({this.player1ImageUrl, this.player2ImageUrl, this.player1ImageReady = false, this.player2ImageReady = false, this.shootingAt, this.player1UploadedAt, this.player2UploadedAt, this.bothReadyAt, this.displayCountdownStartedAt, this.imagesDisplayedAt, this.player1SmileDetectedAt, this.player2SmileDetectedAt, this.winner, this.roundEndedAt, this.player1UploadTime, this.player2UploadTime, this.player1ReactionTime, this.player2ReactionTime});
  factory _RoundModel.fromJson(Map<String, dynamic> json) => _$RoundModelFromJson(json);

@override final  String? player1ImageUrl;
@override final  String? player2ImageUrl;
@override@JsonKey() final  bool player1ImageReady;
@override@JsonKey() final  bool player2ImageReady;
@override final  DateTime? shootingAt;
@override final  DateTime? player1UploadedAt;
@override final  DateTime? player2UploadedAt;
@override final  DateTime? bothReadyAt;
@override final  DateTime? displayCountdownStartedAt;
@override final  DateTime? imagesDisplayedAt;
@override final  DateTime? player1SmileDetectedAt;
@override final  DateTime? player2SmileDetectedAt;
@override final  String? winner;
@override final  DateTime? roundEndedAt;
@override final  double? player1UploadTime;
@override final  double? player2UploadTime;
@override final  double? player1ReactionTime;
@override final  double? player2ReactionTime;

/// Create a copy of RoundModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoundModelCopyWith<_RoundModel> get copyWith => __$RoundModelCopyWithImpl<_RoundModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoundModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoundModel&&(identical(other.player1ImageUrl, player1ImageUrl) || other.player1ImageUrl == player1ImageUrl)&&(identical(other.player2ImageUrl, player2ImageUrl) || other.player2ImageUrl == player2ImageUrl)&&(identical(other.player1ImageReady, player1ImageReady) || other.player1ImageReady == player1ImageReady)&&(identical(other.player2ImageReady, player2ImageReady) || other.player2ImageReady == player2ImageReady)&&(identical(other.shootingAt, shootingAt) || other.shootingAt == shootingAt)&&(identical(other.player1UploadedAt, player1UploadedAt) || other.player1UploadedAt == player1UploadedAt)&&(identical(other.player2UploadedAt, player2UploadedAt) || other.player2UploadedAt == player2UploadedAt)&&(identical(other.bothReadyAt, bothReadyAt) || other.bothReadyAt == bothReadyAt)&&(identical(other.displayCountdownStartedAt, displayCountdownStartedAt) || other.displayCountdownStartedAt == displayCountdownStartedAt)&&(identical(other.imagesDisplayedAt, imagesDisplayedAt) || other.imagesDisplayedAt == imagesDisplayedAt)&&(identical(other.player1SmileDetectedAt, player1SmileDetectedAt) || other.player1SmileDetectedAt == player1SmileDetectedAt)&&(identical(other.player2SmileDetectedAt, player2SmileDetectedAt) || other.player2SmileDetectedAt == player2SmileDetectedAt)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.roundEndedAt, roundEndedAt) || other.roundEndedAt == roundEndedAt)&&(identical(other.player1UploadTime, player1UploadTime) || other.player1UploadTime == player1UploadTime)&&(identical(other.player2UploadTime, player2UploadTime) || other.player2UploadTime == player2UploadTime)&&(identical(other.player1ReactionTime, player1ReactionTime) || other.player1ReactionTime == player1ReactionTime)&&(identical(other.player2ReactionTime, player2ReactionTime) || other.player2ReactionTime == player2ReactionTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,player1ImageUrl,player2ImageUrl,player1ImageReady,player2ImageReady,shootingAt,player1UploadedAt,player2UploadedAt,bothReadyAt,displayCountdownStartedAt,imagesDisplayedAt,player1SmileDetectedAt,player2SmileDetectedAt,winner,roundEndedAt,player1UploadTime,player2UploadTime,player1ReactionTime,player2ReactionTime);

@override
String toString() {
  return 'RoundModel(player1ImageUrl: $player1ImageUrl, player2ImageUrl: $player2ImageUrl, player1ImageReady: $player1ImageReady, player2ImageReady: $player2ImageReady, shootingAt: $shootingAt, player1UploadedAt: $player1UploadedAt, player2UploadedAt: $player2UploadedAt, bothReadyAt: $bothReadyAt, displayCountdownStartedAt: $displayCountdownStartedAt, imagesDisplayedAt: $imagesDisplayedAt, player1SmileDetectedAt: $player1SmileDetectedAt, player2SmileDetectedAt: $player2SmileDetectedAt, winner: $winner, roundEndedAt: $roundEndedAt, player1UploadTime: $player1UploadTime, player2UploadTime: $player2UploadTime, player1ReactionTime: $player1ReactionTime, player2ReactionTime: $player2ReactionTime)';
}


}

/// @nodoc
abstract mixin class _$RoundModelCopyWith<$Res> implements $RoundModelCopyWith<$Res> {
  factory _$RoundModelCopyWith(_RoundModel value, $Res Function(_RoundModel) _then) = __$RoundModelCopyWithImpl;
@override @useResult
$Res call({
 String? player1ImageUrl, String? player2ImageUrl, bool player1ImageReady, bool player2ImageReady, DateTime? shootingAt, DateTime? player1UploadedAt, DateTime? player2UploadedAt, DateTime? bothReadyAt, DateTime? displayCountdownStartedAt, DateTime? imagesDisplayedAt, DateTime? player1SmileDetectedAt, DateTime? player2SmileDetectedAt, String? winner, DateTime? roundEndedAt, double? player1UploadTime, double? player2UploadTime, double? player1ReactionTime, double? player2ReactionTime
});




}
/// @nodoc
class __$RoundModelCopyWithImpl<$Res>
    implements _$RoundModelCopyWith<$Res> {
  __$RoundModelCopyWithImpl(this._self, this._then);

  final _RoundModel _self;
  final $Res Function(_RoundModel) _then;

/// Create a copy of RoundModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? player1ImageUrl = freezed,Object? player2ImageUrl = freezed,Object? player1ImageReady = null,Object? player2ImageReady = null,Object? shootingAt = freezed,Object? player1UploadedAt = freezed,Object? player2UploadedAt = freezed,Object? bothReadyAt = freezed,Object? displayCountdownStartedAt = freezed,Object? imagesDisplayedAt = freezed,Object? player1SmileDetectedAt = freezed,Object? player2SmileDetectedAt = freezed,Object? winner = freezed,Object? roundEndedAt = freezed,Object? player1UploadTime = freezed,Object? player2UploadTime = freezed,Object? player1ReactionTime = freezed,Object? player2ReactionTime = freezed,}) {
  return _then(_RoundModel(
player1ImageUrl: freezed == player1ImageUrl ? _self.player1ImageUrl : player1ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,player2ImageUrl: freezed == player2ImageUrl ? _self.player2ImageUrl : player2ImageUrl // ignore: cast_nullable_to_non_nullable
as String?,player1ImageReady: null == player1ImageReady ? _self.player1ImageReady : player1ImageReady // ignore: cast_nullable_to_non_nullable
as bool,player2ImageReady: null == player2ImageReady ? _self.player2ImageReady : player2ImageReady // ignore: cast_nullable_to_non_nullable
as bool,shootingAt: freezed == shootingAt ? _self.shootingAt : shootingAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadedAt: freezed == player1UploadedAt ? _self.player1UploadedAt : player1UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2UploadedAt: freezed == player2UploadedAt ? _self.player2UploadedAt : player2UploadedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,bothReadyAt: freezed == bothReadyAt ? _self.bothReadyAt : bothReadyAt // ignore: cast_nullable_to_non_nullable
as DateTime?,displayCountdownStartedAt: freezed == displayCountdownStartedAt ? _self.displayCountdownStartedAt : displayCountdownStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,imagesDisplayedAt: freezed == imagesDisplayedAt ? _self.imagesDisplayedAt : imagesDisplayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1SmileDetectedAt: freezed == player1SmileDetectedAt ? _self.player1SmileDetectedAt : player1SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player2SmileDetectedAt: freezed == player2SmileDetectedAt ? _self.player2SmileDetectedAt : player2SmileDetectedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String?,roundEndedAt: freezed == roundEndedAt ? _self.roundEndedAt : roundEndedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,player1UploadTime: freezed == player1UploadTime ? _self.player1UploadTime : player1UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player2UploadTime: freezed == player2UploadTime ? _self.player2UploadTime : player2UploadTime // ignore: cast_nullable_to_non_nullable
as double?,player1ReactionTime: freezed == player1ReactionTime ? _self.player1ReactionTime : player1ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,player2ReactionTime: freezed == player2ReactionTime ? _self.player2ReactionTime : player2ReactionTime // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
