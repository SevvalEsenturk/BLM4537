// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usage_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UsageRecord _$UsageRecordFromJson(Map<String, dynamic> json) {
  return _UsageRecord.fromJson(json);
}

/// @nodoc
mixin _$UsageRecord {
  int get id => throw _privateConstructorUsedError;
  int get childUserId => throw _privateConstructorUsedError;
  String get appName => throw _privateConstructorUsedError;
  int get usageMinutes => throw _privateConstructorUsedError;
  String? get appCategory => throw _privateConstructorUsedError;
  DateTime get recordDate => throw _privateConstructorUsedError;

  /// Serializes this UsageRecord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageRecordCopyWith<UsageRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageRecordCopyWith<$Res> {
  factory $UsageRecordCopyWith(
          UsageRecord value, $Res Function(UsageRecord) then) =
      _$UsageRecordCopyWithImpl<$Res, UsageRecord>;
  @useResult
  $Res call(
      {int id,
      int childUserId,
      String appName,
      int usageMinutes,
      String? appCategory,
      DateTime recordDate});
}

/// @nodoc
class _$UsageRecordCopyWithImpl<$Res, $Val extends UsageRecord>
    implements $UsageRecordCopyWith<$Res> {
  _$UsageRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childUserId = null,
    Object? appName = null,
    Object? usageMinutes = null,
    Object? appCategory = freezed,
    Object? recordDate = null,
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
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      usageMinutes: null == usageMinutes
          ? _value.usageMinutes
          : usageMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      appCategory: freezed == appCategory
          ? _value.appCategory
          : appCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsageRecordImplCopyWith<$Res>
    implements $UsageRecordCopyWith<$Res> {
  factory _$$UsageRecordImplCopyWith(
          _$UsageRecordImpl value, $Res Function(_$UsageRecordImpl) then) =
      __$$UsageRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int childUserId,
      String appName,
      int usageMinutes,
      String? appCategory,
      DateTime recordDate});
}

/// @nodoc
class __$$UsageRecordImplCopyWithImpl<$Res>
    extends _$UsageRecordCopyWithImpl<$Res, _$UsageRecordImpl>
    implements _$$UsageRecordImplCopyWith<$Res> {
  __$$UsageRecordImplCopyWithImpl(
      _$UsageRecordImpl _value, $Res Function(_$UsageRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsageRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? childUserId = null,
    Object? appName = null,
    Object? usageMinutes = null,
    Object? appCategory = freezed,
    Object? recordDate = null,
  }) {
    return _then(_$UsageRecordImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      childUserId: null == childUserId
          ? _value.childUserId
          : childUserId // ignore: cast_nullable_to_non_nullable
              as int,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      usageMinutes: null == usageMinutes
          ? _value.usageMinutes
          : usageMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      appCategory: freezed == appCategory
          ? _value.appCategory
          : appCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      recordDate: null == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageRecordImpl implements _UsageRecord {
  const _$UsageRecordImpl(
      {required this.id,
      required this.childUserId,
      required this.appName,
      required this.usageMinutes,
      this.appCategory,
      required this.recordDate});

  factory _$UsageRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageRecordImplFromJson(json);

  @override
  final int id;
  @override
  final int childUserId;
  @override
  final String appName;
  @override
  final int usageMinutes;
  @override
  final String? appCategory;
  @override
  final DateTime recordDate;

  @override
  String toString() {
    return 'UsageRecord(id: $id, childUserId: $childUserId, appName: $appName, usageMinutes: $usageMinutes, appCategory: $appCategory, recordDate: $recordDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.childUserId, childUserId) ||
                other.childUserId == childUserId) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.usageMinutes, usageMinutes) ||
                other.usageMinutes == usageMinutes) &&
            (identical(other.appCategory, appCategory) ||
                other.appCategory == appCategory) &&
            (identical(other.recordDate, recordDate) ||
                other.recordDate == recordDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, childUserId, appName,
      usageMinutes, appCategory, recordDate);

  /// Create a copy of UsageRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageRecordImplCopyWith<_$UsageRecordImpl> get copyWith =>
      __$$UsageRecordImplCopyWithImpl<_$UsageRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageRecordImplToJson(
      this,
    );
  }
}

abstract class _UsageRecord implements UsageRecord {
  const factory _UsageRecord(
      {required final int id,
      required final int childUserId,
      required final String appName,
      required final int usageMinutes,
      final String? appCategory,
      required final DateTime recordDate}) = _$UsageRecordImpl;

  factory _UsageRecord.fromJson(Map<String, dynamic> json) =
      _$UsageRecordImpl.fromJson;

  @override
  int get id;
  @override
  int get childUserId;
  @override
  String get appName;
  @override
  int get usageMinutes;
  @override
  String? get appCategory;
  @override
  DateTime get recordDate;

  /// Create a copy of UsageRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageRecordImplCopyWith<_$UsageRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UsageSummary _$UsageSummaryFromJson(Map<String, dynamic> json) {
  return _UsageSummary.fromJson(json);
}

