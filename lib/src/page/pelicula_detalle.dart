import 'package:flutter/material.dart';
import 'package:i_movie/src/models/actores_model.dart';
import 'package:i_movie/src/models/pelicula_model.dart';
import 'package:i_movie/src/providers/pelicula_provider.dart';

class PeliculaDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula, context),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 20.0,
              ),
              _posterTitulo(pelicula, context),
              _descripcion(pelicula, context),
              SizedBox(height: 50.0),
              _crearCasting(pelicula)
            ]),
          )
        ],
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula, BuildContext context) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 250,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            color: Colors.black26,
            child: Text(
              pelicula.title,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(microseconds: 1000),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Icon(Icons.star_border_outlined),
                    Text(pelicula.voteAverage.toString())
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        pelicula.overview,
        style: TextStyle(color: Colors.black, fontSize: 16.0),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
        child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image: NetworkImage(actor.getFoto()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          actor.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
  }
}
