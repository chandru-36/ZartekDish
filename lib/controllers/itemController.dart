import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:zartekdish/models/itemModel.dart';

class ItemService extends GetxService {
  final dio = Dio();
  RxList<ItemModel> itemData = <ItemModel>[].obs;
  RxBool Loading = true.obs;
  RxBool Error = false.obs;
  RxList cartDishes = <CategoryDish>[].obs;
  RxList cartTotalItems = <String>[].obs;
  RxInt dishItemCounts = 0.obs;

  double getTotal() {
    double num = 0;
    for (var item in cartDishes) {
      num = num + item.count! * item.dishPrice;
    }
    return num;
  }

  placeOrders() {
    dishItemCounts.value = 0;
    cartTotalItems.clear();
    cartDishes.clear();
  }

  addCart(CategoryDish item) {
    item.count = item.count! + 1;

    dishItemCounts++;
    if (!cartTotalItems.contains(item.dishId)) {
      cartTotalItems.add(item.dishId);
      cartDishes.value.add(item);
    }
    itemData.refresh();
  }

  removeCart(CategoryDish item) {
    if (item.count != 0) {
      item.count = item.count! - 1;

      if (item.count == 0) {
        cartTotalItems.remove(item.dishId);
        cartDishes.value.remove(item);
      }
      dishItemCounts--;
      itemData.refresh();
    }
  }

  Future<void> fetchApi() async {
    try {
      Loading.value = true;
      final response = await dio.get(
        "https://run.mocky.io/v3/7e05b7d7-5391-4a61-b47c-c30b3fdcfcff",
      );
      if (response.statusCode == 200) {
        print(response);
        final data = itemModelFromJson(jsonEncode(response.data));

        itemData.value = data;
        Loading.value = false;
        print(itemData.value);
      } else {
        Loading.value = false;
        Error.value = true;
      }
    } catch (e) {
      Error.value = true;
      print(e);
    }
  }
}
