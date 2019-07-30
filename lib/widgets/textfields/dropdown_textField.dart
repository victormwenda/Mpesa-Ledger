import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/blocs/dropdown_bloc/dropdown_bloc.dart';

class DropdownTextfieldWidget extends StatefulWidget {
  String label;
  List<String> items;

  DropdownTextfieldWidget(this.label, this.items);
  DropdownBloc _dropdownBloc = DropdownBloc();

  @override
  _DropdownTextfieldWidgetState createState() =>
      _DropdownTextfieldWidgetState();
}

class _DropdownTextfieldWidgetState extends State<DropdownTextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InputDecorator(
        isEmpty: widget.items.isEmpty,
        decoration: InputDecoration(
          filled: false,
          labelText: widget.label,
          contentPadding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
          border: OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: StreamBuilder(
            stream: widget._dropdownBloc.dropdownStream,
            initialData: null,
            builder: (context, snapshot) {
              return DropdownButton(
                value: snapshot.data,
                onChanged: (item) {
                  widget._dropdownBloc.dropdownSink.add(item);
                },
                items: widget.items.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              );
            }
          ),
        ),
      ),
    );
  }
}
