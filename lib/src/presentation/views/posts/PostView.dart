import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapata/src/data/util/Constants.dart';
import 'package:mapata/src/presentation/widgets/AppBarWidget.dart';
import 'package:mapata/src/data/util/ViewStates.dart';
import '../../../data/model/Post.dart';
import '../../blocs/createPost/CreatePostBloc.dart';
import '../../blocs/createPost/CreatePostEvent.dart';
import '../../blocs/home/HomeBloc.dart';
import '../../blocs/home/HomeEvent.dart';
import '../../blocs/viewPost/PostBloc.dart';
import '../../blocs/viewPost/PostEvent.dart';
import '../../blocs/viewPost/PostState.dart';
import '../../navigation/PostViewArguments.dart';
import 'package:intl/intl.dart';

class PostView extends StatefulWidget {
  PostViewArguments _postViewArguments;

  PostView(this._postViewArguments);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(widget._postViewArguments.marker!.title, 55),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<PostBloc, ViewStates>(
      listenWhen: ((previous, current) {
        return true;
      }),
      listener: (_, state) {
        if (state is RestartPost) {
          _.read<PostBloc>().add(RenderPost(widget._postViewArguments.postId!));
        }
        if (state is StatePostDeleted) {
          Navigator.pop(context);
          context.read<HomeBloc>().add(ReloadMarkers());
        }
      },
      child: BlocBuilder<PostBloc, ViewStates>(builder: (_, state) {
        if (state is StateLoading) {
          _.read<PostBloc>().add(RenderPost(widget._postViewArguments.postId!));
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is StatePostDataRetrieved) {
          Post post = state.post;
          widget._postViewArguments.post = post;

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
                            image: NetworkImage(post.imageUrl),
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
                  height: 240,
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 30, 3.0, 4.0),
                            //apply padding to all four sides
                            child: Text(
                              "Edad:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(1, 30, 3.0, 4.0),
                            //apply padding to all four sides
                            child: Text(post.age),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 30, 3.0, 4.0),
                            //apply padding to all four sides
                            child: Text(
                              "Sexo:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(1, 30, 3.0, 4.0),
                            //apply padding to all four sides
                            child: Text(post.gender),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 3.0, 4.0),
                            //apply padding to all four sides
                            child: Text(
                              "Descripci??n: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(1, 20, 3.0, 4.0),
                            //apply padding to all four sides
                            child: SizedBox(
                              width: 200,
                              child: Text(
                                post.description,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 20, 3.0, 4.0),
                            //apply padding to all four sides
                            child: Text(
                              "Fecha: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(1, 20, 3.0, 4.0),
                            //apply padding to all four sides
                            child: Text(
                              DateFormat('dd/MM/yyyy KK:mm:ss a').format(post.date.toLocal()),
                            ),
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
                              backgroundColor: Colors.teal, //Button Background Color
                            ),
                            onPressed: () {
                              context.read<CreatePostBloc>().add(RenderCreatePost());
                              Navigator.pushNamed(context, kRouteCreatePost,
                                  arguments: widget._postViewArguments);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 60, 3.0, 4.0),
                          ),
                          TextButton(
                            child: Text("Eliminar"),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white, //Text Color
                              backgroundColor: Colors.redAccent, //Button Background Color
                            ),
                            onPressed: () {
                              context.read<PostBloc>().add(DeletePost(widget._postViewArguments.post!, widget._postViewArguments.marker!));
                            },
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
      }),
    );
  }
}
