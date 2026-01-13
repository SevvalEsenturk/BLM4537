// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pairing_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PairingRequest _$PairingRequestFromJson(Map<String, dynamic> json) {
  return _PairingRequest.fromJson(json);
}

/// @nodoc
mixin _$PairingRequest {
  int get id => throw _privateConstructorUsedError;
  int get parentUserId => throw _privateConstructorUsedError;
  int get childUserId => throw _privateConstructorUsedError;
  String get pairingCode => throw _privateConstructorUsedError;
  String get deviceName => throw _privateConstructorUsedError;
  String get deviceType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  String? get childName => throw _privateConstructorUsedError;

  /// Serializes this PairingRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PairingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PairingRequestCopyWith<PairingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairingRequestCopyWith<$Res> {
  factory $PairingRequestCopyWith(
          PairingRequest value, $Res Function(PairingRequest) then) =
      _$PairingRequestCopyWithImpl<$Res, PairingRequest>;
  @useResult
  $Res call(
      {int id,
      int parentUserId,
      int childUserId,
      String pairingCode,
      String deviceName,
      String deviceType,
      String status,
      DateTime createdAt,
      DateTime? expiresAt,
      DateTime? approvedAt,
      String? childName});
}

/// @nodoc
class _$PairingRequestCopyWithImpl<$Res, $Val extends PairingRequest>
    implements $PairingRequestCopyWith<$Res> {
  _$PairingRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PairingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentUserId = null,
    Object? childUserId = null,
    Object? pairingCode = null,
    Object? deviceName = null,
    Object? deviceType = null,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? approvedAt = freezed,
    Object? childName = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      parentUserId: null == parentUserId
          ? _value.parentUserId
          : parentUserId // ignore: cast_nullable_to_non_nullable
              as int,
      childUserId: null == childUserId
          ? _value.childUserId
          : childUserId // ignore: cast_nullable_to_non_nullable
              as int,
      pairingCode: null == pairingCode
          ? _value.pairingCode
          : pairingCode // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      childName: freezed == childName
          ? _value.childName
          : childName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PairingRequestImplCopyWith<$Res>
    implements $PairingRequestCopyWith<$Res> {
  factory _$$PairingRequestImplCopyWith(_$PairingRequestImpl value,
          $Res Function(_$PairingRequestImpl) then) =
      __$$PairingRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int parentUserId,
      int childUserId,
      String pairingCode,
      String deviceName,
      String deviceType,
      String status,
      DateTime createdAt,
      DateTime? expiresAt,
      DateTime? approvedAt,
      String? childName});
}

/// @nodoc
class __$$PairingRequestImplCopyWithImpl<$Res>
    extends _$PairingRequestCopyWithImpl<$Res, _$PairingRequestImpl>
    implements _$$PairingRequestImplCopyWith<$Res> {
  __$$PairingRequestImplCopyWithImpl(
      _$PairingRequestImpl _value, $Res Function(_$PairingRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PairingRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? parentUserId = null,
    Object? childUserId = null,
    Object? pairingCode = null,
    Object? deviceName = null,
    Object? deviceType = null,
    Object? status = null,
    Object? createdAt = null,
    Object? expiresAt = freezed,
    Object? approvedAt = freezed,
    Object? childName = freezed,
  }) {
    return _then(_$PairingRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      parentUserId: null == parentUserId
          ? _value.parentUserId
          : parentUserId // ignore: cast_nullable_to_non_nullable
              as int,
      childUserId: null == childUserId
          ? _value.childUserId
          : childUserId // ignore: cast_nullable_to_non_nullable
              as int,
      pairingCode: null == pairingCode
          ? _value.pairingCode
          : pairingCode // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: null == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      childName: freezed == childName
          ? _value.childName
          : childName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PairingRequestImpl implements _PairingRequest {
  const _$PairingRequestImpl(
      {required this.id,
      required this.parentUserId,
      required this.childUserId,
      required this.pairingCode,
      required this.deviceName,
      required this.deviceType,
      required this.status,
      required this.createdAt,
      this.expiresAt,
      this.approvedAt,
      this.childName});

  factory _$PairingRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairingRequestImplFromJson(json);

  @override
  final int id;
  @override
  final int parentUserId;
  @override
  final int childUserId;
  @override
  final String pairingCode;
  @override
  final String deviceName;
  @override
  final String deviceType;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? approvedAt;
  @override
  final String? childName;

  @override
  String toString() {
    return 'PairingRequest(id: $id, parentUserId: $parentUserId, childUserId: $childUserId, pairingCode: $pairingCode, deviceName: $deviceName, deviceType: $deviceType, status: $status, createdAt: $createdAt, expiresAt: $expiresAt, approvedAt: $approvedAt, childName: $childName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairingRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.parentUserId, parentUserId) ||
                other.parentUserId == parentUserId) &&
            (identical(other.childUserId, childUserId) ||
                other.childUserId == childUserId) &&
            (identical(other.pairingCode, pairingCode) ||
                other.pairingCode == pairingCode) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.childName, childName) ||
                other.childName == childName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      parentUserId,
      childUserId,
      pairingCode,
      deviceName,
      deviceType,
      status,
      createdAt,
      expiresAt,
      approvedAt,
      childName);

  /// Create a copy of PairingRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PairingRequestImplCopyWith<_$PairingRequestImpl> get copyWith =>
      __$$PairingRequestImplCopyWithImpl<_$PairingRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PairingRequestImplToJson(
      this,
    );
  }
}

