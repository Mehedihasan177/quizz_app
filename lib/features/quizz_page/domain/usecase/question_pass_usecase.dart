import 'package:quizz_app/features/quizz_page/data/models/question_model.dart';
import 'package:quizz_app/features/quizz_page/domain/usecase/question_usecase.dart';

import '../../../../core/data/model/api_response.dart';

class QuestionPassUseCase extends QuestionUseCase {
  QuestionPassUseCase(super.questionRepository);

  Future<Response<QuizModel?>?> call() async {
    return await questionRepository.questionPass();
  }
}
