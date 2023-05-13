import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.saveFilters, this.currentFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegeterian = widget.currentFilters['vegeterian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget buildSwitchListTitle(bool filter, String text, Function func) {
    return SwitchListTile(
      value: filter,
      title: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
      onChanged: func,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Фильтры'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegeterian': _vegeterian,
              };

              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(10),
            child: Text(
              'Изменить фильтр блюд',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTitle(
                  _glutenFree,
                  'Без глютена',
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                buildSwitchListTitle(
                  _vegeterian,
                  'Только вегатерианские блюда',
                  (newValue) {
                    setState(() {
                      _vegeterian = newValue;
                    });
                  },
                ),
                buildSwitchListTitle(
                  _vegan,
                  'Только веганские',
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                ),
                buildSwitchListTitle(
                  _lactoseFree,
                  ' Без лактозы',
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
