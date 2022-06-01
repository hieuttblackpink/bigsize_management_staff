import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SearchBar(),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: true,
      onChanged: (value) {},
      decoration: const InputDecoration(
        constraints: BoxConstraints(maxHeight: 70, maxWidth: 305),
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(12, 2, 10, 10),
        fillColor: Colors.white,
        hintText: 'Search for the course here ',
        hintStyle: TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
