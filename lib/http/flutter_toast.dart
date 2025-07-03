import 'package:fluttertoast/fluttertoast.dart';

class FlutterShowToast {
  static showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
