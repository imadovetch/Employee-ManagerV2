package utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class Mailling {

    public static void sendMail(String to, String content) {
        // Sender's email credentials
        String from = "ibouderoua63@gmail.com";
        String host = "smtp.gmail.com";

        // Set system properties
        Properties properties = System.getProperties();

        // Setup mail server properties
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465"); // Use port 465 for SSL or 587 for TLS
        properties.put("mail.smtp.ssl.enable", "true"); // Enable SSL
        properties.put("mail.smtp.auth", "true"); // Enable authentication

        // Get the Session object and authenticate
        Session session = Session.getInstance(properties, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("ibouderoua63@gmail.com", "ogdwpnrmuteilnyl"); // App-specific password
            }
        });

        try {
            // Create a default MimeMessage object
            MimeMessage message = new MimeMessage(session);

            // Set From: header field
            message.setFrom(new InternetAddress(from));

            // Set To: header field
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // Set Subject: header field
            message.setSubject("Subject: Your Custom Message");

            // Now set the actual message content
            message.setText(content);

            // Send the message
            Transport.send(message);
            System.out.println("Mail successfully sent to " + to);

        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }

    public static void main(String[] args) {
        // Example usage
        String emailToSend = "recipient@example.com";
        String messageContent = "Hello, this is a test email!";
        sendMail(emailToSend, messageContent);
    }
}
