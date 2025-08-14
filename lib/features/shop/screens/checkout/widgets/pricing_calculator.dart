class CPricingCalculator {
  // Calculate fee based on subtotal (15%)
  static double calculateTax(double subTotal) {
    double taxRate = 0.15; // 15% fee
    double taxAmount = subTotal * taxRate;
    return double.parse(taxAmount.toStringAsFixed(2));
  }

  // Calculate total price based on tax
  static double calculateTotalPrice(double subTotal) {
    double tax = calculateTax(subTotal);
    double totalPrice = subTotal + tax;
    return totalPrice;
  }
}
