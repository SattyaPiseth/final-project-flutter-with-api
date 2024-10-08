class ProductModel {
  int? status;
  String? message;
  String? messageKey;
  List<Data>? data;

  ProductModel({this.status, this.message, this.messageKey, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    messageKey = json['messageKey'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['messageKey'] = this.messageKey;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  int? id;
  String? uuid;
  String? createdAt;
  String? updatedAt;
  Category? category;
  String? image;
  String? description;

  Data(
      {this.name,
        this.id,
        this.uuid,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.image,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    uuid = json['uuid'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}

class Category {
  String? name;
  Parent? parent;
  int? id;
  String? uuid;

  Category({this.name, this.parent, this.id, this.uuid});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    parent =
    json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    id = json['id'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    data['id'] = this.id;
    data['uuid'] = this.uuid;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    return data;
  }
}
