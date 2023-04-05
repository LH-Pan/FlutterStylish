import 'dart:convert';

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
      description: json['description'],
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

    return getMockProductAPIData(mockMenProductAPIData);
  }

  static List<ProductEntity> getFackWomenProductList() {

    return getMockProductAPIData(mockWomenProductAPIData);
    // return getProducList(9, '女裝', '原石原石原石原石原石原石', 510, [
    //   'images/genshin5.jpeg',
    //   'images/genshin4.jpeg',
    //   'images/genshin3.jpeg',
    //   'images/genshin2.jpeg',
    //   'images/genshin1.jpeg'
    // ]);
  }

  static List<ProductEntity> getFackAccessoriesProductList() {

    return getMockProductAPIData(mockAccessoriesAPIData);
    
    // return getProducList(12, '配件', '原石原石原石原石原石原石原石原石原石', 3290, [
    //   'images/genshin2.jpeg',
    //   'images/genshin3.jpeg',
    //   'images/genshin5.jpeg',
    //   'images/genshin4.jpeg',
    //   'images/genshin1.jpeg'
    // ]);
  }

  static List<ProductEntity> getProducList(int times, String category,
      String title, int price, List<String> images) {
    return List.generate(
        times,
        (index) => ProductEntity(
            id: 0,
            category: category,
            title: title,
            description: '',
            price: price,
            texture: '',
            wash: '',
            place: '',
            note: '',
            story: '',
            colors: [],
            sizes: [],
            variants: [],
            mainImage: '',
            images: images));
  }

  static List<ProductEntity> getMockProductAPIData(String mockData) {
    final data = json.decode(mockData);

    final products = List<ProductEntity>.from(
        data['products'].map((product) => ProductEntity.fromJson(product)));

    return products;
  }

  static const mockMenProductAPIData = '''
  {"products": [{"id": 1234, "category": "男裝", "title": "厚實毛呢格子外套", "description": "高抗寒素材選用，保暖也時尚有型", "price": 2200, "texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455", 
              "size":"M","stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}], 
              "main_image":"https://stylish.com/main.jpg","images": ["https://api.appworks-school.tw/assets/201807201824/0.jpg", 
              "https://api.appworks-school.tw/assets/201807201824/1.jpg", "https://api.appworks-school.tw/assets/201807201824/0.jpg",
               "https://api.appworks-school.tw/assets/201807201824/1.jpg"]},
              {"id": 5678, "category": "男裝", "title": "厚實毛呢格子外套", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://stylish.com/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]}]
  }
  ''';

  static const mockWomenProductAPIData = '''
  {"products": [{"id": 1234, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型", "price": 2200, "texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455", 
              "size":"M","stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}], 
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg","images": ["https://api.appworks-school.tw/assets/201807201824/0.jpg", 
              "https://api.appworks-school.tw/assets/201807201824/1.jpg", "https://api.appworks-school.tw/assets/201807201824/0.jpg",
               "https://api.appworks-school.tw/assets/201807201824/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]}]
  }
  ''';

static const mockAccessoriesAPIData = '''
  {"products": [{"id": 1234, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型", "price": 2200, "texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455", 
              "size":"M","stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}], 
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg","images": ["https://api.appworks-school.tw/assets/201807201824/0.jpg", 
              "https://api.appworks-school.tw/assets/201807201824/1.jpg", "https://api.appworks-school.tw/assets/201807201824/0.jpg",
               "https://api.appworks-school.tw/assets/201807201824/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]},
              {"id": 5678, "category": "女裝", "title": "前開衩扭結洋裝", "description": "高抗寒素材選用，保暖也時尚有型","price": 2200,"texture": "棉、聚脂纖維",
              "wash": "手洗(水溫40度", "place": "韓國", "note": "實品顏色以單品照為主", "story": "你絕對不能錯過的超值商品", "colors": [{"code":"334455", "name":"深藍"},
              {"code":"FFFFFF", "name":"白色"}], "sizes": ["S", "M"], "variants":[{"color_code":"334455", "size":"S", "stock":5}, {"color_code":"334455",
              "size":"M", "stock":10}, {"color_code":"FFFFFF", "size":"S", "stock":0}, {"color_code":"FFFFFF", "size":"M", "stock":2}],
              "main_image":"https://api.appworks-school.tw/assets/201807201824/main.jpg", "images": ["https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg", "https://api.appworks-school.tw/assets/201902191210/0.jpg", 
              "https://api.appworks-school.tw/assets/201902191210/1.jpg"]}]
  }
  ''';
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
