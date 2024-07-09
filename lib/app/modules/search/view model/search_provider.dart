import 'package:flutter/material.dart';
import 'package:zoco/app/backend/urls.dart';

import '../../../backend/server_client_services.dart';
import '../../../utils/enums.dart';
import '../../sections and details/model/get_secdtion_homescreen_model.dart';
import '../model/search_model.dart';

class SearchProvider extends ChangeNotifier {
  /*............. Serch api ............. */
  SerchModel searchModel = SerchModel();
  List<Product> searchDataList = <Product>[];

  SerchStatus serchStatus = SerchStatus.initial;
  Future getSerchProductFnc(
      {String? categoryid,
      String? subCategoryid,
      String? brandId,
      required String query}) async {
    serchStatus = SerchStatus.loading;

    try {
      if (query.isEmpty) {
        searchDataList.clear();
        serchStatus = SerchStatus.error;
      } else {
        searchDataList.clear();
        List response = await ServerClient.get(
            '${Urls.searchUrl}section=$categoryid&subCategory=$subCategoryid&brand=$brandId&keyword=$query');
        if (response.first >= 200 && response.first < 300) {
          searchModel = SerchModel.fromJson(response.last);
          searchDataList.addAll(searchModel.products ?? []);
        } else {
          serchStatus = SerchStatus.error;
          searchDataList = <Product>[];
          searchModel = SerchModel();
        }
      }
    } catch (e) {
      serchStatus = SerchStatus.error;
      searchModel = SerchModel();
      searchDataList = <Product>[];
    } finally {
      serchStatus = SerchStatus.loaded;
      notifyListeners();
    }
  }
}
