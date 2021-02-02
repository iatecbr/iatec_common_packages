import '../local_category.dart';
import 'locality_local_support.dart';

class LocalSupport {
  final int id;
  final String name;
  final LocalityLocalSupport locality;
  final LocalCategory category;
  final String address;
  final String complement;
  final String neighborhood;
  final String zipCode;
  final double latitude;
  final double longitude;
  final double distance;
  final bool isActive;

  LocalSupport(
    this.id,
    this.name,
    this.locality,
    this.category,
    this.address,
    this.complement,
    this.neighborhood,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.distance,
    this.isActive,
  );
}
