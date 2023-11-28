import 'package:flutter/material.dart';
import 'package:pharmacy/medicine/data/models/medicine_model.dart';

class MedicineSearchDelegate extends SearchDelegate<MedicineModel?> {
  final List<MedicineModel> medicines;

  MedicineSearchDelegate({required this.medicines});

  @override
  String get searchFieldLabel => 'Search Medicines';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Pass null only if the user cancels the search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<MedicineModel> suggestions = query.isEmpty
        ? []
        : medicines
            .where((medicine) => medicine.productName
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final MedicineModel medicine = suggestions[index];
        return ListTile(
          title: Text(medicine.productName),
          // Add other details if needed
          onTap: () {
            close(context, medicine);
          },
        );
      },
    );
  }
}