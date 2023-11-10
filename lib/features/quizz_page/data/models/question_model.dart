class QuizModel {
  List<Question?>? questions;

  QuizModel({
    this.questions,
  });

  factory QuizModel.fromJson(List<dynamic> json) {
    return QuizModel(
      questions: (json[0]['questions'] as List<dynamic>?)
          ?.map((e) => e == null ? null : Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Question {
  Answers? answers;
  String? correctAnswer;
  String? question;
  String? questionImageUrl;
  int? score;

  Question({
    this.answers,
    this.correctAnswer,
    this.question,
    this.questionImageUrl,
    this.score,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      answers: json['answers'] == null ? null : Answers.fromJson(json['answers'] as Map<String, dynamic>),
      correctAnswer: json['correctAnswer'] as String?,
      question: json['question'] as String?,
      questionImageUrl: json['questionImageUrl'] as String?,
      score: json['score'] as int?,
    );
  }
}

class Answers {
  String? a;
  String? b;
  String? c;
  String? d;

  Answers({
    this.a,
    this.b,
    this.c,
    this.d,
  });

  factory Answers.fromJson(Map<String, dynamic> json) {
    return Answers(
      a: json['A'] as String?,
      b: json['B'] as String?,
      c: json['C'] as String?,
      d: json['D'] as String?,
    );
  }
}
