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

  static List<ProductEntity> getFackMenProductList() {

    return getMapProductAPIData(mockMenProductAPIData);
  }

  static List<ProductEntity> getFackWomenProductList() {

    return getMapProductAPIData(mockWomenProductAPIData);
  }

  static List<ProductEntity> getFackAccessoriesProductList() {

    return getMapProductAPIData(mockAccessoriesAPIData);
  }

  static List<ProductEntity> getMapProductAPIData(String stringData) {

    final dynamic data = json.decode(stringData);

    final products = List<ProductEntity>.from(
        data['products'].map((product) => ProductEntity.fromJson(product)));

    return products;
  }

  static const mockMenProductAPIData = '''
  {"products": [{"id": 1234, "category": "男裝", "title": "厚實毛呢格子外套", "description": "高抗寒素材選用，保暖也時尚有型", "price": 2200, "texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455", 
              "size":"M","stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}], 
              "main_image":"https://api.appworks-school.tw/assets/201902191210/main.jpg","images": ["https://api.appworks-school.tw/assets/201807201824/0.jpg", 
              "https://api.appworks-school.tw/assets/201807201824/1.jpg", "https://api.appworks-school.tw/assets/201807201824/0.jpg",
               "https://api.appworks-school.tw/assets/201807201824/1.jpg"]},
              {"id": 5678, "category": "男裝", "title": "厚實毛呢格子外套", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201902191210/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]}]
  }
  ''';

  static const mockWomenProductAPIData = '''
  {"products": [{"id": 1234, "category": "女裝", "title": "前開衩扭結洋裝", "description": "厚薄: 薄\\r\\n彈性: 無", "price": 2200, "texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455", 
              "size":"M","stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}], 
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg","images": ["https://api.appworks-school.tw/assets/201807201824/0.jpg", 
              "https://api.appworks-school.tw/assets/201807201824/1.jpg", "https://api.appworks-school.tw/assets/201807201824/0.jpg",
               "https://api.appworks-school.tw/assets/201807201824/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]}]
  }
  ''';

static const mockAccessoriesAPIData = """
  {"products": [{"id": 1234, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型", "price": 2200, "texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455", 
              "size":"M","stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}], 
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg","images": ["https://api.appworks-school.tw/assets/201807201824/0.jpg", 
              "https://api.appworks-school.tw/assets/201807201824/1.jpg", "https://api.appworks-school.tw/assets/201807201824/0.jpg",
               "https://api.appworks-school.tw/assets/201807201824/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]}]
  }
  """;
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