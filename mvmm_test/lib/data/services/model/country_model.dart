class CountryApiModel {
  final String engCommonName;
  final String engOfficialName;

  //Native is in the official language of the nation
  final String nativeCommonName;
  final String nativeOfficialName;

  final String countryCode; //the cca2
  final int id;

  final String imgLink;

  const CountryApiModel({
    required this.engCommonName,
    required this.engOfficialName,
    required this.nativeCommonName,
    required this.nativeOfficialName,
    required this.countryCode,
    required this.imgLink,
    required this.id,
  });

  factory CountryApiModel.fromJSON(
    Map<String, dynamic> json,
    int id,
    String language,
  ) {
    Map<String, dynamic> jsonName = json['name'];
    String cca2 = json['cca2'];

    String languageCode = language.substring(0, 3);
    String imgLink = 'https://flagsapi.com/$cca2/flat/64.png';

    Map<String, dynamic> jsonNative = jsonName['nativeName'];

    jsonNative = jsonNative[languageCode] ?? jsonNative[jsonNative.keys.first];

    return switch (jsonName) {
      {'common': String eng_common, 'official': String eng_official} =>
        CountryApiModel(
          engCommonName: eng_common,
          engOfficialName: eng_official,
          nativeCommonName: jsonNative['common'],
          nativeOfficialName: jsonNative['official'],
          countryCode: cca2,
          imgLink: imgLink,
          id: id,
        ),
      _ => throw const FormatException('Failed to load country data.'),
    };
  }

  @override
  String toString() {
    String text =
        "Common Name (English): $engCommonName\nOfficial Name (English): $engOfficialName\n";
    text +=
        "Common Name (Native): $nativeCommonName\nOfficial Name (Native): $nativeOfficialName\n";
    text += "Country Code (cca2): $countryCode\n";
    text += "Image Link: $imgLink\nid: $id\n";
    return text;
  }
}
