import 'package:dio/dio.dart';

import '../../config/app_localization.dart';

class HttpException implements Exception {
  Response response;

  HttpException(
    this.response,
  );

  @override
  String toString() {
    return 'HttpException{response: $response}';
  }

  static String handleError(Exception error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = AppLocalization.getString("kRequestCanceled");
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = AppLocalization.getString("kConnectionTimeout");
          break;
        case DioErrorType.DEFAULT:
          errorDescription = AppLocalization.getString("kConnectionLost");
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = AppLocalization.getString("kReceiveTimeout");
          break;
        case DioErrorType.RESPONSE: //TODO Make them in enumaration
          errorDescription = error.response?.data ?? '';
          // switch (error.response?.data ?? '') {
          //   case "tokenNotFound":
          //     errorDescription = labels.exception.tokenNotFound;
          //     break;

          //   case "usernamePasswordFail":
          //     errorDescription =
          //         AppLocalization.getString("kUsernamePasswordFail");
          //     break;

          //   case "noPermission":
          //     errorDescription = AppLocalization.getString("kNoPermission");
          //     break;

          //   case "dataNotFound":
          //     errorDescription = AppLocalization.getString("kDataNotFound");
          //     break;

          //   case "pageNotFound":
          //     errorDescription = AppLocalization.getString("kPageNotFound");
          //     break;

          //   case "emailMustBeUnique":
          //     errorDescription =
          //         AppLocalization.getString("kEmailMustBeUnique");
          //     break;

          //   case "sessionNotFound":
          //     errorDescription = AppLocalization.getString("kSessionNotFound");
          //     break;

          //   case "invalidEmail":
          //     errorDescription = AppLocalization.getString("kInvalidEmail");
          //     break;

          //   case "emailNotNull":
          //     errorDescription = AppLocalization.getString("kEmailNotNull");
          //     break;

          //   case "surnameNotNull":
          //     errorDescription = AppLocalization.getString("kSurnameNotNull");
          //     break;

          //   case "nameNotNull":
          //     errorDescription = AppLocalization.getString("kNameNotNull");
          //     break;

          //   case "sizeExceed":
          //     errorDescription = AppLocalization.getString("kSizeExceed");
          //     break;

          //   case "birthDateNotNull":
          //     errorDescription = AppLocalization.getString("kBirthDateNotNull");
          //     break;

          //   default:
          //     errorDescription = AppLocalization.getString("kUnknownError");
          //     break;
          // }
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = AppLocalization.getString("kCheckYourConnection");
          break;
      }
    } else {
      errorDescription = AppLocalization.getString("kUnexpectedError");
    }
    return errorDescription;
  }
}
