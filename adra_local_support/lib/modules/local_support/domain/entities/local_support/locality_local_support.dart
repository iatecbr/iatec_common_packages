import 'country_local_support.dart';

class LocalityLocalSupport {
  final int id;
  final CountryLocalSupport country;
  final String state;
  final String city;
  final String stateAcronym;

  LocalityLocalSupport(
    this.id,
    this.country,
    this.state,
    this.city,
    this.stateAcronym,
  );
}
