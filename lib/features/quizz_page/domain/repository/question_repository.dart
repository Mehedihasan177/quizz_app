import 'package:quizz_app/features/quizz_page/data/models/question_model.dart';
import '../../../../core/data/model/api_response.dart';

import '../../data/services/qustion_answer_services.dart';

abstract class QuestionRepository {
  final QuestionServices questionServices;

  QuestionRepository(this.questionServices);

  Future<Response<QuizModel?>?> questionPass();
}
