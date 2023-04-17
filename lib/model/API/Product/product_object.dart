import 'dart:convert';

class Campaigns {
  List<Campaign> campaigns;

  Campaigns({required this.campaigns});

  factory Campaigns.fromJson(Map<String, dynamic> json) {
    return Campaigns(
      campaigns: List<Campaign>.from(
        json['data'].map((campaignData) => Campaign.fromJson(campaignData))
      ),
    );
  }
}

class Campaign {
  int id;
  int productId;
  String picture;
  String story;

  Campaign({required this.id, required this.productId, required this.picture, required this.story});

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      productId: json['product_id'],
      picture: json['picture'],
      story: json['story'],
    );
  }
}

class Products {

  final String? title;

  final List<ProductEntity> products;

  Products({
    this.title,
    required this.products
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      title: json['title'] ?? '',
      products: (json['data'] as List<dynamic>)
          .map((productJson) => ProductEntity.fromJson(productJson))
          .toList()
    );
  }

  factory Products.fromProducts(Map<String, dynamic> json) {
    return Products(
      title: json['title'] ?? '',
      products: (json['products'] as List<dynamic>)
          .map((productJson) => ProductEntity.fromJson(productJson))
          .toList()
    );
  }
}

class ProductEntity {
  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final List<ColorEntity> colors;
  final List<String> sizes;
  final List<VariantEntity> variants;
  final String mainImage;
  final List<String> images;

  ProductEntity({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.colors,
    required this.sizes,
    required this.variants,
    required this.mainImage,
    required this.images,
  });

  factory ProductEntity.empty() {

    return ProductEntity(
      id: 0,
      category: '',
      title: '',
      description: '',
      price: 0,
      texture: '',
      wash: '',
      place: '',
      note: '',
      story: '', 
      colors: [],
      sizes: [],
      variants: [],
      mainImage: '',
      images: []
    );
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    
    return ProductEntity(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'] ,
      price: json['price'],
      texture: json['texture'],
      wash: json['wash'],
      place: json['place'],
      note: json['note'],
      story: json['story'],
      colors: (json['colors'] as List<dynamic>)
          .map((colorJson) => ColorEntity.fromJson(colorJson))
          .toList(),
      sizes: (json['sizes'] as List<dynamic>).cast<String>(),
      variants: (json['variants'] as List<dynamic>)
          .map((variantJson) => VariantEntity.fromJson(variantJson))
          .toList(),
      mainImage: json['main_image'],
      images: (json['images'] as List<dynamic>).cast<String>(),
    );
  }

  static List<ProductEntity> getMapProductAPIData(String stringData) {

    final dynamic data = json.decode(stringData);

    final products = List<ProductEntity>.from(
        data['products'].map((product) => ProductEntity.fromJson(product)));

    return products;
  }
}

class ColorEntity {
  String name;
  String code;

  ColorEntity({
    required this.name,
    required this.code,
  });

  factory ColorEntity.fromJson(Map<String, dynamic> json) {
    return ColorEntity(
      code: json['code'],
      name: json['name'],
    );
  }
}

class VariantEntity {
  String colorCode;
  String size;
  int stock;

  VariantEntity({
    required this.colorCode,
    required this.size,
    required this.stock,
  });

  factory VariantEntity.fromJson(Map<String, dynamic> json) {
    return VariantEntity(
      colorCode: json['color_code'],
      size: json['size'],
      stock: json['stock'],
    );
  }
}