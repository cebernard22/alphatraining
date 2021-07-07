from atlassian import Jira

jira = Jira(
    url='http://alphatraining.atlassian.net:8080',
    username='admin',
    password='admin')
JQL = 'project = DEMO AND status IN ("To Do", "In Progress") ORDER BY issuekey'
data = jira.jql(JQL)
print(data)