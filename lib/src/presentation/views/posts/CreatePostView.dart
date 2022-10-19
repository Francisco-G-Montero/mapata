import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapata/src/data/util/ViewStates.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostBloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostEvent.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';
import '../../../data/model/Post.dart';
import '../../widgets/AppBarWidget.dart';
import 'image_controller.dart'; // for File

class CreatePostView extends StatelessWidget {
  final Post? post;

  const CreatePostView(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    var _currencies = ["Femenino", "Maculino", "Desconocido"];
    var _value = "Femenino";

    var _age = ["Joven", "Viejo"];
    var _valueAge = "Joven";

    //esto es para cargar el archivo que tiene los strings ↓ (dentro de data/utils/app_es)
    //luego actualizar el file acuerdense de correr "flutter gen-l10n"
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<CreatePostBloc, ViewStates>(builder: (_, state) {
      if (state is StateLoading) {
        _.read<CreatePostBloc>().add(RenderCreatePost());
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is StateRenderView) {
        return Scaffold(
            appBar: AppBarWidget("Reportar mascosta", 55),
            body: GetBuilder<ImageController>(builder: (imageController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: GestureDetector(
                      child: const Text('Sacar una foto'),
                      onTap: () => imageController.pickImage(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 250,
                        color: Colors.grey[300],
                        child: imageController.pickedFile != null
                            ? Image.file(
                                File(imageController.pickedFile!.path),
                                width: 150,
                                height: 250,
                                fit: BoxFit.cover,
                              )
                            : const Text("Por favor, elige una imagen")),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nombre',
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: InputDecorator(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Edad',
                                border: OutlineInputBorder()),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _valueAge,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  print('First text field: ');
                                },
                                items: _age.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: InputDecorator(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
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
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      maxLines: 8,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Descripción',
                      ),
                    ),
                  ),
                ],
              );
            }));
      }
      return Container(
          child: Center(
        child: Text("Error"),
      ));
    });
  }
}
