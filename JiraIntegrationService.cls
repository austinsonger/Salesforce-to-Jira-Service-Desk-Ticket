public class JiraIntegrationService {
    private static final String JIRA_BASE_URL = 'https://your-jira-domain.atlassian.net';
    private static final String JIRA_API_ENDPOINT = '/rest/api/2/issue/';
    private static final String USERNAME = 'your_email@example.com';
    private static final String API_TOKEN = 'your_api_token';

    public static void createJiraTicket(String summary, String description, String projectKey, String issueType) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(JIRA_BASE_URL + JIRA_API_ENDPOINT);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(USERNAME + ':' + API_TOKEN)));

        // Construct JSON payload
        Map<String, Object> issueFields = new Map<String, Object>{
            'project' => new Map<String, String>{'key' => projectKey},
            'summary' => summary,
            'description' => description,
            'issuetype' => new Map<String, String>{'name' => issueType}
        };
        Map<String, Object> payload = new Map<String, Object>{
            'fields' => issueFields
        };
        String jsonBody = JSON.serialize(payload);
        req.setBody(jsonBody);

        // Send request
        try {
            Http http = new Http();
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 201) {
                System.debug('Jira ticket created successfully.');
            } else {
                System.debug('Error creating Jira ticket: ' + res.getBody());
            }
        } catch (Exception e) {
            System.debug('Exception while creating Jira ticket: ' + e.getMessage());
        }
    }
}
