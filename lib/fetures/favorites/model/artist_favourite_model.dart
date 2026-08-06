// class artist_favourite {
//   bool? success;
//   String? message;
//   Pagination? pagination;
//   List<Data>? data;
//
//   artist_favourite({this.success, this.message, this.pagination, this.data});
//
//   artist_favourite.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     pagination = json['pagination'] != null
//         ? new Pagination.fromJson(json['pagination'])
//         : null;
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success'] = this.success;
//     data['message'] = this.message;
//     if (this.pagination != null) {
//       data['pagination'] = this.pagination!.toJson();
//     }
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Pagination {
//   int? total;
//   int? limit;
//   int? page;
//   int? totalPage;
//
//   Pagination({this.total, this.limit, this.page, this.totalPage});
//
//   Pagination.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     limit = json['limit'];
//     page = json['page'];
//     totalPage = json['totalPage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total'] = this.total;
//     data['limit'] = this.limit;
//     data['page'] = this.page;
//     data['totalPage'] = this.totalPage;
//     return data;
//   }
// }
//
// class Data {
//   String? sId;
//   String? name;
//   String? image;
//   String? coverImage;
//   String? shortDescription;
//   String? category;
//   String? type;
//   String? orgainzation;
//   List<String>? genres;
//   List<String>? instruments;
//   List<String>? languages;
//   int? careerStartYear;
//   String? origin;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   bool? isFavorited;
//
//   Data(
//       {this.sId,
//         this.name,
//         this.image,
//         this.coverImage,
//         this.shortDescription,
//         this.category,
//         this.type,
//         this.orgainzation,
//         this.genres,
//         this.instruments,
//         this.languages,
//         this.careerStartYear,
//         this.origin,
//         this.createdAt,
//         this.updatedAt,
//         this.iV,
//         this.isFavorited});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     image = json['image'];
//     coverImage = json['cover_image'];
//     shortDescription = json['short_description'];
//     category = json['category'];
//     type = json['type'];
//     orgainzation = json['orgainzation'];
//     genres = json['genres'].cast<String>();
//     instruments = json['instruments'].cast<String>();
//     languages = json['languages'].cast<String>();
//     careerStartYear = json['career_start_year'];
//     origin = json['origin'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     isFavorited = json['isFavorited'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['cover_image'] = this.coverImage;
//     data['short_description'] = this.shortDescription;
//     data['category'] = this.category;
//     data['type'] = this.type;
//     data['orgainzation'] = this.orgainzation;
//     data['genres'] = this.genres;
//     data['instruments'] = this.instruments;
//     data['languages'] = this.languages;
//     data['career_start_year'] = this.careerStartYear;
//     data['origin'] = this.origin;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     data['isFavorited'] = this.isFavorited;
//     return data;
//   }
// }

class artist_favourite {
  bool? success;
  String? message;
  Pagination? pagination;
  List<Data>? data;

  artist_favourite({this.success, this.message, this.pagination, this.data});

  artist_favourite.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? total;
  int? limit;
  int? page;
  int? totalPage;

  Pagination({this.total, this.limit, this.page, this.totalPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    page = json['page'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['limit'] = limit;
    data['page'] = page;
    data['totalPage'] = totalPage;
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? image;
  String? coverImage;
  String? shortDescription;
  String? category;
  String? type;
  String? orgainzation;
  List<String>? genres;
  List<String>? instruments;
  List<String>? languages;
  int? careerStartYear;
  String? origin;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isFavorited;

  Data({
    this.sId,
    this.name,
    this.image,
    this.coverImage,
    this.shortDescription,
    this.category,
    this.type,
    this.orgainzation,
    this.genres,
    this.instruments,
    this.languages,
    this.careerStartYear,
    this.origin,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.isFavorited,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? json['sId'];
    name = json['name'];
    image = json['image'];
    coverImage = json['cover_image'];
    shortDescription = json['short_description'];
    category = json['category'];
    type = json['type'];
    orgainzation = json['orgainzation'];

    // ✅ Safe List Parsing (Null & Type Crash Safe)
    if (json['genres'] != null) {
      genres = List<String>.from(json['genres'].map((x) => x.toString()));
    }
    if (json['instruments'] != null) {
      instruments = List<String>.from(json['instruments'].map((x) => x.toString()));
    }
    if (json['languages'] != null) {
      languages = List<String>.from(json['languages'].map((x) => x.toString()));
    }

    careerStartYear = json['career_start_year'];
    origin = json['origin'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isFavorited = json['isFavorited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['cover_image'] = coverImage;
    data['short_description'] = shortDescription;
    data['category'] = category;
    data['type'] = type;
    data['orgainzation'] = orgainzation;
    data['genres'] = genres;
    data['instruments'] = instruments;
    data['languages'] = languages;
    data['career_start_year'] = careerStartYear;
    data['origin'] = origin;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['isFavorited'] = isFavorited;
    return data;
  }
}