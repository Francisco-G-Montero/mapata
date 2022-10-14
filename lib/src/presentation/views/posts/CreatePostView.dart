import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostBloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostEvent.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/AppBarWidget.dart';

class CreatePostView extends StatelessWidget {
  const CreatePostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }


  Widget _buildBody(BuildContext context) {
    var _currencies = [
      "Femenino",
      "Maculino",
      "X"
    ];
    var _value = "Femenino";

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
      return Scaffold(

        appBar: AppBarWidget("Reportar mascosta", 55),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nombre',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Edad',
                ),
              ),
            ),
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),  child:InputDecorator(
            decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            hintText: 'Sexo',
            border: OutlineInputBorder()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _value,
                isDense: true,
                onChanged: (String? newValue) {
                print('First text field: ');

                },
                items: _currencies.map((String value) {
                return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
                );
                }).toList(),
              ),
            ),
      ),
      ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(

                maxLines: 8,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Descripción',


                ),
              ),
            ),
          ],

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