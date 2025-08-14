
// avoid typo
enum TextSizes { small, medium, large }
enum ProductType { single, variable }
enum OrderStatus {
  pending,     // Awaiting provider acceptance
  accepted,    // Provider accepted the job
  inProgress,  // Provider is on the way or currently working
  completed,   // Job is completed
  cancelled,   // Job is cancelled by user or provider (later)
}
enum PaymentMethods { paypal, googlePay, applePay, visa, masterCard, creditCard, paystack, razorPay, paytm }

