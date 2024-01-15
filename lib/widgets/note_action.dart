import 'package:flutter/material.dart';
// a list of actions for popover for note edit and delete

class NoteAction extends StatelessWidget {
  final void Function()? onEditTap;
  final void Function()? onDeleteTap;
  const NoteAction({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //edit
        GestureDetector(
          onTap: (){
           Navigator.pop(context);
           onEditTap!();
          },
          child: Text("Edit"),
        ),

        //delete buttn
        GestureDetector(
         onTap: (){
           Navigator.pop(context);
            onDeleteTap!();
          },
          child: Text("Delete"),
        ),
      ],
    );
  }
}
