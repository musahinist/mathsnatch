import 'dart:convert';

import 'package:meta/meta.dart';

class SvgAvatar {
  String sId;
  String avatarSvg;

  SvgAvatar({
    @required this.sId,
    @required this.avatarSvg,
  });

  SvgAvatar copyWith({
    String sId,
    String avatarSvg,
  }) {
    return SvgAvatar(
      sId: sId ?? this.sId,
      avatarSvg: avatarSvg ?? this.avatarSvg,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'avatarSvg': avatarSvg,
    };
  }

  factory SvgAvatar.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SvgAvatar(
      sId: map['sId'] ?? '',
      avatarSvg: map['avatarSvg'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SvgAvatar.fromJson(String source) =>
      SvgAvatar.fromMap(json.decode(source));

  @override
  String toString() => 'SvgAvatar(sId: $sId, avatarSvg: $avatarSvg)';
}