/// @nodoc
mixin _$UsageSummary {
  int get childId => throw _privateConstructorUsedError;
  String get range => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this UsageSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UsageSummaryCopyWith<UsageSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsageSummaryCopyWith<$Res> {
  factory $UsageSummaryCopyWith(
          UsageSummary value, $Res Function(UsageSummary) then) =
      _$UsageSummaryCopyWithImpl<$Res, UsageSummary>;
  @useResult
  $Res call(
      {int childId,
      String range,
      int totalMinutes,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class _$UsageSummaryCopyWithImpl<$Res, $Val extends UsageSummary>
    implements $UsageSummaryCopyWith<$Res> {
  _$UsageSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? childId = null,
    Object? range = null,
    Object? totalMinutes = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as String,
      totalMinutes: null == totalMinutes
          ? _value.totalMinutes
          : totalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UsageSummaryImplCopyWith<$Res>
    implements $UsageSummaryCopyWith<$Res> {
  factory _$$UsageSummaryImplCopyWith(
          _$UsageSummaryImpl value, $Res Function(_$UsageSummaryImpl) then) =
      __$$UsageSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int childId,
      String range,
      int totalMinutes,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class __$$UsageSummaryImplCopyWithImpl<$Res>
    extends _$UsageSummaryCopyWithImpl<$Res, _$UsageSummaryImpl>
    implements _$$UsageSummaryImplCopyWith<$Res> {
  __$$UsageSummaryImplCopyWithImpl(
      _$UsageSummaryImpl _value, $Res Function(_$UsageSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? childId = null,
    Object? range = null,
    Object? totalMinutes = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$UsageSummaryImpl(
      childId: null == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as int,
      range: null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as String,
      totalMinutes: null == totalMinutes
          ? _value.totalMinutes
          : totalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UsageSummaryImpl implements _UsageSummary {
  const _$UsageSummaryImpl(
      {required this.childId,
      required this.range,
      required this.totalMinutes,
      required this.startDate,
      required this.endDate});

  factory _$UsageSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UsageSummaryImplFromJson(json);

  @override
  final int childId;
  @override
  final String range;
  @override
  final int totalMinutes;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'UsageSummary(childId: $childId, range: $range, totalMinutes: $totalMinutes, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UsageSummaryImpl &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.range, range) || other.range == range) &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, childId, range, totalMinutes, startDate, endDate);

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UsageSummaryImplCopyWith<_$UsageSummaryImpl> get copyWith =>
      __$$UsageSummaryImplCopyWithImpl<_$UsageSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UsageSummaryImplToJson(
      this,
    );
  }
}

abstract class _UsageSummary implements UsageSummary {
  const factory _UsageSummary(
      {required final int childId,
      required final String range,
      required final int totalMinutes,
      required final DateTime startDate,
      required final DateTime endDate}) = _$UsageSummaryImpl;

  factory _UsageSummary.fromJson(Map<String, dynamic> json) =
      _$UsageSummaryImpl.fromJson;

  @override
  int get childId;
  @override
  String get range;
  @override
  int get totalMinutes;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of UsageSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UsageSummaryImplCopyWith<_$UsageSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopApp _$TopAppFromJson(Map<String, dynamic> json) {
  return _TopApp.fromJson(json);
}

/// @nodoc
mixin _$TopApp {
  String get appName => throw _privateConstructorUsedError;
  int get totalMinutes => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this TopApp to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopApp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopAppCopyWith<TopApp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopAppCopyWith<$Res> {
  factory $TopAppCopyWith(TopApp value, $Res Function(TopApp) then) =
      _$TopAppCopyWithImpl<$Res, TopApp>;
  @useResult
  $Res call({String appName, int totalMinutes, String? category});
}

/// @nodoc
class _$TopAppCopyWithImpl<$Res, $Val extends TopApp>
    implements $TopAppCopyWith<$Res> {
  _$TopAppCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopApp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? totalMinutes = null,
    Object? category = freezed,
  }) {
    return _then(_value.copyWith(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      totalMinutes: null == totalMinutes
          ? _value.totalMinutes
          : totalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TopAppImplCopyWith<$Res> implements $TopAppCopyWith<$Res> {
  factory _$$TopAppImplCopyWith(
          _$TopAppImpl value, $Res Function(_$TopAppImpl) then) =
      __$$TopAppImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String appName, int totalMinutes, String? category});
}

/// @nodoc
class __$$TopAppImplCopyWithImpl<$Res>
    extends _$TopAppCopyWithImpl<$Res, _$TopAppImpl>
    implements _$$TopAppImplCopyWith<$Res> {
  __$$TopAppImplCopyWithImpl(
      _$TopAppImpl _value, $Res Function(_$TopAppImpl) _then)
      : super(_value, _then);

  /// Create a copy of TopApp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appName = null,
    Object? totalMinutes = null,
    Object? category = freezed,
  }) {
    return _then(_$TopAppImpl(
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      totalMinutes: null == totalMinutes
          ? _value.totalMinutes
          : totalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TopAppImpl implements _TopApp {
  const _$TopAppImpl(
      {required this.appName, required this.totalMinutes, this.category});

  factory _$TopAppImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopAppImplFromJson(json);

  @override
  final String appName;
  @override
  final int totalMinutes;
  @override
  final String? category;

  @override
  String toString() {
    return 'TopApp(appName: $appName, totalMinutes: $totalMinutes, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopAppImpl &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.totalMinutes, totalMinutes) ||
                other.totalMinutes == totalMinutes) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, appName, totalMinutes, category);

  /// Create a copy of TopApp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopAppImplCopyWith<_$TopAppImpl> get copyWith =>
      __$$TopAppImplCopyWithImpl<_$TopAppImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopAppImplToJson(
      this,
    );
  }
}

abstract class _TopApp implements TopApp {
  const factory _TopApp(
      {required final String appName,
      required final int totalMinutes,
      final String? category}) = _$TopAppImpl;

  factory _TopApp.fromJson(Map<String, dynamic> json) = _$TopAppImpl.fromJson;

  @override
  String get appName;
  @override
  int get totalMinutes;
  @override
  String? get category;

  /// Create a copy of TopApp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopAppImplCopyWith<_$TopAppImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
