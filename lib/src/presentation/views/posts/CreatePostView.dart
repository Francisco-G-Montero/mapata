import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostBloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostEvent.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostState.dart';
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
    return BlocBuilder<CreatePostBloc, CreatePostState>(builder: (_, state) {
      if(state is CreatePostLoading) {
        _.read<CreatePostBloc>().add(RenderCreatePost());
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if(state is CreatePostDone) {
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