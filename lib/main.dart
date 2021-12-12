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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: SizedBox(
        height: 300,
        child: ProductCard(
          urlImage: 'sfs',
          title: 'Кока кола 0.45',
          description: '0.5 газ. вода',
          price: 150,
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
