import 'package:flutter/material.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/hospitoque_decorations.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(3)),
          child: const Expanded(
            child: _ItemsWidget(),
          ),
        ),
      ),
    );
  }
}

class _ItemsWidget extends StatelessWidget {
  const _ItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 12,
          child: GridView.count(
            childAspectRatio: _itemAspectRatio(context),
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: context.isLargeWidth ? 4 : 2,
            children: _items()
                .map(
                  (i) => GestureDetector(
                    onTap: () {
                      if (i.isEnabled) {
                        Navigator.pushNamed(context, i.route!);
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(context.layoutWidth(3)),
                      decoration: HospitoqueDecorations.roundedBorder(
                        context,
                        color: i.isEnabled
                            ? null
                            : Theme.of(context).disabledColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            i.icon,
                            size: context.layoutHeight(8),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.layoutWidth(6)),
                            child: Text(
                              i.text,
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }

  double _itemAspectRatio(BuildContext c) {
    if (c.isLargeWidth) {
      return 11 / 10;
    }
    return 6 / 5;
  }
}

// Check witch items are enabled
List<_MainScreenItem> _items() => [
      _MainScreenItem(
        text: Constants.SEARCH_MEDICINE,
        icon: Icons.search,
        isEnabled: true,
        route: HospitoqueRouter.SEARCH_MEDICINE_ROUTE,
      ),
      _MainScreenItem(
        text: Constants.LIST_MEDICINE,
        icon: Icons.list,
        isEnabled: true,
        route: HospitoqueRouter.LIST_MEDICINE_ROUTE,
      ),
      _MainScreenItem(
        text: Constants.REGISTER_CHECK_OUT,
        icon: Icons.upload_outlined,
        isEnabled: false,
      ),
      _MainScreenItem(
        text: Constants.REGISTER_CHECK_IN,
        icon: Icons.download_outlined,
        isEnabled: false,
      ),
      _MainScreenItem(
        text: Constants.CONFIRM_CHECK_IN,
        icon: Icons.check_circle_outline,
        isEnabled: false,
      ),
      _MainScreenItem(
        text: Constants.REGISTER_MEDICINE,
        icon: Icons.add,
        isEnabled: true,
        route: HospitoqueRouter.REGISTER_MEDICINE_ROUTE,
      ),
      _MainScreenItem(
        text: Constants.DISCARD_MEDICINE,
        icon: Icons.delete_outline,
        isEnabled: true,
        route: HospitoqueRouter.DISCARD_MEDICINE_ROUTE,
      ),
      _MainScreenItem(
        text: Constants.EDIT_MEDICINE,
        icon: Icons.edit,
        isEnabled: false,
      ),
    ];

class _MainScreenItem {
  final String text;
  final IconData icon;
  final String? route;
  final bool isEnabled;

  _MainScreenItem({
    required this.text,
    required this.icon,
    this.route,
    required this.isEnabled,
  });
}
