# A-CRM-Application-For-Laptop-Rentals
CRM application for managing laptop rentals built using Salesforce (Flows, Apex, Reports, Dashboards)
# 1. Setup Roles & Users

Create Role: Owner

Setup → Roles → Expand All → Add Role under CEO → Label = Owner.

Create Role: Agent

# Add 2 roles under Owner → Label = Agent.

Create Users

User 1: Vicky Y → Role = Owner → Profile = Owner.

User 2: Ram Ram → Role = Agent → Profile = Agent.

# 2. Create Custom Objects & Fields

Objects: Laptop__c, Laptop_Booking__c, Billing_Process__c.

Fields:

Laptop → Name, Core Type (i3, i5, i7), Price, Quantity.

Booking → Customer, Laptop, Months, Amount.

Billing → Payment Mode, Booking reference.

# 3. Build Flows (Automation)

# Flow 1: Laptop Booking

Type: Record-Triggered Flow on Laptop_Booking__c.

Trigger: When created/updated.

Decision: Check Laptop Brand (Dell, Acer, HP, Mac).

Sub-Decisions: Core Type (i3, i5, i7).

Further Decisions: Months (1–5).

Action: Update Amount__c field based on Laptop + Core + Months.

Example: Dell i3 → 1 month = 1000, 2 months = 2000, etc.

Acer i3 → 1 month = 900, etc.

HP i5 → 1 month = 1700, etc.

Mac (Bionic) → 1 month = 1700, etc.

Save & Activate: Flow Name = Laptop Distributions.

# 4. Apex Development

# Trigger:

trigger LaptopBooking on Laptop_Bookings__c (after insert, after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        LaptopBookingHandler.sendEmailNotification(Trigger.new);
    }
}


# Handler Class:

public class LaptopBookingHandler {
    public static void sendEmailNotification(List<Laptop_Bookings__c> lapList) {
        for(Laptop_Bookings__c lap : lapList) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{lap.Email__c});
            email.setSubject('Welcome to Laptop Rentals');
            String body = 'Dear Customer,\n' +
                          'Thank you for booking with us.\n' +
                          'Laptop: ' + lap.Laptop_name__c +
                          '\nCore: ' + lap.Core_type__c +
                          '\nAmount: ' + lap.Amount__c;
            email.setPlainTextBody(body);
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
        }
    }
}

# 5. Create Reports

Add sample records: Dell (i3, i7), Acer (i3), HP (i5), Mac (Bionic).

Create Report → Type = Consumer with Laptop Bookings and Total Laptops.

Add fields: Amount, Core Type, Laptop Name.

Group by: Laptop Type.

Save & Run Report.

# 6. Create Dashboards

Dashboard Folder: Total Rent Amount.

Dashboard: Add Component → Use Report.

Show revenue & bookings summary.

Subscribe Owner to receive daily emails.

# ✅ End Result:

Owner can see daily reports and dashboards.

Agents can create bookings and customers.

Automation calculates rent & sends confirmation emails.

Business gets full visibility of laptop rentals.
## 🎥 Project Demo Video

[Click here to watch the video on OneDrive](https://1drv.ms/v/c/c818c6e560802203/ES6Vfqn6RPtHuf98dCJx2ToBELwGoMX5n6XVwvNDUXAuDA?e=ecpfxe)

