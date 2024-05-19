import 'package:flutter/material.dart';

// File 아이콘에 대한 클래스
class File extends StatelessWidget {
  final bool isSelectionMode;
  final int index;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const File({
    super.key,
    required this.isSelectionMode,
    required this.index,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.folder,
            size: MediaQuery.of(context).size.width * 0.2,
            color: Colors.blue,
          ),
        ),
        if (isSelectionMode)
          Positioned(
            bottom: 20,
            left: 25,
            child: Checkbox(
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color.fromARGB(255, 8, 12, 204);
                }
                return null;
              }),
              value: isSelected,
              onChanged: onChanged,
            ),
          ),
      ],
    );
  }
}
