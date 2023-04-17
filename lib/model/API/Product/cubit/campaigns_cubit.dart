import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:stylish_flutter/model/API/Product/cubit/product_cubit.dart';
import '../product_object.dart';


class CampaignsCubit extends Cubit<FetchState> {
  
  CampaignsCubit() : super(FetchInitialState()) {

    fetchCampaigns();
  }

  Future<void> fetchCampaigns() async {

    try {

      emit(FetchLoadingState());

      final campaignsData = await getCampaignsData();

      emit(FetchSuccessState(campaignsData));

    } catch (error) {

      emit(FetchErrorState(error.toString()));
    }    
  }

  Future<List<Campaign>> getCampaignsData() async {

    final List<Campaign> result = [];

    try { 
      final response = await Dio().get('https://api.appworks-school.tw/api/1.0/marketing/campaigns');
      // print(response.data['data']);

      final data = Campaigns.fromJson(response.data);

      result.addAll(data.campaigns);

    } catch (error) {
      // 處理錯誤
      throw Exception(error.toString());
    }

    return result;
  }
}
