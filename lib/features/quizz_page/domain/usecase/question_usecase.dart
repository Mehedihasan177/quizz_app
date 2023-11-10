import 'package:quizz_app/features/quizz_page/domain/repository/question_repository.dart';

abstract class QuestionUseCase {
  final QuestionRepository questionRepository;

  QuestionUseCase(this.questionRepository);
}