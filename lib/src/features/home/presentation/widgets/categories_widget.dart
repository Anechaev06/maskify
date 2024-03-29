import 'package:maskify/src/features/home/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/colors.dart';
import '../../../coin_tracking/data/repositories/coin_repository.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  CoinSortType _selectedSortType = CoinSortType.all;

  CoinRepository get coinRepository => Get.find<CoinRepository>();

  @override
  void initState() {
    super.initState();
    coinRepository.sortCoins(_selectedSortType);
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Assets",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SearchWidget(onSearch: (searchText) {
                coinRepository.searchCoins(searchText);
              }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButton("Popular", CoinSortType.all),
              _buildButton("Gainers", CoinSortType.topGainers),
              _buildButton("Losers", CoinSortType.topLosers),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String title, CoinSortType type) {
    final isSelected = _selectedSortType == type;
    return isSelected
        ? ElevatedButton(
            onPressed: () => _updateSortType(type),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: bgColor),
            ),
          )
        : OutlinedButton(
            onPressed: () => _updateSortType(type),
            style: OutlinedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
          );
  }

  void _updateSortType(CoinSortType type) {
    setState(() => _selectedSortType = type);
    coinRepository.sortCoins(type);
  }
}
