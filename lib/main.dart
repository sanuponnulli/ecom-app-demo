import 'dart:developer';

import 'package:assignmentecom/data/controller/deataprovider.dart';
import 'package:assignmentecom/data/repo/repo.dart';
import 'package:assignmentecom/data/service/client.dart';
import 'package:assignmentecom/firebase_options.dart';
import 'package:assignmentecom/models/fakedatamodel.dart';
import 'package:assignmentecom/ui/cart.dart';
import 'package:assignmentecom/ui/detailpage.dart';
import 'package:assignmentecom/ui/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  //initialisefirebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Hive.registerAdapter(FakeModelAdapter());
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FakeModelAdapter().typeId)) {
    Hive.registerAdapter(FakeModelAdapter());
  }
  if (!Hive.isAdapterRegistered(RatingAdapter().typeId)) {
    Hive.registerAdapter(RatingAdapter());
  }

  if (!Hive.isAdapterRegistered(CartItemAdapter().typeId)) {
    Hive.registerAdapter(CartItemAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<MyRepository>(
      create: (_) => MyRepository(
          httpClient: MyHttpClient(baseUrl: 'https://fakestoreapi.com')),
      child: Consumer<MyRepository>(
        builder: (context, repository, _) {
          return ChangeNotifierProvider<MyDataProvider>(
            create: (_) => MyDataProvider(repository: repository),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const AuthGate(),
            ),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // Get the instance of MyDataProvider

    WidgetsBinding.instance.addPostFrameCallback((_) {
      MyDataProvider myDataProvider =
          Provider.of<MyDataProvider>(context, listen: false);
      // Call fetchData
      myDataProvider.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: RefreshIndicator(
          onRefresh: () async {
            // log('Refreshed', name: 'Refresh');
            // Provider.of<MyDataProvider>(context, listen: false).fetchData();
          },
          child: ListView(
            children: const [SignOutButton()],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              child: const Icon(Icons.shopping_bag))
        ],
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<MyDataProvider>(builder: (context, data, _) {
              // log(data.data.length.toString());
              return data.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : data.data.isEmpty
                      ? const Text("No data found")
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                0.7, // Adjust the aspect ratio to increase the height
                          ),
                          itemCount: data.data.length,
                          itemBuilder: (context, index) {
                            final product = data.data[index];
                            return ProductCard(product: product);
                          },
                        );
            }),
          ),
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final FakeModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(fakeModel: product),
          ),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  product.image ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    maxLines: 3,
                    style: const TextStyle(
                      overflow: TextOverflow.fade,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '\$${product.price?.toStringAsFixed(2) ?? ''}',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0.0)),
                    onPressed: () {
                      Provider.of<MyDataProvider>(context, listen: false)
                          .saveToCart(product, 1);
                      // Add your add to cart logic here
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
