import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static GetStorage getStorage = GetStorage();

  static String loginStatus = "loginStatus";
  static String fcmToken = "FcmToken";

  static setView({bool? value}) {
    return getStorage.write(loginStatus, value);
  }

  static getView() {
    return getStorage.read(loginStatus);
  }

  static setFcmToken({String? value}) {
    return getStorage.write(fcmToken, value);
  }

  static getFcmToken() {
    return getStorage.read(fcmToken);
  }

  static Future getClear() {
    return getStorage.erase();
  }
}
