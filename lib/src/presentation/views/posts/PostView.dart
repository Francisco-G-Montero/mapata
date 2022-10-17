import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mapata/src/data/util/ViewStates.dart';

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
    );
  }

  Widget _buildBody(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocBuilder<PostBloc, ViewStates>(builder: (_, state) {
      if(state is StateLoading) {
        _.read<PostBloc>().add(RenderPost());
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if(state is StatePostDataRetrieved) {
        Post post = state.post;
        return Container(
          color: Colors.white,
          child: Center(
            child: Text("Esta es la vista de Ver Post!\n Este post ID es: ${post.title}"),
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