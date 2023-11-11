import 'package:flutter/material.dart';
import '../../core/routes/route_name.dart';
import '../../core/routes/router.dart';
import '../../core/utils/consts/app_assets.dart';
import '../../core/utils/consts/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),(){
      RouteGenerator.pushNamedAndRemoveAll(context, Routes.homepage);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Expanded(
              flex: 9,
              child: Center(
                child: Image.asset(AppAssets.logo, height: 200, width:  200,),
              ),
            ),
            Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.off_white_color,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
