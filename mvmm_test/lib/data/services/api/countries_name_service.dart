//  https://my-json-server.typicode.com/rohan-prabhala/flutter-test-server/db

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mvmm_test/data/services/model/country_model.dart';

class CountriesNameService {
  Future<List<CountryApiModel>> getCountriesOfLanguage(String language) async {
    language = language.toLowerCase();
    String apiUrl = 'https://restcountries.com/v3.1/lang/$language';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var list = jsonDecode(response.body) as List;

      int index = 0;
      return list
          .map((i) => CountryApiModel.fromJSON(i, index++, language))
          .toList();
    } else {
      String errorBase =
          'Failed to load countries with error code: ${response.statusCode}.\n';
      switch (response.statusCode) {
        case 303:
          throw Exception(
            '${errorBase}See Other. Call a GET request to a different URI.',
          );
        case 400:
          throw Exception(
            '${errorBase}Bad Request. Invalid syntax in the request.',
          );
        case 500:
          throw Exception(
            '${errorBase}Internal Server Error. Server doesn\'t know what to do.',
          );
        case 502:
          throw Exception(
            '${errorBase}Bad Gateway. Invalid response from upstream server.',
          );
        case 504:
          throw Exception(
            '${errorBase}Gateway Timeout. Could not get a response in time.',
          );
        default:
          throw Exception('AMBIGUOUS | $errorBase');
      }
    }
  }
}
