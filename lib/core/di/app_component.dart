import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:quizz_app/features/quizz_page/data/repository/question_repository_implement.dart';
import 'package:quizz_app/features/quizz_page/data/services/qustion_answer_services.dart';
import 'package:quizz_app/features/quizz_page/domain/repository/question_repository.dart';
import 'package:quizz_app/features/splash_screen/splash_screen.dart';

import '../../features/quizz_page/presentation/controller/question_controller.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerFactory<QuestionController>(
          () => Get.put(QuestionController()));
  locator.registerFactory<QuestionServices>(() => QuestionServices());
  locator.registerFactory<QuestionRepository>(
          () => QuestionImplement(locator<QuestionServices>()));

}
