import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/model/API/Product/product_object.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
part 'fetch_state.dart';


class ProductsCubit extends Cubit<FetchState> {

  ProductsCubit() : super(FetchInitialState()) {

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


class ProductCubit extends Cubit<FetchState> {

  final String id;

  ProductCubit({required this.id}) : super(FetchInitialState()) {

    fetchProduct(id);
  }

  Future<void> fetchProduct(String id) async {

    try {

      emit(FetchLoadingState());

      final productData = await getProductDataWith(id);

      emit(FetchSuccessState(productData));

    } catch (error) {

      emit(FetchErrorState(error.toString()));
    }    
  }

  Future<ProductEntity> getProductDataWith(String id) async {

    var url = Uri.parse('https://api.appworks-school.tw/api/1.0/products/details?id=$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // 處理成功的情況
      final jsonData = jsonDecode(response.body);
      final productData = ProductEntity.fromJson(jsonData['data']);

      return productData;

    } else {
      // 處理失敗的情況
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}