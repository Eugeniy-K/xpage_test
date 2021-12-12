import 'dart:ui';
import 'package:share/share.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpage_test/UI/product_detals/image_slider.dart';
import 'package:xpage_test/UI/product_detals/ingredients.dart';
import 'package:xpage_test/UI/product_detals/pizza_radius.dart';
import 'package:xpage_test/UI/widgets/custom_button.dart';
import 'package:xpage_test/UI/widgets/modal_dialog.dart';
import 'package:xpage_test/UI/widgets/product_card.dart';
import 'package:xpage_test/logic/cubit/prod_details/prod_details_cubit.dart';
import 'package:xpage_test/models/prod_detail_model.dart';
import 'package:xpage_test/tools/platform/src/platform_circluar_progress_indicator.dart';
import 'package:xpage_test/tools/platform/src/platform_icon_button.dart';
import 'package:xpage_test/tools/platform/src/platform_scaffold.dart';
import 'package:xpage_test/tools/platform/src/platform_text.dart';
import 'package:xpage_test/utils/constants.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double price = 0;
  double totalPrice = 0;

  @override
  void initState() {
    BlocProvider.of<ProdDetailsCubit>(context).getProdDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return PlatformScaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: BlocBuilder<ProdDetailsCubit, ProdDetailsState>(
          builder: (context, state) {
            if (state is ProdDetailsLoadedState) {
              this.price = state.price;
              this.totalPrice = state.totalprice;

              return Column(
                children: [
                  Stack(
                    children: [
                      _imageSlider(state.productCardModel.imagesList),
                      _upperButtons(width, state.productCardModel),
                    ],
                  ),
                  Container(
                    width: width,
                    // margin: EdgeInsets.only(top: height * 0.48),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: kBackgroundColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PlatformText(
                          state.productCardModel.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        PlatformText(
                            '${state.productCardModel.weight} г  /  ${state.productCardModel.calorie} кКал',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 10)),
                        const SizedBox(height: 16),
                        PlatformText(state.productCardModel.description,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12)),
                        const SizedBox(height: 12),
                        CustomButton(
                          type: ButtonType.Text,
                          textColor: kTextColor,
                          label: 'Убрать ингридиенты',
                          onPressed: (value, operation) {
                            showIngridientsModal(context,
                                items: state
                                    .productCardModel.ingredientsForDelete);
                          },
                        ),
                        const SizedBox(height: 12),

                        //Выбор размера пиццы
                        PizzaRadius(
                            // key: UniqueKey(),
                            offers: state.offers,
                            price: this.price,
                            callBack: (value) {
                              context
                                  .read<ProdDetailsCubit>()
                                  .selectRadius(value);
                              // print(price);
                            }),
                        const SizedBox(height: 22),
                        PlatformText('Добавить к товару',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                        const SizedBox(height: 22),

                        //Ингредиенты
                        Ingredients(
                          ingredientsForAdd: state.ingredientsForAdd,
                          callBack: (value, operation) {
                            context
                                .read<ProdDetailsCubit>()
                                .addRemoveIngredients(value, operation);
                          },
                        ),

                        const SizedBox(height: 28),
                        PlatformText('С этим товаром покупают',
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14)),
                        const SizedBox(height: 18),
                        //С этим товаром покупают
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              state.productCardModel.relatedProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 10,
                            childAspectRatio:
                                (MediaQuery.of(context).size.width / 2 - 21) /
                                    280,
                          ),
                          itemBuilder: (context, index) {
                            final relatedProducts =
                                state.productCardModel.relatedProducts[index];

                            return ProductCard(
                                urlImage: relatedProducts.picture.big,
                                title: relatedProducts.title,
                                description: relatedProducts.title,
                                price: price);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: PlatformText('Не удалось загрузить страницу'));
            }
          },
        ),
      )),
      material: (context, platform) => MaterialScaffoldData(
          bottomNavBar: BlocBuilder<ProdDetailsCubit, ProdDetailsState>(
        builder: (context, state) {
          if (state is ProdDetailsLoadedState) {
            return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
                color: kWhiteColor,
                child: CustomButton(
                  type: ButtonType.Default,
                  price: state.totalprice,
                ));
          } else {
            return const SizedBox();
          }
        },
      )),
    );
  }

  Positioned _upperButtons(double width, ProdDetailModel productCardModel) {
    bool isFavorites = productCardModel.inFavorites;
    return Positioned(
        top: 52,
        child: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kWhiteColor),
              child: PlatformIconButton(
                icon: SvgPicture.asset('assets/icons/arrow_left.svg'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              width: width * .7,
            ),
            Container(
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kWhiteColor),
              child: PlatformIconButton(
                icon: SvgPicture.asset(
                  'assets/icons/heart.svg',
                  color: isFavorites ? kTextColor : null,
                ),
                onPressed: () {
                  context.read<ProdDetailsCubit>().favoritesHandle();
                },
              ),
            ),
            const SizedBox(width: 15),
            Container(
              width: 30,
              height: 30,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kWhiteColor),
              child: PlatformIconButton(
                icon: SvgPicture.asset('assets/icons/share.svg'),
                onPressed: () {
                  Share.share(productCardModel.link);
                },
              ),
            ),
          ],
        ));
  }

  ImageSlider _imageSlider(List<ImagesList> imagesList) {
    List<String> images = imagesList.map((e) => e.big).toList();
    return ImageSlider(images: images);
  }
}
