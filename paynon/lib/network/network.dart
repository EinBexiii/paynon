
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkProvider {
  static const String API_URL = "https://paynon.rushnation.eu";
  static Provider dioProvider = Provider<Dio>((ref) => Dio()..interceptors.add(CookieManager(DefaultCookieJar())));
}
