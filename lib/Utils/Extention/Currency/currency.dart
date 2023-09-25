class CurrencyConverter {
  static String formatCurrency(double amount) {
    String formatted = amount.toStringAsFixed(2);
    String currencySymbol = 'Rp ';

    final parts = formatted.split('.');
    final intPart = parts[0].replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match.group(1)}.');
    final decimalPart = parts.length > 1 ? parts[1] : '00';

    return '$currencySymbol$intPart$decimalPart';
  }

  static double parseCurrency(String formatted) {
    try {
      final value = formatted
          .replaceAll(RegExp(r'[^\d]'), '')
          .replaceAll(RegExp(r'^0+(?!$)'), '');
      return double.parse(value) / 100;
    } catch (e) {
      return 0.0;
    }
  }
}
