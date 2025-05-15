import 'package:example/pages/carts_page.dart';
import 'package:example/pages/products_page.dart';
import 'package:fake_store_package/fake_store_package.dart';
import 'package:fake_store_package/models/cart_model.dart';
import 'package:fake_store_package/models/product_model.dart';
import 'package:fake_store_package/util/failures.dart';
import 'package:fake_store_package/util/http_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  List<ProductModel>? products;
  List<CartModel>? carts;
  Failure? failure;
  final fakeStorePackage = FakeStorePackage(HttpHelper());

  @override
  void initState() {
    super.initState();
    getCarts();
  }

  Future<void> getProducts() async {
    if (products != null) return;
    final data = await fakeStorePackage.getProducts();
    data.fold(
      (failure) {
        setState(() {
          this.failure = failure;
        });
      },
      (products) {
        setState(() {
          this.products = products;
        });
      },
    );
  }

  Future<void> getCarts() async {
    if (carts != null) return;
    final data = await fakeStorePackage.getCarts();
    data.fold(
      (failure) {
        setState(() {
          this.failure = failure;
        });
      },
      (carts) {
        setState(() {
          this.carts = carts;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:
          currentIndex == 0
              ? CartsPage(carts: carts)
              : ProductsPage(products: products),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.primaries.first,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });

          if (currentIndex == 0) {
            getCarts();
          }
          if (currentIndex == 1) {
            getProducts();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Products'),
        ],
      ),
    );
  }
}
