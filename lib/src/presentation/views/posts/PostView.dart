import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapata/src/data/util/Constants.dart';
import 'package:mapata/src/presentation/widgets/AppBarWidget.dart';
import 'package:mapata/src/data/util/ViewStates.dart';
import '../../../data/model/Post.dart';
import '../../blocs/viewPost/PostBloc.dart';
import '../../blocs/viewPost/PostEvent.dart';
import '../../blocs/viewPost/PostState.dart';
import '../../navigation/PostViewArguments.dart';

class PostView extends StatefulWidget {
  PostViewArguments _postViewArguments;

  PostView(this._postViewArguments);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {

  String appBarTitle = "Preston Smith";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      appBar: AppBarWidget(appBarTitle, 55),
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<PostBloc, ViewStates>(builder: (_, state) {
      if (state is StateLoading) {
        _.read<PostBloc>().add(RenderPost(widget._postViewArguments.postId!));
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is StatePostDataRetrieved) {
        Post post = state.post;
        widget._postViewArguments.post = post;
        appBarTitle = post.title;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 300,
              child: Card(
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(30),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              post.imageUrl),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Card(
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(30),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: 400,
                height: 200,
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(
                              10), //apply padding to all four sides
                          child: Text(
                            "Edad:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              1), //apply padding to all four sides
                          child: Text(post.age),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              20), //apply padding to all four sides
                          child: Text(
                            "Sexo:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              1), //apply padding to all four sides
                          child: Text(post.gender),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(
                              10), //apply padding to all four sides
                          child: Text(
                            "Descripción: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              1), //apply padding to all four sides
                          child: Text(post.description),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(
                              10), //apply padding to all four sides
                          child: Text(
                            "Fecha: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              1), //apply padding to all four sides
                          child: Text(post.date.toLocal().toString()),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Text in Button
                        TextButton(
                          child: Text("Editar"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, //Text Color
                            backgroundColor:
                                Colors.teal, //Button Background Color
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, kRouteCreatePost,
                                arguments: widget._postViewArguments);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.all(1),
                        ),
                        TextButton(
                          child: Text("Eliminar"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white, //Text Color
                            backgroundColor:
                                Colors.redAccent, //Button Background Color
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }

      return Container(
          child: Center(
        child: Text("Error"),
      ));
    });
  }
}
