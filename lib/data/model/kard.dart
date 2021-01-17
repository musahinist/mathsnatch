import 'dart:convert';

import 'package:meta/meta.dart';

class Kard {
  String cardId;
  String cardName;
  String cardPic;

  Kard({
    @required this.cardId,
    @required this.cardName,
    @required this.cardPic,
  });

  Kard copyWith({
    String cardId,
    String cardName,
    String cardPic,
  }) {
    return Kard(
      cardId: cardId ?? this.cardId,
      cardName: cardName ?? this.cardName,
      cardPic: cardPic ?? this.cardPic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cardId': cardId,
      'cardName': cardName,
      'cardPic': cardPic,
    };
  }

  factory Kard.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Kard(
      cardId: map['cardId'] ?? '',
      cardName: map['cardName'] ?? '',
      cardPic: map['cardPic'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Kard.fromJson(String source) => Kard.fromMap(json.decode(source));

  @override
  String toString() =>
      'Kard(cardId: $cardId, cardName: $cardName, cardPic: $cardPic)';
}
