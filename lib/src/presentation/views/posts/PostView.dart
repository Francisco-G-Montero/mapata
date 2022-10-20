import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapata/src/presentation/widgets/AppBarWidget.dart';
import '../../../data/model/Post.dart';
import '../../blocs/viewPost/PostBloc.dart';
import '../../blocs/viewPost/PostEvent.dart';
import '../../blocs/viewPost/PostState.dart';

class PostView extends StatelessWidget {
  final String postId;

  const PostView(this.postId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      appBar: AppBarWidget("Preston Smith", 55),

    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<PostBloc, PostState>(builder: (_, state) {
      if (state is PostLoading) {
        _.read<PostBloc>().add(RenderPost());
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is PostDone) {
        Post post = state.post;
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
                              "https://www.purina-latam.com/sites/g/files/auxxlc391/files/styles/kraken_generic_max_width_960/public/Purina%C2%AE%20Como%20disciplinar%20a%20tu%20gato.jpg?itok=Nxydhxbv"),
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
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10), //apply padding to all four sides
                          child: Text("Edad:",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        Padding(
                          padding: EdgeInsets.all(1), //apply padding to all four sides
                          child: Text("5 años"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20), //apply padding to all four sides
                          child: Text("Sexo:",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1), //apply padding to all four sides
                          child: Text("Macho Titan"),
                        ),
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10), //apply padding to all four sides
                        child: Text("Descripción: ",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                        Padding(
                          padding: EdgeInsets.all(1), //apply padding to all four sides
                          child: Text("Corre como locoooo"),
                        ),
                      ],
                    ),
                    Row(
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10), //apply padding to all four sides
                          child: Text("Fecha: ",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: EdgeInsets.all(1), //apply padding to all four sides
                          child: Text("09/12/2018"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        //Text in Button
                        TextButton(
                            onPressed: ()=>{},
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon( // <-- Icon
                                Icons.add_location,
                                size: 24.0,
                              ),
                              label: Text('Ver en google maps'), // <-- Text
                            ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  child: Text(" Lo encontré "),
                  style: TextButton.styleFrom(
                    primary: Colors.white,  //Text Color
                    backgroundColor: Colors.redAccent, //Button Background Color
                  ),
                  onPressed: () {},
                ),
              ],
            )
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
