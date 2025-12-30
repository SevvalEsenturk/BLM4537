// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeRule _$TimeRuleFromJson(Map<String, dynamic> json) {
  return _TimeRule.fromJson(json);
}

/// @nodoc
mixin _$TimeRule {
  int get id => throw _privateConstructorUsedError;
  int get childUserId => throw _privateConstructorUsedError;
  int get dailyLimitMinutes => throw _privateConstructorUsedError;
  Duration? get allowedWindowStart => throw _privateConstructorUsedError;
  Duration? get allowedWindowEnd => throw _privateConstructorUsedError;
  String? get activeDaysJson => throw _privateConstructorUsedError;
  String? get exceptionsJson => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TimeRule to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeRuleCopyWith<TimeRule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeRuleCopyWith<$Res> {
  factory $TimeRuleCopyWith(TimeRule value, $Res Function(TimeRule) then) =
      _$TimeRuleCopyWithImpl<$Res, TimeRule>;
  @useResult
  $Res call(
      {int id,
      int childUserId,
      int dailyLimitMinutes,
      Duration? allowedWindowStart,
      Duration? allowedWindowEnd,
      String? activeDaysJson,
      String? exceptionsJson,
      bool isActive,
      DateTime? updatedAt});
}

/// @nodoc
class _$TimeRuleCopyWithImpl<$Res, $Val extends TimeRule>
    implements $TimeRuleCopyWith<$Res> {
  _$TimeRuleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childUserId = null,
    Object? dailyLimitMinutes = null,
    Object? allowedWindowStart = freezed,
    Object? allowedWindowEnd = freezed,
    Object? activeDaysJson = freezed,
    Object? exceptionsJson = freezed,
    Object? isActive = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      childUserId: null == childUserId
          ? _value.childUserId
          : childUserId // ignore: cast_nullable_to_non_nullable
              as int,
      dailyLimitMinutes: null == dailyLimitMinutes
          ? _value.dailyLimitMinutes
          : dailyLimitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      allowedWindowStart: freezed == allowedWindowStart
          ? _value.allowedWindowStart
          : allowedWindowStart // ignore: cast_nullable_to_non_nullable
              as Duration?,
      allowedWindowEnd: freezed == allowedWindowEnd
          ? _value.allowedWindowEnd
          : allowedWindowEnd // ignore: cast_nullable_to_non_nullable
              as Duration?,
      activeDaysJson: freezed == activeDaysJson
          ? _value.activeDaysJson
          : activeDaysJson // ignore: cast_nullable_to_non_nullable
              as String?,
      exceptionsJson: freezed == exceptionsJson
          ? _value.exceptionsJson
          : exceptionsJson // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeRuleImplCopyWith<$Res>
    implements $TimeRuleCopyWith<$Res> {
  factory _$$TimeRuleImplCopyWith(
          _$TimeRuleImpl value, $Res Function(_$TimeRuleImpl) then) =
      __$$TimeRuleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int childUserId,
      int dailyLimitMinutes,
      Duration? allowedWindowStart,
      Duration? allowedWindowEnd,
      String? activeDaysJson,
      String? exceptionsJson,
      bool isActive,
      DateTime? updatedAt});
}

