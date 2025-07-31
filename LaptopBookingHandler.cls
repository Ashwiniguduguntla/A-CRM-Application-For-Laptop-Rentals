public class LaptopBookingHandler {
    public static void sendEmailNotification(List<Laptop_Bookings__c> lapList) {
        for (Laptop_Bookings__c lap : lapList) {
            if (String.isNotBlank(lap.Email__c)) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setToAddresses(new List<String>{lap.Email__c});
                email.setSubject('Welcome to our company');

                String body = 'Dear Customer, \n\n';
                body += 'Welcome to Laptop Rentals! You have been seen as a valuable customer to us.\n';
                body += 'Please continue your journey with us, while we try to provide you with good quality resources.\n\n';
                body += 'Laptop Amount = ' + lap.Amount__c + '\n';
                body += 'Core type = ' + lap.core_type__c + '\n';
                body += 'Laptop type = ' + lap.Laptop_Names__c;

                email.setPlainTextBody(body);
                Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
            }
        }
    }
}
