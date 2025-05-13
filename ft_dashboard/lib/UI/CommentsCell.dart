import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ft_dashboard/bloc/general_status_bloc.dart';
import 'package:ft_dashboard/bloc/states/general_status_state.dart';
import 'package:ft_dashboard/model/view_type.dart';

class CommentsCell extends StatelessWidget {
  const CommentsCell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralStatusBloc, GeneralStatusState>(
        builder: (context, state) {
      List<Widget>? convertedComments25 = state.comments25
          ?.map((comment) => commentaryWidget(comment))
          .toList();
      print("here in comment cell: $convertedComments25");
      List<Widget>? convertedComments26 = state.comments26
          ?.map((comment) => commentaryWidget(comment))
          .toList();

      Widget commentsWidget = Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Comente os principais aspectos positivos da disciplina:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: convertedComments25 ?? [],
              ),
              const SizedBox(
                height: 60.0,
              ),
              const Text(
                "Indique algumas sugestões para a melhoria da disciplina:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: convertedComments26 ?? [],
              ),
            ],
          ),
        ),
      );

      final value = (state.currentView == ViewType.subject)
          ? commentsWidget
          : const SizedBox();

      return value;
    });
  }
}

Widget commentaryWidget(String commentText) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 20,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Text(
                commentText.trim(),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
      const Divider(),
    ],
  );
}
