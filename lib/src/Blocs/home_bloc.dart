import 'dart:async';

import 'package:tyba/src/models/restaurante_model.dart';
import 'package:tyba/src/providers/restaurantes_providers.dart';

class HomeBloc {
  final restaurantesProviders = new RestaurantesProviders();

  static final HomeBloc _singleton = new HomeBloc._internal();

  factory HomeBloc() {
    return _singleton;
  }

  HomeBloc._internal() {}

  final _restauranteController =
      StreamController<List<RestaurantElement>>.broadcast();

  Stream<List<RestaurantElement>> get restauranteStream =>
      _restauranteController.stream;

  obtenerLista(String filter) async {
    _restauranteController.sink
        .add(await restaurantesProviders.getCitie(filter));
  }

  dispose() {
    _restauranteController?.close();
  }
}
