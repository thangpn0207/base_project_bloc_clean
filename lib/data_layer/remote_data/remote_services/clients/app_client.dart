import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'app_client.g.dart';

///We do call the rest API to get, store data on a remote database for that we
///need to write the rest API call at a single place and need to return the data
///if the rest call is a success or need to return custom error exception on the
///basis of 4xx, 5xx status code. We can make use of http package to make the
///rest API call in the flutter

///APIs class is for api tags
///
///NOTE: run this command everytime you edit this file: flutter pub run build_runner build --delete-conflicting-outputs

@RestApi(baseUrl: "")
abstract class AppClient {
  factory AppClient(Dio dio, {String baseUrl}) = _AppClient;
}
