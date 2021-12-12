import 'package:dio/dio.dart';
import 'package:xpage_test/models/prod_detail_model.dart';
import 'package:xpage_test/tools/dio_client.dart';
import 'package:xpage_test/utils/constants.dart';

class DataRepository {
  late DioClient dioClient;

  DataRepository() {
    var dio = Dio();
    this.dioClient = DioClient(devUrl, dio);
  }

  Future<ProdDetailModel?> fetchData() async {
    try {
      final response = await this.dioClient.get(devUrl);
      final model = ProdDetailModel.fromJson(response);
      // print(response);
      // print(model.id.toString());
      return model;
    } catch (e) {
      print(e.toString());
    }
  }
}
