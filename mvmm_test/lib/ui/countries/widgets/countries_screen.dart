import 'package:flutter/material.dart';
import 'package:mvmm_test/ui/core/widgets/custom_app_bar.dart';
import 'package:mvmm_test/ui/countries/view_models/countries_viewmodel.dart';
import 'package:mvmm_test/ui/countries/widgets/country_tile.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key, required this.viewModel});

  final CountriesViewModel viewModel;

  @override
  State<StatefulWidget> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final languageOptions = [
    'English',
    'Spanish',
    'French',
    'Portuguese',
    'German',
    'Arabic',
    'Russian',
    'Swahili',
    'Italian',
    'Malay',
    'Dutch',
    'Tamil',
    'Tswana',
    'Chinese',
  ];

  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = languageOptions[0];
  }

  Future<void> _reloadViewModel() async {
    return await widget.viewModel.load(selectedLanguage ?? languageOptions[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        'Countries',
        ColorScheme.of(context).primaryContainer,
        ColorScheme.of(context).primary,
      ),
      backgroundColor: ColorScheme.of(context).primary,
      body: SafeArea(
        child: Column(
          spacing: 5.0,
          children: [
            buildCountriesDropDown(),
            Expanded(child: SizedBox(child: buildCountriesList())),
          ],
        ),
      ),
    );
  }

  // This method creates the dropdown for selecting the countries
  Container buildCountriesDropDown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorScheme.of(context).secondaryContainer,
          width: 3,
        ),
        color: ColorScheme.of(context).primaryContainer,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          items: languageOptions.map(buildMenuItem).toList(),
          onChanged: (value) => setState(() {
            selectedLanguage = value;
            _reloadViewModel();
          }),
          isExpanded: true,
          menuMaxHeight: 400,
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(value: item, child: Text(item));

  Widget buildCountriesList() {
    return Scrollbar(
      thumbVisibility: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, value) {
            return SuperListView.builder(
              itemCount: widget.viewModel.countries.length - 1,
              itemBuilder: (_, index) => CountryTile(
                key: ValueKey(widget.viewModel.countries[index].id),
                country: widget.viewModel.countries[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
