import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/PostBloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/PostEvent.dart';
import 'package:mapata/src/presentation/blocs/createPost/PostState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    //esto es para cargar el archivo que tiene los strings ↓ (dentro de data/utils/app_es)
    //luego actualizar el file acuerdense de correr "flutter gen-l10n"
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<PostBloc, PostState>(builder: (_, state) {
      if(state is PostLoading) {
        _.read<PostBloc>().add(RenderPost());
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if(state is PostDone) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Text("Publicación view cargada!"),
          ),
        );
      }
      return Container(
          child: Center(
          child: Text("Error"),)
      );
    });
  }

}