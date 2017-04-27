Feature: Contact

  Scenario: A customer can see my contact details on the Contact page
    Given that a user is on the contact page
    Then they can see my contact details
  
  Scenario: A customer can locate the office in Google Maps

  Scenario: A customer can send a message via the contact form successfully
    Given that a user is on the contact page
    When they fill in their name
    And they fill in their email
    And they fill in their message
    And they click "Send"
    Then the message is sent successfully

  Scenario: A spambot is unable to send messages using the contact form
    Given that a user is on the contact page
    When they fill in all of the fields of the contact form
    And they click "Send"
    Then the spam message isn't sent

  Scenario: A customer is unable to send a message without their name
    Given that a user is on the contact page
    When they fill in their email
    And they fill in their message
    And they click "Send"
    Then the message isn't sent

