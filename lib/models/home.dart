class Home {
  final String title;
  final String imagePath;

  Home({required this.title, required this.imagePath});
}

const String logoPath = 'assets/images/logo.png';
String clickedContent = "";
List<Home> homePageList = [
  Home(title: "el_wehda", imagePath: "assets/cuntry/el_wehda.jfif"),
  Home(title: "gaza", imagePath: "assets/cuntry/gaza.jpg"),
  Home(title: "Rimal", imagePath: "assets/cuntry/Image1.png"),
  Home(title: "metro", imagePath: "assets/cuntry/metro.jpg"),
  Home(title: "rafah", imagePath: "assets/cuntry/rafah.jpg"),
  Home(title: "Khan-youns", imagePath: "assets/cuntry/Khan-youns.jpg"),
  Home(title: "nosirat", imagePath: "assets/cuntry/nosirat.jpg"),
];
getContryLogoByTitle() {
  switch (clickedContent) {
    case "el_wehda":
      return "assets/cuntry/el_wehda.jfif";
    case "gaza":
      return "assets/cuntry/gaza.jpg";
    case "Rimal":
      return "assets/cuntry/Image1.png";
    case "metro":
      return "assets/cuntry/metro.jpg";
    case "rafah":
      return "assets/cuntry/rafah.jpg";
    case "Khan-youns":
      return "assets/cuntry/Khan-youns.jpg";
    case "nosirat":
      return "assets/cuntry/nosirat.jpg";
    default:
      return "assets/cuntry/nosirat.jpg";
  }
}

List<String> showData = [];
List<String> unitedStates = [
  "New York",
  "New Jersey",
  "Michigan",
  "Washington",
  "California",
  "Philadelphia",
  "Georgia",
  "Texas",
  "Massachusetts",
  "Florida",
  "Other States",
];

List<String> canada = [
  "Ontario",
  "British Columbia",
  "Alberta",
  "Nova Scotia",
  "Manitoba",
  "New Brunswick",
  "NewFoundland and  Labrador",
  "Prince Edward Island",
  "Saskatchewan",
  "Northwest Territories",
  "Nunavut",
  "Yukon",
  "Other States",
];

List<String> australia = [
  "New South Wales ",
  "Northern Territory",
  "Queensland",
  "South Australia ",
  "Tasmania ",
  "Victoria ",
  "Western Australia ",
  "Other States",
];

List<String> unitedKingdom = [
  "England",
  "Scotland",
  "Wales",
  "Northern Ireland",
  "Other States",
];

////////////////////////////////////////////////////
///
///
///

// united states

List<String> newYork = [
  "Queens",
  "Brooklyn",
  "Bronx",
  "Manhattan",
  "Staten Island",
  "Buffalo",
  "Other Cities",
];

List<String> newJersey = [
  "Jersey City",
  "Peterson",
  "Other Cities",
];

List<String> michigan = [
  "Detroit",
  "Other Cities",
];

List<String> washington = [
  "Seattle",
  "Other Cities",
];

List<String> california = [
  "San Francisco",
  "Los Angeles",
  "Other Cities",
];

List<String> philadelphia = [
  "Upper Darby",
  "Other Cities",
];

List<String> georgia = [
  "Georgia",
  "Atlanta",
  "Other Cities",
];

List<String> texas = [
  "Dallas",
  "Houston",
  "Austin",
  "Other Cities",
];

List<String> massachusetts = [
  "Boston",
  "Other Cities",
];

List<String> florida = [
  "Miami",
  "Other Cities",
];

// Canada

List<String> ontario = [
  "Toronto",
  "Ottawa",
  "Other Cities",
];

List<String> quebec = [
  "Quebec City",
  "Other Cities",
];
List<String> britishColumbia = [
  "Victoria",
  "Other Cities",
];

List<String> alberta = [
  "Edmonton",
  "Other Cities",
];

List<String> novaScotia = [
  "Halifax",
  "Other Cities",
];

List<String> manitoba = [
  "Winnipeg",
  "Other Cities",
];

List<String> newBrunswick = [
  "Fredericton",
  "Other Cities",
];

List<String> newFoundlandAndLabrador = [
  "St. John’s",
  "Other Cities",
];

List<String> princeEdwardIsland = [
  "Charlottetown",
  "Other Cities",
];

List<String> saskatchewan = [
  "Regina",
  "Other Cities",
];

List<String> northwestTerritories = [
  "Yellowknife",
  "Other Cities",
];

List<String> nunavut = [
  "Iqaluit",
  "Other Cities",
];

List<String> yukon = [
  "Whitehorse",
  "Other Cities",
];

// australia

List<String> newSouthWales = [
  "Sydney",
  "Other Cities",
];

List<String> northernTerritory = [
  "Darwin",
  "Other Cities",
];

List<String> queensland = [
  "Brisbane",
  "Other Cities",
];
List<String> southAustralia = [
  "Adelaide",
  "Other Cities",
];
List<String> tasmania = [
  "Hobart",
  "Other Cities",
];
List<String> victoria = [
  "Melbourne",
  "Other Cities",
];
List<String> westernAustralia = [
  "Perth",
  "Other Cities",
];

//united kingdom

List<String> england = [
  "London",
  "Other Cities",
];
List<String> scotland = [
  "Edinburgh",
  "Other Cities",
];
List<String> wales = [
  "Cardiff",
  "Other Cities",
];
