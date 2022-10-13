import 'package:flutter/material.dart';
import 'package:hospitoque/ui/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Text('Hospitoque'),
        ),
        Expanded(
          flex: 6,
          child: GridView.count(
            crossAxisCount: 2,
            children: _items()
                .map(
                  (i) => GestureDetector(
                    onTap: () {
                      if (i.isEnabled) {
                        Navigator.pushNamed(context, i.route!);
                      }
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            i.icon,
                          ),
                          Text(i.text),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
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
        route: HospitoqueRouter.SEARCH_MEDICINE_ROUTE,
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
  }) : assert(isEnabled && route != null);
}
