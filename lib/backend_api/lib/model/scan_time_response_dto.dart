//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ScanTimeResponseDTO {
  /// Returns a new [ScanTimeResponseDTO] instance.
  ScanTimeResponseDTO({
    this.grant,
    this.prevScanTime,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? grant;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? prevScanTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ScanTimeResponseDTO &&
     other.grant == grant &&
     other.prevScanTime == prevScanTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (grant == null ? 0 : grant!.hashCode) +
    (prevScanTime == null ? 0 : prevScanTime!.hashCode);

  @override
  String toString() => 'ScanTimeResponseDTO[grant=$grant, prevScanTime=$prevScanTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.grant != null) {
      json[r'grant'] = this.grant;
    } else {
      json[r'grant'] = null;
    }
    if (this.prevScanTime != null) {
      json[r'prevScanTime'] = this.prevScanTime;
    } else {
      json[r'prevScanTime'] = null;
    }
    return json;
  }

  /// Returns a new [ScanTimeResponseDTO] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ScanTimeResponseDTO? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ScanTimeResponseDTO[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ScanTimeResponseDTO[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ScanTimeResponseDTO(
        grant: mapValueOfType<String>(json, r'grant'),
        prevScanTime: mapValueOfType<String>(json, r'prevScanTime'),
      );
    }
    return null;
  }

  static List<ScanTimeResponseDTO>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ScanTimeResponseDTO>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ScanTimeResponseDTO.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ScanTimeResponseDTO> mapFromJson(dynamic json) {
    final map = <String, ScanTimeResponseDTO>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ScanTimeResponseDTO.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ScanTimeResponseDTO-objects as value to a dart map
  static Map<String, List<ScanTimeResponseDTO>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ScanTimeResponseDTO>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ScanTimeResponseDTO.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

