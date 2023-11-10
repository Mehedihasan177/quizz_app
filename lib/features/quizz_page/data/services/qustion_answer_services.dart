import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quizz_app/features/quizz_page/data/models/question_model.dart';

import '../../../../core/data/model/api_response.dart';

class QuestionServices {

  Future<Response<QuizModel>?> questionData() async {
    Response<QuizModel>? apiResponse;
    try {
      String jsonContent = await rootBundle.loadString('assets/json_file/quiz_data.json');
      List<dynamic> jsonData = json.decode(jsonContent);
      final QuizModel quizModel = QuizModel.fromJson(jsonData);
      apiResponse = Response.success(quizModel);
    } catch (error) {
      print("Error: $error");  // Debug print
      apiResponse = Response.error("Error loading data from file", 500);
    }
    return apiResponse;
  }







}
