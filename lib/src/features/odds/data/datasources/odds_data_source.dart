import 'package:dio/dio.dart';
import '../models/odds_model.dart';
import '../../../../core/api/dio_helper.dart';
import '../../../../core/api/endpoints.dart';

abstract class BettingOddsDataSource {
  Future<List<BettingOddsModel>> getOdds({
    required String date,
  });
}

class BettingOddsDataSourceImpl implements BettingOddsDataSource {
  final DioHelper dioHelper;

  BettingOddsDataSourceImpl({required this.dioHelper});

  @override
  Future<List<BettingOddsModel>> getOdds({required String date}) async {
    try {
      final response = await dioHelper.get(url: Endpoints.odds);
      return _getResult(response);
    } catch (error) {
      rethrow;
    }
  }

  List<BettingOddsModel> _getResult(Response response) {
    List<dynamic> result = response.data["response"];
    List<BettingOddsModel> odds = List<BettingOddsModel>.from(result.map(
      (odd) => BettingOddsModel.fromJson(odd),
    ));
    return odds;
  }
}
