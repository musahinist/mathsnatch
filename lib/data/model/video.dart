import 'dart:convert';

import 'package:meta/meta.dart';

class Video {
  String sId;
  String topicId;
  String cardId;
  String videoId;
  String videoLink;
  String solutionVideoLink;
  String correctVideoId;
  String wrongVideoId;
  List<Questions> questions;
  int iV;
  Video({
    @required this.sId,
    @required this.topicId,
    @required this.cardId,
    @required this.videoId,
    @required this.videoLink,
    @required this.solutionVideoLink,
    @required this.correctVideoId,
    @required this.wrongVideoId,
    @required this.questions,
    @required this.iV,
  });

  Video copyWith({
    String sId,
    String topicId,
    String cardId,
    String videoId,
    String videoLink,
    String solutionVideoLink,
    String correctVideoId,
    String wrongVideoId,
    List<Questions> questions,
    int iV,
  }) {
    return Video(
      sId: sId ?? this.sId,
      topicId: topicId ?? this.topicId,
      cardId: cardId ?? this.cardId,
      videoId: videoId ?? this.videoId,
      videoLink: videoLink ?? this.videoLink,
      solutionVideoLink: solutionVideoLink ?? this.solutionVideoLink,
      correctVideoId: correctVideoId ?? this.correctVideoId,
      wrongVideoId: wrongVideoId ?? this.wrongVideoId,
      questions: questions ?? this.questions,
      iV: iV ?? this.iV,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'topicId': topicId,
      'cardId': cardId,
      'videoId': videoId,
      'videoLink': videoLink,
      'solutionVideoLink': solutionVideoLink,
      'correctVideoId': correctVideoId,
      'wrongVideoId': wrongVideoId,
      'questions': questions?.map((x) => x?.toMap())?.toList(),
      'iV': iV,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Video(
      sId: map['sId'],
      topicId: map['topicId'],
      cardId: map['cardId'],
      videoId: map['videoId'],
      videoLink: map['videoLink'],
      solutionVideoLink: map['solutionVideoLink'],
      correctVideoId: map['correctVideoId'],
      wrongVideoId: map['wrongVideoId'],
      questions: List<Questions>.from(
          map['questions']?.map((x) => Questions.fromMap(x))),
      iV: map['iV'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Video(sId: $sId, topicId: $topicId, cardId: $cardId, videoId: $videoId, videoLink: $videoLink, solutionVideoLink: $solutionVideoLink, correctVideoId: $correctVideoId, wrongVideoId: $wrongVideoId, questions: $questions, iV: $iV)';
  }
}

class Questions {
  String sId;
  String questionId;
  String question;
  String correctAnswer;
  String wrongAnswer;
  Questions({
    @required this.sId,
    @required this.questionId,
    @required this.question,
    @required this.correctAnswer,
    @required this.wrongAnswer,
  });

  Questions copyWith({
    String sId,
    String questionId,
    String question,
    String correctAnswer,
    String wrongAnswer,
  }) {
    return Questions(
      sId: sId ?? this.sId,
      questionId: questionId ?? this.questionId,
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      wrongAnswer: wrongAnswer ?? this.wrongAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'questionId': questionId,
      'question': question,
      'correctAnswer': correctAnswer,
      'wrongAnswer': wrongAnswer,
    };
  }

  factory Questions.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Questions(
      sId: map['sId'],
      questionId: map['questionId'],
      question: map['question'],
      correctAnswer: map['correctAnswer'],
      wrongAnswer: map['wrongAnswer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Questions.fromJson(String source) =>
      Questions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Questions(sId: $sId, questionId: $questionId, question: $question, correctAnswer: $correctAnswer, wrongAnswer: $wrongAnswer)';
  }
}