abstract class _PairingRequest implements PairingRequest {
  const factory _PairingRequest(
      {required final int id,
      required final int parentUserId,
      required final int childUserId,
      required final String pairingCode,
      required final String deviceName,
      required final String deviceType,
      required final String status,
      required final DateTime createdAt,
      final DateTime? expiresAt,
      final DateTime? approvedAt,
      final String? childName}) = _$PairingRequestImpl;

  factory _PairingRequest.fromJson(Map<String, dynamic> json) =
      _$PairingRequestImpl.fromJson;

  @override
  int get id;
  @override
  int get parentUserId;
  @override
  int get childUserId;
  @override
  String get pairingCode;
  @override
  String get deviceName;
  @override
  String get deviceType;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  DateTime? get expiresAt;
  @override
  DateTime? get approvedAt;
  @override
  String? get childName;

  /// Create a copy of PairingRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PairingRequestImplCopyWith<_$PairingRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PairingCode _$PairingCodeFromJson(Map<String, dynamic> json) {
  return _PairingCode.fromJson(json);
}

/// @nodoc
mixin _$PairingCode {
  String get code => throw _privateConstructorUsedError;
  DateTime get expiresAt => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this PairingCode to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PairingCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PairingCodeCopyWith<PairingCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairingCodeCopyWith<$Res> {
  factory $PairingCodeCopyWith(
          PairingCode value, $Res Function(PairingCode) then) =
      _$PairingCodeCopyWithImpl<$Res, PairingCode>;
  @useResult
  $Res call({String code, DateTime expiresAt, String? message});
}

/// @nodoc
class _$PairingCodeCopyWithImpl<$Res, $Val extends PairingCode>
    implements $PairingCodeCopyWith<$Res> {
  _$PairingCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PairingCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? expiresAt = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PairingCodeImplCopyWith<$Res>
    implements $PairingCodeCopyWith<$Res> {
  factory _$$PairingCodeImplCopyWith(
          _$PairingCodeImpl value, $Res Function(_$PairingCodeImpl) then) =
      __$$PairingCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, DateTime expiresAt, String? message});
}

/// @nodoc
class __$$PairingCodeImplCopyWithImpl<$Res>
    extends _$PairingCodeCopyWithImpl<$Res, _$PairingCodeImpl>
    implements _$$PairingCodeImplCopyWith<$Res> {
  __$$PairingCodeImplCopyWithImpl(
      _$PairingCodeImpl _value, $Res Function(_$PairingCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of PairingCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? expiresAt = null,
    Object? message = freezed,
  }) {
    return _then(_$PairingCodeImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PairingCodeImpl implements _PairingCode {
  const _$PairingCodeImpl(
      {required this.code, required this.expiresAt, this.message});

  factory _$PairingCodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairingCodeImplFromJson(json);

  @override
  final String code;
  @override
  final DateTime expiresAt;
  @override
  final String? message;

  @override
  String toString() {
    return 'PairingCode(code: $code, expiresAt: $expiresAt, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairingCodeImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, expiresAt, message);

  /// Create a copy of PairingCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PairingCodeImplCopyWith<_$PairingCodeImpl> get copyWith =>
      __$$PairingCodeImplCopyWithImpl<_$PairingCodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PairingCodeImplToJson(
      this,
    );
  }
}

abstract class _PairingCode implements PairingCode {
  const factory _PairingCode(
      {required final String code,
      required final DateTime expiresAt,
      final String? message}) = _$PairingCodeImpl;

  factory _PairingCode.fromJson(Map<String, dynamic> json) =
      _$PairingCodeImpl.fromJson;

  @override
  String get code;
  @override
  DateTime get expiresAt;
  @override
  String? get message;

  /// Create a copy of PairingCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PairingCodeImplCopyWith<_$PairingCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
