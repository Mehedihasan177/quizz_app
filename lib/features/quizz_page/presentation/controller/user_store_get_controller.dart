import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
class UserCatchController extends GetxController {
  var getScores = '0'.obs;
  storeScore(score) async {
    final SharedPreferences setdeviceNameModelUsername = await _prefs;
    setdeviceNameModelUsername.setString("score", score);
  }
  getScore() async {
    final SharedPreferences setdeviceNameModelUsername = await _prefs;
    var score = setdeviceNameModelUsername.getString("score");
    if (score != null) {
      getScores.value = score;
    }
  }
}