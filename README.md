# Salesforce-to-Jira-Service-Desk-Ticket

## Calling the Method

```apex
JiraIntegrationService.createJiraTicket('Issue Summary', 'Issue description here', 'PROJECTKEY', 'Bug');
```

### From Another Apex Class

If you have another Apex class where you need to create a Jira ticket, you can directly call the `createJiraTicket` method. For instance:

apex

```apex
public class SomeOtherClass {
    public void someMethod() {
        JiraIntegrationService.createJiraTicket('Issue Summary', 'Issue description here', 'PROJECTKEY', 'Bug');
    }
}
```

### From an Apex Trigger

If you want to create a Jira ticket in response to a record being created or updated in Salesforce, you might use an Apex trigger. For example:

apex

```apex
trigger CreateJiraTicketOnCase on Case (after insert) {
    for (Case c : Trigger.new) {
        // Assuming you want to create a ticket for each new Case
        JiraIntegrationService.createJiraTicket(c.Subject, c.Description, 'PROJECTKEY', 'Bug');
    }
}
```


### From a Visualforce Page

If you are using a Visualforce page and want to trigger this action from a user interface element like a button, you would have a controller or extension that calls this method. For example:


```apex
public class MyVisualforceController {
    public void createTicket() {
        JiraIntegrationService.createJiraTicket('Issue Summary', 'Issue description here', 'PROJECTKEY', 'Bug');
    }
}
```

---------


## **Setup and Authentication:**

- **Obtain API credentials:** I need API credentials for both Salesforce and Jira Service Desk. For Salesforce, you need a user with "API Access" enabled and create a Connected App. For Jira Service Desk, generate API tokens from  project settings.
- **Install libraries:** In the Salesforce development environment, install libraries like `restforce` for interacting with the Salesforce API and `requests` or another HTTP library for making API calls to Jira Service Desk.

**2. Data Mapping and Payload Preparation:**

- **Identify relevant fields:** Determine the fields need to copy from Salesforce to Jira Service Desk. This typically includes customer information, issue details, and relevant custom fields.
- **Build the payload:** Structure the data in the format expected by the Jira Service Desk Create Issue endpoint. Refer to the API documentation for specific requirements and field names.

**3. API Call and Error Handling:**

- **Make the API call:** Use library to send a POST request to the Jira Service Desk Create Issue endpoint with the prepared payload.
- **Parse the response:** Check the response for success or errors. Handle potential errors gracefully and retry or log them appropriately.

**4. Additional Considerations:**

- **Security:** Implement appropriate security measures like OAuth for secure authentication.
- **Error handling:** Implement robust error handling to gracefully deal with potential failures during API calls.
- **Logging and monitoring:** Implement logging and monitoring mechanisms to track the success and potential issues of the integration.

