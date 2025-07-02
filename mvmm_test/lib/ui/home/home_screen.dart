import 'package:flutter/material.dart';
import 'package:mvmm_test/data/repositories/countries_repository.dart';
import 'package:mvmm_test/data/services/api/countries_name_service.dart';
import 'package:mvmm_test/ui/core/widgets/custom_app_bar.dart';
import 'package:mvmm_test/ui/countries/view_models/countries_viewmodel.dart';
import 'package:mvmm_test/ui/countries/widgets/countries_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CountriesScreen countriesScreen = CountriesScreen(
      viewModel: CountriesViewModel(
        countriesRepository: CountriesRepository(
          countriesNameService: CountriesNameService(),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: ColorScheme.of(context).primary,
      appBar: appBar(
        'MVVM Test App',
        ColorScheme.of(context).primaryContainer,
        ColorScheme.of(context).primary,
      ),
      body: Center(
        child: buildPageButton(context, 'Countries', countriesScreen),
      ),
    );
  }

  Container buildPageButton(BuildContext context, String text, Widget page) {
    return Container(
      padding: EdgeInsets.all(50),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorScheme.of(context).primaryContainer,
          foregroundColor: ColorScheme.of(context).primary,
        ),
        child: Text(text, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
