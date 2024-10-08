class CategoryModel {
  String? name;
  Parent? parent;
  int? id;
  String? uuid;
  String? createdAt;
  String? updatedAt;
  String? description;
  String? images; // Changed to a single String field

  CategoryModel({
    this.name,
    this.parent,
    this.id,
    this.uuid,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.images, // Add it to the constructor
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    description = json['description'];
    images = json['images']; // Directly assign the String field
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['description'] = this.description;
    data['images'] = this.images; // Add images to JSON
    return data;
  }
}

class Parent {
  String? name;
  int? id;
  String? uuid;

  Parent({this.name, this.id, this.uuid});

  Parent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = this.name;
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    return data;
  }
}

class CategoryListModel {
  List<CategoryModel>? data;

  CategoryListModel({this.data});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryModel>[];
      json['data'].forEach((v) {
        data!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
