import 'package:flutter/material.dart';
import 'package:mvmm_test/data/services/model/country_model.dart';

class CountryTile extends StatelessWidget {
  const CountryTile({super.key, required this.country});

  final CountryApiModel country;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorScheme.of(context).primaryContainer,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text(
          country.engOfficialName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Courier',
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
        onTap: () {
          shopPopup(context);
        },
      ),
    );
  }

  void shopPopup(BuildContext context) {
    Color textColor = ColorScheme.of(context).onPrimaryContainer;
    textColor = Colors.blue.shade900;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          country.engOfficialName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.indigo.shade500,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 24.0,
        backgroundColor: ColorScheme.of(context).primaryContainer,
        content: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 2.0,
                children: [
                  Text(
                    'Common Name: ${country.engCommonName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: textColor),
                  ),
                  Text(
                    'Country Code (cca2): ${country.countryCode}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: textColor),
                  ),
                  Image.network(
                    country.imgLink,
                    width: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      print('Image not found: $stackTrace');
                      return Column(
                        children: [
                          Image.network(
                            'https://definicion.de/wp-content/uploads/2009/02/error.png', // In English, British Indian Ocean Territory doesn't work
                          ),
                        ],
                      );
                    },
                  ),
                  Text(
                    'Native Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.indigo.shade500,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Official: ${country.nativeOfficialName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, color: textColor),
                  ),
                  Text(
                    'Common: ${country.nativeCommonName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, color: textColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
