import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stylish_flutter/model/API/Product/product_object.dart';
import 'package:dio/dio.dart';
part 'fetch_state.dart';


class ProductCubit extends Cubit<FetchState> {

  ProductCubit() : super(FetchInitialState()) {

    fetchProducts();
  }

  Future<void> fetchProducts() async {

    try {

      emit(FetchLoadingState());

      final allProductsData = await getAllProductsData();

      emit(FetchSuccessState(allProductsData));

    } catch (error) {

      emit(FetchErrorState(error.toString()));
    }    
  }

  Future<List<ProductEntity>> getAllProductsData() async {

    final List<ProductEntity> result = [];

    int page = 0;
    while (true) {

      try {
        final response = await Dio().get('https://api.appworks-school.tw/api/1.0/products/all?paging=$page');
        final productsData = Products.fromJson(response.data);
        result.addAll(productsData.products);

        // 如果這個頁面已經是最後一頁，跳出循環
        if (productsData.products.isEmpty) { break; }

        // 繼續獲取下一個頁面的資料
        page++;

      } catch (error) {
        // 處理錯誤
        throw Exception(error.toString());
      }
    }
    return result;
  }
}