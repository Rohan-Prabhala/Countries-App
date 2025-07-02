import 'package:mvmm_test/data/services/api/countries_name_service.dart';
import 'package:mvmm_test/data/services/model/country_model.dart';

class CountriesRepository {
  CountriesRepository({required CountriesNameService countriesNameService})
    : _countriesNameAPI = countriesNameService;

  final CountriesNameService _countriesNameAPI;

  List<CountryApiModel>? _cachedCountries;

  Future<List<CountryApiModel>> getCountriesOfLanguage(String language) async {
    await _loadCountries(language);
    return _cachedCountries!;
  }

  Future<CountryApiModel> getCountry(String language, int id) async {
    if (_cachedCountries == null) {
      await _loadCountries(language);
    }
    return _cachedCountries![id];
  }

  Future<void> _loadCountries(String language) async {
    _cachedCountries = await _countriesNameAPI.getCountriesOfLanguage(language);
  }
}
