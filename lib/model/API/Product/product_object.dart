class ProductEntity {
  int? id;
  String category;
  String title;
  String? description;
  double price;
  String? texture;
  String? wash;
  String? place;
  String? note;
  String? story;
  List<ColorEntity>? colors;
  List<String>? sizes;
  List<VariantEntity>? variants;
  String? mainImage;
  List<String>? images;

  ProductEntity({
    this.id,
    required this.category,
    required this.title,
    this.description,
    required this.price,
    this.texture,
    this.wash,
    this.place,
    this.note,
    this.story,
    this.colors,
    this.sizes,
    this.variants,
    this.mainImage,
    this.images,
  });

  static List<ProductEntity> getFackMenProductList() {

    return getProducList(5, '男裝', '原石原石原石', 170);
  }

  static List<ProductEntity> getFackWomenProductList() {

    return getProducList(7, '女裝', '原石原石原石原石原石原石', 510);
  }

  static List<ProductEntity> getFackAccessoriesProductList() {

    return getProducList(9, '配件', '原石原石原石原石原石原石原石原石原石', 3290);
  }


  static List<ProductEntity> getProducList(int times, String category, String title, double price) {

    return List.generate(times, (index) => ProductEntity(category: category, title: title, price: price));
  }
}

class ColorEntity {
  String name;
  String code;

  ColorEntity({
    required this.name,
    required this.code,
  });
}

class VariantEntity {
  String size;
  int stock;

  VariantEntity({
    required this.size,
    required this.stock,
  });
}