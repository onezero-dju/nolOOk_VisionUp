import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nolook/Controller/directory_controller.dart';
import 'package:provider/provider.dart';

// Folder 아이콘에 대한 클래스
class Folder extends StatefulWidget {
  final bool isSelectionMode;
  final int index;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;
  final String directoryName;
  final int directoryId;

  const Folder({
    super.key,
    required this.isSelectionMode,
    required this.index,
    required this.isSelected,
    required this.onChanged,
    required this.directoryName,
    required this.directoryId,
  });

  @override
  _FolderState createState() => _FolderState();
}

class _FolderState extends State<Folder> {
  late TextEditingController _textController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.directoryName);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/Folder.svg',
                  width: 100,
                  height: 70,
                ),
                Text(widget.directoryName),
              ],
            ),
          ),
        ),
        if (widget.isSelectionMode)
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.03,
            left: MediaQuery.of(context).size.width * 0.06,
            child: Checkbox(
              value: widget.isSelected,
              onChanged: widget.onChanged,
            ),
          ),
      ],
    );
  }

  void _updateDirectoryName(BuildContext context, String newName) {
    final directoryController =
        Provider.of<DirectoryController>(context, listen: false);
    directoryController
        .directoryNameChange(widget.directoryId, newName)
        .then((_) {
      setState(() {
        _isEditing = false;
      });
    }).catchError((error) {
      // Handle error, e.g. show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to change directory name: $error')),
      );
    });
  }
}
