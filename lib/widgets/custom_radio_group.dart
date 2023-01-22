import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';

class Option {
  Option({ required this.text, this.value });
  final String text;
  final value;
}

class CustomRadioGroup extends StatefulWidget {
  const CustomRadioGroup({ super.key, this.labelText, required this.items, required this.onChanged });

  final String? labelText;
  final List<Option?> items;
  final Function(Option?) onChanged;

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {

  int _selected = -1; 

  Widget get _label {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8, bottom: 4),
          child: Text(
            widget.labelText ?? '',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _customRadio(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          var isSelected = index != _selected;
          widget.onChanged(isSelected ? widget.items[index] : null);
          _selected = isSelected ? index : -1;
        });
      },
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: index == _selected ? FontWeight.w600 : FontWeight.w400,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        backgroundColor: index == _selected ? primaryColor : Colors.transparent,
        foregroundColor: index == _selected ? Colors.white : const Color(0xFF777777),
        side: BorderSide(
          color: index == _selected ? primaryColor : const Color(0xFF777777),
        ),
      ),
      child: Text(text),
    );
  }

  Widget getOptionsWidgets()
  {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      list.add(
        Container(
          padding: i > 0 ? const EdgeInsets.only(left: 4) : null,
          child: _customRadio(widget.items[i]?.text ?? '', i),
        ),
      );
    }
    return Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.labelText != null ? _label : Container(),
        getOptionsWidgets(),
      ],
    );
  }
}