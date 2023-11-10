import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizz_app/core/utils/consts/app_colors.dart';
import 'package:quizz_app/core/utils/consts/app_sizes.dart';
import 'package:quizz_app/core/utils/consts/textstyle.dart';
import 'package:quizz_app/core/utils/core/extensions/extensions.dart';
import 'package:quizz_app/features/quizz_page/presentation/ui/question_page/question_page.dart';

import '../../../../../core/routes/route_name.dart';
import '../../../../../core/routes/router.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GlobalText(text: "Gorgeous Bangladesh Ltd.", color: AppColors.black, fontSize: AppSizes.size24, fontWeight: FontWeight.bold),
            10.ph,
            GlobalText(text: "Quizz", color: AppColors.black, fontSize: AppSizes.size22, fontWeight: FontWeight.bold),
            30.ph,
            GlobalText(text: "Highscore", color: AppColors.black, fontSize: AppSizes.size22, fontWeight: FontWeight.bold),
            20.ph,
            GlobalText(text: "20 Points", color: AppColors.black, fontSize: AppSizes.size22, fontWeight: FontWeight.bold),
            40.ph,
            
            ElevatedButton(onPressed: (){
              RouteGenerator.pushNamed(context, Routes.questionpage);
            }, child: const Text("data"))
          ],
        ),
      ),
    );
  }
}