/// @nodoc
class __$$TimeRuleImplCopyWithImpl<$Res>
    extends _$TimeRuleCopyWithImpl<$Res, _$TimeRuleImpl>
    implements _$$TimeRuleImplCopyWith<$Res> {
  __$$TimeRuleImplCopyWithImpl(
      _$TimeRuleImpl _value, $Res Function(_$TimeRuleImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childUserId = null,
    Object? dailyLimitMinutes = null,
    Object? allowedWindowStart = freezed,
    Object? allowedWindowEnd = freezed,
    Object? activeDaysJson = freezed,
    Object? exceptionsJson = freezed,
    Object? isActive = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TimeRuleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      childUserId: null == childUserId
          ? _value.childUserId
          : childUserId // ignore: cast_nullable_to_non_nullable
              as int,
      dailyLimitMinutes: null == dailyLimitMinutes
          ? _value.dailyLimitMinutes
          : dailyLimitMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      allowedWindowStart: freezed == allowedWindowStart
          ? _value.allowedWindowStart
          : allowedWindowStart // ignore: cast_nullable_to_non_nullable
              as Duration?,
      allowedWindowEnd: freezed == allowedWindowEnd
          ? _value.allowedWindowEnd
          : allowedWindowEnd // ignore: cast_nullable_to_non_nullable
              as Duration?,
      activeDaysJson: freezed == activeDaysJson
          ? _value.activeDaysJson
          : activeDaysJson // ignore: cast_nullable_to_non_nullable
              as String?,
      exceptionsJson: freezed == exceptionsJson
          ? _value.exceptionsJson
          : exceptionsJson // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeRuleImpl implements _TimeRule {
  const _$TimeRuleImpl(
      {required this.id,
      required this.childUserId,
      required this.dailyLimitMinutes,
      this.allowedWindowStart,
      this.allowedWindowEnd,
      this.activeDaysJson,
      this.exceptionsJson,
      required this.isActive,
      this.updatedAt});

  factory _$TimeRuleImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeRuleImplFromJson(json);

  @override
  final int id;
  @override
  final int childUserId;
  @override
  final int dailyLimitMinutes;
  @override
  final Duration? allowedWindowStart;
  @override
  final Duration? allowedWindowEnd;
  @override
  final String? activeDaysJson;
  @override
  final String? exceptionsJson;
  @override
  final bool isActive;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'TimeRule(id: $id, childUserId: $childUserId, dailyLimitMinutes: $dailyLimitMinutes, allowedWindowStart: $allowedWindowStart, allowedWindowEnd: $allowedWindowEnd, activeDaysJson: $activeDaysJson, exceptionsJson: $exceptionsJson, isActive: $isActive, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeRuleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childUserId, childUserId) ||
                other.childUserId == childUserId) &&
            (identical(other.dailyLimitMinutes, dailyLimitMinutes) ||
                other.dailyLimitMinutes == dailyLimitMinutes) &&
            (identical(other.allowedWindowStart, allowedWindowStart) ||
                other.allowedWindowStart == allowedWindowStart) &&
            (identical(other.allowedWindowEnd, allowedWindowEnd) ||
                other.allowedWindowEnd == allowedWindowEnd) &&
            (identical(other.activeDaysJson, activeDaysJson) ||
                other.activeDaysJson == activeDaysJson) &&
            (identical(other.exceptionsJson, exceptionsJson) ||
                other.exceptionsJson == exceptionsJson) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      childUserId,
      dailyLimitMinutes,
      allowedWindowStart,
      allowedWindowEnd,
      activeDaysJson,
      exceptionsJson,
      isActive,
      updatedAt);

  /// Create a copy of TimeRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeRuleImplCopyWith<_$TimeRuleImpl> get copyWith =>
      __$$TimeRuleImplCopyWithImpl<_$TimeRuleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeRuleImplToJson(
      this,
    );
  }
}

abstract class _TimeRule implements TimeRule {
  const factory _TimeRule(
      {required final int id,
      required final int childUserId,
      required final int dailyLimitMinutes,
      final Duration? allowedWindowStart,
      final Duration? allowedWindowEnd,
      final String? activeDaysJson,
      final String? exceptionsJson,
      required final bool isActive,
      final DateTime? updatedAt}) = _$TimeRuleImpl;

  factory _TimeRule.fromJson(Map<String, dynamic> json) =
      _$TimeRuleImpl.fromJson;

  @override
  int get id;
  @override
  int get childUserId;
  @override
  int get dailyLimitMinutes;
  @override
  Duration? get allowedWindowStart;
  @override
  Duration? get allowedWindowEnd;
  @override
  String? get activeDaysJson;
  @override
  String? get exceptionsJson;
  @override
  bool get isActive;
  @override
  DateTime? get updatedAt;

  /// Create a copy of TimeRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeRuleImplCopyWith<_$TimeRuleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
