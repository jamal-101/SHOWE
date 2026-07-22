// class TheatreItem {
//   final String title;
//   final String description;
//   final String imageAsset;
//
//   TheatreItem({
//     required this.title,
//     required this.description,
//     required this.imageAsset,
//   });
// }
//
// class CategoryModel {
//   final String name;
//   final String backgroundAsset;
//
//   CategoryModel({
//     required this.name,
//     required this.backgroundAsset,
//   });
// }

class ProgrammeModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<ProgrammeData>? data;

  ProgrammeModel({this.success, this.message, this.pagination, this.data});

  ProgrammeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
    if (json['data'] != null) {
      data = <ProgrammeData>[];
      json['data'].forEach((v) {
        data!.add(ProgrammeData.fromJson(v));
      });
    }
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
}

class ProgrammeData {
  String? sId;
  String? title;
  String? coverImage;
  String? description;

  ProgrammeData({this.sId, this.title, this.coverImage, this.description});

  ProgrammeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    coverImage = json['cover_image'];
    description = json['description'] ?? "No description available";
  }
}

class CategoryModel {
  final String name;
  final String backgroundAsset;
  final String apiValue;

  CategoryModel({required this.name, required this.backgroundAsset, required this.apiValue});
}