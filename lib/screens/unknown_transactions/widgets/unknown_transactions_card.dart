import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/utils/string_utils/replace.dart';
import 'package:mpesa_ledger_flutter/widgets/cards/card.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/dropdown_textField.dart';
import 'package:mpesa_ledger_flutter/widgets/textfields/textfield.dart';

class UnknownTransactionsCard extends StatelessWidget {
  ReplaceUtil replaceUtil = ReplaceUtil();
  TextEditingController title = TextEditingController();

  Map<String, dynamic> unknownTransaction;

  UnknownTransactionsCard(this.unknownTransaction);

  _generateChips(List<double> listDouble) {
    List<Widget> chipLists = [];
    chipLists.add(ChipWidget("None"));
    chipLists.add(SizedBox(width: 7));
    for (var i = 0; i < listDouble.length; i++) {
      chipLists.add(ChipWidget(listDouble[i].toString()));
      chipLists.add(SizedBox(width: 7));
    }
    return chipLists;
  }

  @override
  Widget build(BuildContext context) {
    return CardWidget(Column(
      children: <Widget>[
        CardWidget(
          Text(
            replaceUtil.replaceString(
                unknownTransaction["body"], "\\{.*\\}", ""),
            style: Theme.of(context).textTheme.body1.merge(TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor)),
          ),
          color: Theme.of(context).accentColor,
          margin: 0,
        ),
        SizedBox(
          height: 7,
        ),
        Divider(
          color: Colors.black54,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _generateChips(unknownTransaction["amounts"]),
            ),
          ),
        ),
        TextFieldWidget(
          "Title",
          title,
        ),
        SizedBox(height: 10,),
        DropdownTextfieldWidget("Category", ["1", "2", "3"])
      ],
    ));
  }
}
