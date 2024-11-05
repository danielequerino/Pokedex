import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pokedex/dados/api-internet/ClienteApi.dart';

class ConfigureProviders {
  final List<SingleChildWidget> providers;

  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {
    // Instanciando o ClienteApi
    final clienteApi = ClienteApi(baseUrl: "http://192.168.1.104:3000");
    //final apiClient = ApiClient(baseUrl: "http://192.168.1.106:3000");

    return ConfigureProviders(providers: [
      Provider<ClienteApi>.value(value: clienteApi),
      ]);
  }
}
