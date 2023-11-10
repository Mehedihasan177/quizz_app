import 'package:quizz_app/core/data/model/api_response.dart';
import 'package:quizz_app/features/quizz_page/data/models/question_model.dart';
import 'package:quizz_app/features/quizz_page/data/services/qustion_answer_services.dart';
import 'package:quizz_app/features/quizz_page/domain/repository/question_repository.dart';

class QuestionImplement extends QuestionRepository {
  QuestionImplement(QuestionServices questionServices)
      : super(questionServices);

  @override
  Future<Response<QuizModel?>?> questionPass() async {
    Response<QuizModel>? apiResponse;
      apiResponse = await questionServices.questionData();
      return apiResponse;
  }
}
