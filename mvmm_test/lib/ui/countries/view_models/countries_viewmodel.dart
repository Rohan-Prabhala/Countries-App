import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mvmm_test/data/repositories/countries_repository.dart';
import 'package:mvmm_test/data/services/model/country_model.dart';

class CountriesViewModel extends ChangeNotifier {
  CountriesViewModel({required CountriesRepository countriesRepository})
    : _countriesRepository = countriesRepository {
    load('English');
  }

  final CountriesRepository _countriesRepository;

  List<CountryApiModel> _countries = [];

  UnmodifiableListView<CountryApiModel> get countries =>
      UnmodifiableListView(_countries);

  Future<void> load(String language) async {
    try {
      _countries = await _countriesRepository.getCountriesOfLanguage(
        language.toLowerCase(),
      );
      _countries.sort((a, b) => a.engOfficialName.compareTo(b.engOfficialName));
    } finally {
      notifyListeners();
    }
  }
}
