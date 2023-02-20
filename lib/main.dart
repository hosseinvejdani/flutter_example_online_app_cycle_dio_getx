import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/controller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => Get.to(() => ProductsScreen()),
          child: const Text('Products'),
        ),
      ),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  final appController = Get.put(AppController());

  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Obx(() {
        switch (appController.status) {
          case AppControllerStatus.loading:
            return _loadingWidget();
          case AppControllerStatus.loaded:
            return _loadedWidget();
          case AppControllerStatus.error:
            return _errorWidget();
          default: // AppControllerStatus.initial
            return _initWidget();
        }
      }),
    );
  }

  Widget _initWidget() => const SizedBox();

  Widget _errorWidget() => const Center(child: Text('Error fetching products'));

  Widget _loadingWidget() => const Center(child: CircularProgressIndicator());

  Widget _loadedWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: () => appController.refetchProducts(),
            icon: const Icon(Icons.refresh),
            label: const Text('REFRESH'),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: appController.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(appController.products[index]['title']),
                subtitle: Text(appController.products[index]['description']),
              );
            },
          ),
        ),
      ],
    );
  }
}
