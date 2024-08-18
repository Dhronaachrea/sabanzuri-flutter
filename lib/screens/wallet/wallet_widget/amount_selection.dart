part of 'wallet_widget.dart';

class AmountSelection extends StatefulWidget {
  final TextEditingController amountController;
  final VoidCallback? selectAmount;
  final bool isDarkThemeOn;

  const AmountSelection(
      {Key? key,
      required this.amountController,
      this.selectAmount,
      required this.isDarkThemeOn})
      : super(key: key);

  @override
  State<AmountSelection> createState() => _AmountSelectionState();
}

class _AmountSelectionState extends State<AmountSelection> {
  List<String> amount = ["60", "90", "120", "150", "Others"];
  int? selectedIndex = 0;

  @override
  void initState() {
    widget.amountController.text = "60";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: amount.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              if (index == amount.length - 1) {
                widget.amountController.text = '';
              } else {
                widget.amountController.text = amount[index].toString();
              }
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: SabanzuriColors.warm_grey_two,
                  width: 1,
                ),
                color: selectedIndex == index
                    ? SabanzuriColors.warm_grey_two
                    : null,
              ),
              child: Center(
                child: Text(
                  amount[index].toString(),
                  style: TextStyle(
                    color: widget.isDarkThemeOn || selectedIndex == index
                        ? SabanzuriColors.white_two
                        : SabanzuriColors.warm_grey_two,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Arial",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
