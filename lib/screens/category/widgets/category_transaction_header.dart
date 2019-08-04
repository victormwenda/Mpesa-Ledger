import 'package:flutter/material.dart';
import 'package:mpesa_ledger_flutter/models/category_model.dart';
import 'package:mpesa_ledger_flutter/widgets/chips/chip.dart';

class CategoryTransactionHeader extends StatelessWidget {
  Map<String, dynamic> totals;
  CategoryModel categoryModel;

  CategoryTransactionHeader(this.totals, this.categoryModel);

  List<Widget> _generateChips(List<String> listString) {
    List<Widget> chipList = [];
    for (var i = 0; i < listString.length; i++) {
      if (categoryModel.showKeywords) {
        chipList.add(
          ChipWidget(
            listString[i],
          ),
        );
        chipList.add(SizedBox(
          width: 10,
        ));
      }
    }
    return chipList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Total Deposits",
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "+KES " + totals["deposits"].toString(),
                style: Theme.of(context).textTheme.headline.merge(
                      TextStyle(
                        color: Color(0XFF4CAF50),
                      ),
                    ),
              ),
            ),
            Text(
              "Total Withdrawals",
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "-KES " + totals["withdrawals"].toString(),
                style: Theme.of(context).textTheme.headline.merge(
                      TextStyle(
                        color: Color(0XFFF44336),
                      ),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: RichText(
                text: TextSpan(
                  text: "-KES " + totals["transactionCosts"].toString(),
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(
                          color: Color(0XFFF44336),
                        ),
                      ),
                  children: [
                    TextSpan(
                      text: "  in transaction costs",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
            ),
            Text(
              "Description",
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              categoryModel.description,
              style: Theme.of(context).textTheme.body1,
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              children: _generateChips(categoryModel.keywords),
            )
          ],
        ),
      ),
    );
  }
}
