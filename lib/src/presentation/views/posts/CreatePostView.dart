import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mapata/src/data/util/ViewStates.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostBloc.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostEvent.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapata/src/presentation/blocs/createPost/CreatePostState.dart';
import 'package:mapata/src/presentation/widgets/CustomButton.dart';
import 'dart:io';
import '../../../data/model/Post.dart';
import '../../navigation/PostViewArguments.dart';
import '../../widgets/AppBarWidget.dart';
import 'image_controller.dart'; // for File

class CreatePostView extends StatelessWidget {
  PostViewArguments _postViewArguments;
  bool isEditMode = false;

  CreatePostView(this._postViewArguments, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_postViewArguments.post == null) {
      _postViewArguments.post = Post.getBlankPost();
    } else {
      isEditMode = true;
    }

    final titleTextController = TextEditingController(text: isEditMode ? _postViewArguments.post!.title : "");
    final descriptionTextController =
        TextEditingController(text: isEditMode ? _postViewArguments.post!.description : "");

    var _genderValues = ["Femenino", "Maculino", "Desconocido"];
    var _gender = isEditMode ? _postViewArguments.post!.gender : "Femenino";

    var _ageValues = ["Joven", "Viejo"];
    var _ageValue = isEditMode ? _postViewArguments.post!.age : "Joven";

    var _stateValues = ["Transito", "Perdido"];
    var _stateValue = isEditMode ? _postViewArguments.post!.age : "Transito";



    //esto es para cargar el archivo que tiene los strings ↓ (dentro de data/utils/app_es)
    //luego actualizar el file acuerdense de correr "flutter gen-l10n"
    final locale = AppLocalizations.of(context)!;
    return BlocListener<CreatePostBloc, ViewStates>(listenWhen: ((previous, current) {
      return true;
    }), listener: (_, state) {
      if (state is StatePostCreated || state is StatePostEdited) {
        Navigator.pop(context);
        Navigator.pop(context, true);
        _.read<CreatePostBloc>().add(RenderCreatePost());
      }
    }, child: BlocBuilder<CreatePostBloc, ViewStates>(builder: (_, state) {
      if (state is StateLoading) {
        _.read<CreatePostBloc>().add(RenderCreatePost());
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is StateRenderView) {
        return Scaffold(
            appBar: AppBarWidget(isEditMode ? "Editar mascosta" : "Reportar mascosta", 55),
            body: GetBuilder<ImageController>(builder: (imageController) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: !isEditMode
                          ? GestureDetector(
                              child: const Text('Sacar una foto'),
                              onTap: () => imageController.pickImage(),
                            )
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: 250,
                          color: Colors.grey[300],
                          child: isEditMode
                              ? Image.network(_postViewArguments.post!.imageUrl)
                              : imageController.pickedFile != null
                                  ? Image.file(
                                      File(imageController.pickedFile!.path),
                                      width: 150,
                                      height: 250,
                                      fit: BoxFit.cover,
                                    )
                                  : const Text("Por favor, elige una imagen")),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nombre',
                        ),
                        controller: titleTextController,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                  hintText: 'Edad',
                                  border: OutlineInputBorder()),
                              child: DropdownButtonHideUnderline(
                                child: StatefulBuilder(
                                  builder: (context, setState) => Container(
                                    child: DropdownButton<String>(
                                      value: _ageValue,
                                      isDense: true,
                                      onChanged: (String? newValue) {
                                        _ageValue = newValue ?? "";
                                        setState(() {
                                          _ageValue;
                                        });
                                      },
                                      items: _ageValues.map((String value) {
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
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                                  hintText: 'Sexo',
                                  border: OutlineInputBorder()),
                              child: DropdownButtonHideUnderline(
                                  child: StatefulBuilder(
                                builder: (context, setState) => Container(
                                  child: DropdownButton<String>(
                                    value: _gender,
                                    isDense: true,
                                    onChanged: (String? newValue) {
                                      _gender = newValue ?? "";
                                      setState(() {
                                        _gender;
                                      });
                                    },
                                    items: _genderValues.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: InputDecorator(
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                            hintText: 'Estado',
                            border: OutlineInputBorder()),
                        child: DropdownButtonHideUnderline(
                          child: StatefulBuilder(
                            builder: (context, setState) => Container(
                              child: DropdownButton<String>(
                                value: _stateValue,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  _stateValue = newValue ?? "";
                                  setState(() {
                                    _stateValue;
                                  });
                                },
                                items: _stateValues.map((String value) {
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: descriptionTextController,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Descripción',
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(8),
                        child: Center(
                            child: isEditMode
                                ? CustomButton(() {
                              _postViewArguments.post!.title = titleTextController.text;
                              _postViewArguments.post!.description = descriptionTextController.text;
                              _postViewArguments.post!.age = _ageValue;
                              _postViewArguments.post!.gender = _gender;
                                    _.read<CreatePostBloc>().add(EditPostEvent(
                                        _postViewArguments.post!, PostStatus.LOST, _postViewArguments.marker!));
                                  }, Icons.edit, "Editar")
                                : CustomButton(() {
                                    Post post = Post.getBlankPost();
                                    post.title = titleTextController.text;
                                    post.description = descriptionTextController.text;
                                    post.age = _ageValue;
                                    post.gender = _gender;
                                    _.read<CreatePostBloc>().add(StartCreatePost(
                                        File(imageController.pickedFile!.path),
                                        post,
                                        PostStatus.LOST));
                                  }, Icons.add, "Publicar")))
                  ],
                ),
              );
            }));
      }
      return Container(
          child: Center(
        child: Text("Error"),
      ));
    }));
  }
}
