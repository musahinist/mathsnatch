import 'dart:convert';

import 'package:meta/meta.dart';

class Topic {
  String topicId;
  String topicName;
  String topicPic;
  int difficulty;
  Topic({
    @required this.topicId,
    @required this.topicName,
    @required this.topicPic,
    @required this.difficulty,
  });

  // Topic({this.topicId, this.topicName, this.topicPic, this.difficulty});

  // Topic.fromJson(Map<String, dynamic> json) {
  //   topicId = json['topicId'];
  //   topicName = json['topicName'];
  //   topicPic = json['topicPic'];
  //   difficulty = json['difficulty'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['topicId'] = this.topicId;
  //   data['topicName'] = this.topicName;
  //   data['topicPic'] = this.topicPic;
  //   data['difficulty'] = this.difficulty;
  //   return data;
  // }

  Topic copyWith({
    String topicId,
    String topicName,
    String topicPic,
    int difficulty,
  }) {
    return Topic(
      topicId: topicId ?? this.topicId,
      topicName: topicName ?? this.topicName,
      topicPic: topicPic ?? this.topicPic,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topicId': topicId,
      'topicName': topicName,
      'topicPic': topicPic,
      'difficulty': difficulty,
    };
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Topic(
      topicId: map['topicId'] ?? '',
      topicName: map['topicName'] ?? '',
      topicPic: map['topicPic'] ?? '',
      difficulty: map['difficulty'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) => Topic.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Topic(topicId: $topicId, topicName: $topicName, topicPic: $topicPic, difficulty: $difficulty)';
  }
}
