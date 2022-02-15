import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpage_test/UI/product_detals/product_details.dart';
import 'package:xpage_test/UI/widgets/custom_button.dart';
import 'package:xpage_test/UI/widgets/product_card.dart';
import 'package:xpage_test/api/data_repository.dart';
import 'package:xpage_test/logic/cubit/prod_details/prod_details_cubit.dart';
import 'package:xpage_test/tools/platform/platform_widgets.dart';
import 'package:xpage_test/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dataRepository = DataRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ProdDetailsCubit(dataRepository: dataRepository))
      ],
      child: PlatformApp(
        title: 'Flutter Demo',
        material: (context, platform) => MaterialAppData(
          theme: materialTheme,
        ),
        cupertino: (context, platform) => CupertinoAppData(
          theme: cupertinoTheme,
        ),
        home: const ProductDetails(),
      ),
    );
  }
}
