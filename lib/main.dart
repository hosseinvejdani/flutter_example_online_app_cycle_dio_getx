import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

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
          onPressed: () => Get.to(MyWidget()),
          child: const Text('Data'),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final appController = Get.put(AppController());

  MyWidget({super.key});

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

  Center _initWidget() => const Center(child: Text('Please Wait!'));

  Center _errorWidget() => const Center(child: Text('Error fetching products'));

  Center _loadingWidget() => const Center(child: CircularProgressIndicator());

  Column _loadedWidget() {
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
