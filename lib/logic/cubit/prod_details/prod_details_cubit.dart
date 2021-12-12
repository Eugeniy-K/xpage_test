import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpage_test/api/data_repository.dart';
import 'package:xpage_test/models/prod_detail_model.dart';

part 'prod_details_state.dart';

class ProdDetailsCubit extends Cubit<ProdDetailsState> {
  ProdDetailsCubit({required this.dataRepository})
      : super(ProdDetailsInitState());

  final DataRepository dataRepository;

  Future<void> getProdDetails() async {
    emit(ProdDetailsLoadState());

    var result = await this.dataRepository.fetchData();

    if (result != null) {
      emit(ProdDetailsLoadedState(
          productCardModel: result,
          ingredientsForAdd: result.ingredientsForAdd,
          offers: result.offers,
          price: result.price.toDouble(),
          totalprice: result.price.toDouble()));
    }
  }

//выбор размера пиццы
  Future selectRadius(double newPrice) async {
    final ProdDetailModel productCardModel =
        (state as ProdDetailsLoadedState).productCardModel;
    final List<IngredientsForAdd> ingredientsForAdd =
        (state as ProdDetailsLoadedState).ingredientsForAdd;
    final List<Offer> offers = (state as ProdDetailsLoadedState).offers;
    final double price = (state as ProdDetailsLoadedState).price;
    double totalprice = (state as ProdDetailsLoadedState).totalprice;

    totalprice = totalprice - price + newPrice;

    emit(ProdDetailsLoadedState(
        productCardModel: productCardModel,
        ingredientsForAdd: ingredientsForAdd,
        offers: offers,
        price: newPrice,
        totalprice: totalprice));
  }

//Добавление/удаление ингредиентов
  Future addRemoveIngredients(double newPrice, bool operation) async {
    final ProdDetailModel productCardModel =
        (state as ProdDetailsLoadedState).productCardModel;
    final List<IngredientsForAdd> ingredientsForAdd =
        (state as ProdDetailsLoadedState).ingredientsForAdd;
    final List<Offer> offers = (state as ProdDetailsLoadedState).offers;
    final double price = (state as ProdDetailsLoadedState).price;
    double totalprice = (state as ProdDetailsLoadedState).totalprice;

    if (operation)
      totalprice = totalprice + newPrice;
    else
      totalprice = totalprice - newPrice;

    emit(ProdDetailsLoadedState(
        productCardModel: productCardModel,
        ingredientsForAdd: ingredientsForAdd,
        offers: offers,
        price: price,
        totalprice: totalprice));
  }

//Добавление в избранное
  Future favoritesHandle() async {
    bool isFavorites =
        (state as ProdDetailsLoadedState).productCardModel.inFavorites;
    final ProdDetailModel productCardModel = (state as ProdDetailsLoadedState)
        .productCardModel
        .copyWith(inFavorites: !isFavorites);
    final List<IngredientsForAdd> ingredientsForAdd =
        (state as ProdDetailsLoadedState).ingredientsForAdd;
    final List<Offer> offers = (state as ProdDetailsLoadedState).offers;
    final double price = (state as ProdDetailsLoadedState).price;
    double totalprice = (state as ProdDetailsLoadedState).totalprice;

    emit(ProdDetailsLoadedState(
        productCardModel: productCardModel,
        ingredientsForAdd: ingredientsForAdd,
        offers: offers,
        price: price,
        totalprice: totalprice));
  }
}
