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

        final restauran = snapshot.data;

        /* if (restauran) {
          return Center(
            child: Text('No hay informacion'),
          );
        } */

        return ListView.builder(
            // itemCount: restauran.length,
            itemBuilder: (context, i) => Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                // onDismissed: (direction) => scansBloc.borraScan(scan[i].id),
                child: ListTile(
                  leading: Icon(Icons.cloud_queue,
                      color: Theme.of(context).primaryColor),
                  // title: Text(scan[i].valor),
                  // subtitle: Text('ID: ${scan[i].id}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                )));
      },
    );
  }
}
