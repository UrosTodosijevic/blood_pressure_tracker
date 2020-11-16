enum Order {
  ascending,
  descending,
}
// ignore: missing_return
String orderInStringFormat(Order order) {
  switch (order) {
    case Order.ascending:
      return 'Ascending';
    case Order.descending:
      return 'Descending';
  }
}
