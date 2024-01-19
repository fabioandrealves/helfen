// class TextFormSearchText extends StatefulWidget {
//   final AppThemes theme;
//
//   TextFormSearchText({Key? key, required this.theme}) : super(key: key);
//
//   @override
//   _TextFormSearchTextState createState() => _TextFormSearchTextState();
// }
//
// class _TextFormSearchTextState extends State<TextFormSearchText> {
//   late TextEditingController searchController;
//
//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final decoration =
//         AppDecoration.of(widget.theme.themeProvider, widget.theme.seedColor);
//     final locationSearch =
//         Provider.of<LocationSearchProvider>(context, listen: false);
//
//     return TextFormField(
//       autofocus: true,
//       decoration: decoration.defaultDecoration,
//       controller: locationSearch.searchController,
//       onChanged: (searchText) {
//         locationSearch.searchLocations(searchText);
//       },
//     );
//   }
// }
