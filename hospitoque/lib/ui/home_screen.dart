import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(3)),
          child: Column(
            children: [
              const Spacer(flex: 1),
              Flexible(
                flex: 3,
                child: Text(
                  'Hospitoque',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Spacer(flex: 1),
              const Expanded(
                flex: 28,
                child: _ItemsWidget(),
              ),
            ],
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
    return GridView.count(
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.layoutWidth(3)),
                  color: i.isEnabled ? null : Theme.of(context).disabledColor,
                  border: Border.all(
                    color: Theme.of(context).highlightColor,
                    width: 1,
                  ),
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
    );
  }

  double _itemAspectRatio(BuildContext c) {
    if(c.isLargeWidth) {
      return 11 / 10;
    }
    return 6 / 5;
  }
}

// Check witch items are enabled
List<_MainScreenItem> _items() => [
      _MainScreenItem(
        text: 'Buscar Medicamento',
        icon: Icons.search,
        isEnabled: true,
        route: HospitoqueRouter.SEARCH_MEDICINE_ROUTE,
      ),
      _MainScreenItem(
        text: 'Listar Medicamentos',
        icon: Icons.list,
        isEnabled: true,
        route: HospitoqueRouter.LIST_MEDICINES_ROUTE,
      ),
      _MainScreenItem(
        text: 'Registrar Saída',
        icon: Icons.upload_outlined,
        isEnabled: false,
      ),
      _MainScreenItem(
        text: 'Registrar Entrada',
        icon: Icons.download_outlined,
        isEnabled: true,
        route: HospitoqueRouter.REGISTER_MEDICINE_CHECK_IN_ROUTE,
      ),
      _MainScreenItem(
        text: 'Confirmar Entrada',
        icon: Icons.check_circle_outline,
        isEnabled: false,
      ),
      _MainScreenItem(
        text: 'Cadastrar Medicamento',
        icon: Icons.add,
        isEnabled: true,
        route: HospitoqueRouter.REGISTER_MEDICINE_ROUTE,
      ),
      _MainScreenItem(
        text: 'Descartar Medicamento',
        icon: Icons.delete_outline,
        isEnabled: true,
        route: HospitoqueRouter.DISCARD_MEDICINE_ROUTE,
      ),
      _MainScreenItem(
        text: 'Editar Medicamento',
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
