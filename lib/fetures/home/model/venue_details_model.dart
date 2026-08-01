class venue_Details_Model {
  bool? success;  String? message;
  Data? data;

  venue_Details_Model({this.success, this.message, this.data});

  venue_Details_Model.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  Location? location;
  String? sId;
  Owner? owner;
  String? name;
  String? coverImage;
  String? logo;
  String? description;
  String? addressLine1;
  String? city;
  int? eventsCount;
  int? programmesCount;
  int? totalRevenue;
  bool? isFavorited;

  Data.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    name = json['name'];
    coverImage = json['cover_image'];
    logo = json['logo'];
    description = json['description'];
    addressLine1 = json['address_line1'];
    city = json['city'];
    eventsCount = json['events_count'];
    programmesCount = json['programmes_count'];
    totalRevenue = json['total_revenue'];
    isFavorited = json['isFavorited'] ?? false;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['coordinates'] != null) {
      coordinates = (json['coordinates'] as List)
          .map((e) => double.parse(e.toString()))
          .toList();
    }
  }
}

class Owner {
  String? sId;
  String? name;
  String? image;

  Owner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }
}