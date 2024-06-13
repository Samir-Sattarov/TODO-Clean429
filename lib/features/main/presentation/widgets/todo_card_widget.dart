import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/todo_entity.dart';
import '../cubits/delete_todo/delete_todo_cubit.dart';
import '../screens/edit_todo_screen.dart';

class TodoCardWidget extends StatefulWidget {
  final TodoEntity entity;
  final Color? backgroundColor;
  final Function()? onDone;
  final bool isMenuActive;
  const TodoCardWidget({
    super.key,
    required this.entity,
    this.isMenuActive = true,
    this.onDone,
    this.backgroundColor,
  });

  @override
  State<TodoCardWidget> createState() => _TodoCardWidgetState();
}

class _TodoCardWidgetState extends State<TodoCardWidget> {
  bool isMenuOpen = false;
  bool isDone = false;

  // late TodoStorageService storageService;

  @override
  void initState() {
    // storageService = locator();

    isDone = widget.entity.isDone;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TodoCardWidget oldWidget) {
    if (oldWidget.entity.isDone != widget.entity.isDone) {
      isDone = widget.entity.isDone;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.isMenuActive) {
              setState(() => isMenuOpen = !isMenuOpen);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  (isDone ? Colors.blueGrey.shade700 : Colors.white),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.entity.title,
                        style: TextStyle(
                          color: isDone ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => widget.onDone?.call(),
                      icon: Icon(
                        isDone
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: isDone ? Colors.white : Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  widget.entity.description,
                  style: TextStyle(
                    color: isDone ? Colors.white : Colors.grey.shade500,
                    fontSize: 14,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat("dd-MM-yyyy hh:mm")
                          .format(widget.entity.createdAt),
                      style: TextStyle(
                        color: isDone ? Colors.white : Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (isMenuOpen) const SizedBox(height: 5),
        if (isMenuOpen)
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: widget.entity.isDone
                  ? Colors.blueGrey.shade700
                  : Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Column(
              children: [
                _menuItem(
                    title: 'Edit',
                    icon: Icons.edit,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditTodoScreen(
                            entity: widget.entity,
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                _menuItem(
                  title: 'Delete',
                  icon: Icons.delete,
                  onTap: () {
                    BlocProvider.of<DeleteTodoCubit>(context)
                        .delete(widget.entity);
                  },
                ),
              ],
            ),
          ),
        if (isMenuOpen) const SizedBox(height: 20),
      ],
    );
  }

  _menuItem({
    required String title,
    required IconData icon,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: () {
        isMenuOpen = false;

        setState(() {});
        onTap.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              title,
            ),
          ],
        ),
      ),
    );
  }
}
