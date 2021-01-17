import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:deneme/data/model/svg_avatar.dart';

class User {
  int age;
  String location;
  bool isAdmin;
  bool isGold;
  int coins;
  int gems;
  int level;
  int correctAnswers;
  int wrongAnswers;
  int accuracyPercentage;
  int challengeCorrectAnswers;
  int challengeWrongAnswers;
  String sId;
  String name;
  String email;
  SvgAvatar avatar;
  String lastOnline;
  List<FinishedCards> finishedCards;
  User({
    @required this.age,
    @required this.location,
    @required this.isAdmin,
    @required this.isGold,
    @required this.coins,
    @required this.gems,
    @required this.level,
    @required this.correctAnswers,
    @required this.wrongAnswers,
    @required this.accuracyPercentage,
    @required this.challengeCorrectAnswers,
    @required this.challengeWrongAnswers,
    @required this.sId,
    @required this.name,
    @required this.email,
    @required this.avatar,
    @required this.lastOnline,
    @required this.finishedCards,
  });

  User copyWith({
    int age,
    String location,
    bool isAdmin,
    bool isGold,
    int coins,
    int gems,
    int level,
    int correctAnswers,
    int wrongAnswers,
    int accuracyPercentage,
    int challengeCorrectAnswers,
    int challengeWrongAnswers,
    String sId,
    String name,
    String email,
    SvgAvatar avatar,
    String lastOnline,
    List<FinishedCards> finishedCards,
  }) {
    return User(
      age: age ?? this.age,
      location: location ?? this.location,
      isAdmin: isAdmin ?? this.isAdmin,
      isGold: isGold ?? this.isGold,
      coins: coins ?? this.coins,
      gems: gems ?? this.gems,
      level: level ?? this.level,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      accuracyPercentage: accuracyPercentage ?? this.accuracyPercentage,
      challengeCorrectAnswers:
          challengeCorrectAnswers ?? this.challengeCorrectAnswers,
      challengeWrongAnswers:
          challengeWrongAnswers ?? this.challengeWrongAnswers,
      sId: sId ?? this.sId,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      lastOnline: lastOnline ?? this.lastOnline,
      finishedCards: finishedCards ?? this.finishedCards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'location': location,
      'isAdmin': isAdmin,
      'isGold': isGold,
      'coins': coins,
      'gems': gems,
      'level': level,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'accuracyPercentage': accuracyPercentage,
      'challengeCorrectAnswers': challengeCorrectAnswers,
      'challengeWrongAnswers': challengeWrongAnswers,
      'sId': sId,
      'name': name,
      'email': email,
      'avatar': avatar?.toMap(),
      'lastOnline': lastOnline,
      'finishedCards': finishedCards?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      age: map['age'],
      location: map['location'],
      isAdmin: map['isAdmin'],
      isGold: map['isGold'],
      coins: map['coins'],
      gems: map['gems'],
      level: map['level'],
      correctAnswers: map['correctAnswers'],
      wrongAnswers: map['wrongAnswers'],
      accuracyPercentage: map['accuracyPercentage'],
      challengeCorrectAnswers: map['challengeCorrectAnswers'],
      challengeWrongAnswers: map['challengeWrongAnswers'],
      sId: map['sId'],
      name: map['name'],
      email: map['email'],
      avatar: SvgAvatar.fromMap(map['avatar']),
      lastOnline: map['lastOnline'],
      finishedCards: List<FinishedCards>.from(
          map['finishedCards']?.map((x) => FinishedCards.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(age: $age, location: $location, isAdmin: $isAdmin, isGold: $isGold, coins: $coins, gems: $gems, level: $level, correctAnswers: $correctAnswers, wrongAnswers: $wrongAnswers, accuracyPercentage: $accuracyPercentage, challengeCorrectAnswers: $challengeCorrectAnswers, challengeWrongAnswers: $challengeWrongAnswers, sId: $sId, name: $name, email: $email, avatar: $avatar, lastOnline: $lastOnline, finishedCards: $finishedCards)';
  }
}

class FinishedCards {
  String sId;
  String topicId;
  List<Cards> cards;
  FinishedCards({
    @required this.sId,
    @required this.topicId,
    @required this.cards,
  });

  FinishedCards copyWith({
    String sId,
    String topicId,
    List<Cards> cards,
  }) {
    return FinishedCards(
      sId: sId ?? this.sId,
      topicId: topicId ?? this.topicId,
      cards: cards ?? this.cards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'topicId': topicId,
      'cards': cards?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory FinishedCards.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FinishedCards(
      sId: map['sId'],
      topicId: map['topicId'],
      cards: List<Cards>.from(map['cards']?.map((x) => Cards.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FinishedCards.fromJson(String source) =>
      FinishedCards.fromMap(json.decode(source));

  @override
  String toString() =>
      'FinishedCards(sId: $sId, topicId: $topicId, cards: $cards)';
}

class Cards {
  int correctInCard;
  int wrongInCard;
  int accuracyPercentageInCard;
  String sId;
  String cardId;
  Cards({
    @required this.correctInCard,
    @required this.wrongInCard,
    @required this.accuracyPercentageInCard,
    @required this.sId,
    @required this.cardId,
  });

  Cards copyWith({
    int correctInCard,
    int wrongInCard,
    int accuracyPercentageInCard,
    String sId,
    String cardId,
  }) {
    return Cards(
      correctInCard: correctInCard ?? this.correctInCard,
      wrongInCard: wrongInCard ?? this.wrongInCard,
      accuracyPercentageInCard:
          accuracyPercentageInCard ?? this.accuracyPercentageInCard,
      sId: sId ?? this.sId,
      cardId: cardId ?? this.cardId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'correctInCard': correctInCard,
      'wrongInCard': wrongInCard,
      'accuracyPercentageInCard': accuracyPercentageInCard,
      'sId': sId,
      'cardId': cardId,
    };
  }

  factory Cards.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cards(
      correctInCard: map['correctInCard'],
      wrongInCard: map['wrongInCard'],
      accuracyPercentageInCard: map['accuracyPercentageInCard'],
      sId: map['sId'],
      cardId: map['cardId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cards.fromJson(String source) => Cards.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cards(correctInCard: $correctInCard, wrongInCard: $wrongInCard, accuracyPercentageInCard: $accuracyPercentageInCard, sId: $sId, cardId: $cardId)';
  }
}
