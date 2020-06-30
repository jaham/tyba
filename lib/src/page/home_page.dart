import 'package:flutter/material.dart';
import 'package:tyba/src/Blocs/home_bloc.dart';
import 'package:tyba/src/models/restaurante_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeBloc = HomeBloc();
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                /* bloc.changeEmail('');
              bloc.changePassword(''); */
                Navigator.pushReplacementNamed(context, 'login');
              },
            )
          ],
        ),
        body: Container(
          width: size.width * 0.85,
          child: Column(
            children: <Widget>[_createFiltro(homeBloc), createLista(homeBloc)],
          ),
        ));
  }

  Widget _createFiltro(HomeBloc bloc) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.location_city),
            hintText: 'Canada',
            labelText: 'Suidas',
          ),
          onChanged: (String s) {
            if (s.length > 3) {
              bloc.obtenerLista(s);
            }
          },
        ));
  }

  Widget createLista(HomeBloc homeBloc) {
    return StreamBuilder<List<RestaurantElement>>(
      stream: homeBloc.restauranteStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<RestaurantElement>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final List<RestaurantElement> restauran = snapshot.data;

        if (restauran.length == 0) {
          return Expanded(
            child: Center(
                child: Text(
              'No hay informacion',
              style: TextStyle(fontSize: 20.0),
            )),
          );
        }

        return Expanded(
            child: ListView.builder(
                itemCount: restauran.length,
                itemBuilder: (context, i) => ListTile(
                    leading: Icon(Icons.cake),
                    title: Text(restauran[i].restaurant.name))));
      },
    );
  }
}
