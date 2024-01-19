import 'results_model/geometry.dart';
import 'results_model/opening_hours.dart';
import 'results_model/photo.dart';
import 'results_model/plus_code.dart';

class Result {
  String? name;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  List<Photos>? photos;
  String? placeId;
  String? reference;
  String? scope;
  List<String>? types;
  String? vicinity;
  String? businessStatus;
  OpeningHours? openingHours;
  PlusCode? plusCode;
  dynamic rating;
  int? userRatingsTotal;

  Result(
      {this.name,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.iconBackgroundColor,
      this.iconMaskBaseUri,
      this.photos,
      this.placeId,
      this.reference,
      this.scope,
      this.types,
      this.vicinity,
      this.businessStatus,
      this.openingHours,
      this.plusCode,
      this.rating,
      this.userRatingsTotal});

  Result.fromJson(Map<String, dynamic> json) {
    geometry = (json['geometry'] != null
        ? Geometry.fromJson(json['geometry'])
        : null)!;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    reference = json['reference'];
    scope = json['scope'];
    types = json['types'].cast<String>();
    vicinity = json['vicinity'];
    businessStatus = json['business_status'];
    formattedAddress = json['formatted_address'];
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    rating = json['rating'];
    userRatingsTotal = json['user_ratings_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['geometry'] = geometry!.toJson();
    data['icon'] = icon;
    data['icon_background_color'] = iconBackgroundColor;
    data['icon_mask_base_uri'] = iconMaskBaseUri;
    data['name'] = name;
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = placeId;
    data['reference'] = reference;
    data['scope'] = scope;
    data['types'] = types;
    data['vicinity'] = vicinity;
    data['business_status'] = businessStatus;
    data['formatted_address'] = formattedAddress;
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.toJson();
    }
    if (plusCode != null) {
      data['plus_code'] = plusCode!.toJson();
    }
    data['rating'] = rating;
    data['user_ratings_total'] = userRatingsTotal;
    return data;
  }
}
