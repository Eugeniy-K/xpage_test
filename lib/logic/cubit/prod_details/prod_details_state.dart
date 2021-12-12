part of 'prod_details_cubit.dart';

abstract class ProdDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProdDetailsInitState extends ProdDetailsState {}

class ProdDetailsLoadState extends ProdDetailsState {}

class ProdDetailsFailureState extends ProdDetailsState {}

class ProdDetailsLoadedState extends ProdDetailsState {
  ProdDetailsLoadedState(
      {required this.productCardModel,
      required this.ingredientsForAdd,
      required this.offers,
      required this.price,
      required this.totalprice});

  final ProdDetailModel productCardModel;
  final List<IngredientsForAdd> ingredientsForAdd;
  final List<Offer> offers;
  final double price;
  final double totalprice;

  @override
  List<Object?> get props =>
      [productCardModel, ingredientsForAdd, offers, price, totalprice];
}
