import '../api/api_client.dart';

class RemoteServer {
  getProducts() async {
    return await AppApi().get('https://fakestoreapi.com/products');
  }
}
