# Before And After Examples

Use this reference when the agent needs concrete rewrites, not just findings.

## Dashboard

Before:

```text
Welcome to your analytics dashboard. This dashboard helps you understand how your business is performing by showing important metrics across revenue, customers, and engagement. Use the cards below to monitor trends and identify areas that need attention.
```

After:

```text
Analytics
Revenue | Customers | Engagement
```

Why: the paragraph describes the dashboard instead of helping the user act. The metric groups carry the meaning.

## Tool Screen

Before:

```text
Use this tool to generate a report based on the files you upload. You can choose the report type, adjust the date range, and customize the output before generating the final report.
```

After:

```text
Report type [Summary v]  Date range [Last 30 days v]  Output [PDF v]
[Generate report]
```

Why: the choices should be controls, not prose.

## Form Helper Text

Before:

```text
Please enter the email address where you would like to receive notifications about account activity and important updates.
```

After:

```text
Notification email
```

Why: the label already explains the field. Add helper text only if delivery rules or consequences are non-obvious.

## Empty State

Before:

```text
You have not created any automations yet. Automations can help save time by running repeated tasks for you on a schedule or when specific conditions are met. Create your first automation to get started and begin streamlining your workflow.
```

After:

```text
No automations yet.
[Create automation]
```

Why: empty states need next action, not product education.

## Settings

Before:

```text
This section allows you to manage your notification preferences. You can turn email, SMS, and in-app notifications on or off depending on how you prefer to receive updates.
```

After:

```text
Notifications
Email [on/off]
SMS [on/off]
In-app [on/off]
```

Why: visible controls communicate available settings.

## AI Assistant Builder

Before:

```text
Define your assistant's behavior by writing clear instructions. These instructions will guide how the assistant responds to users and what tone it should use.
```

After:

```text
Instructions
Placeholder: Answer support questions in a concise, friendly tone. Ask for an order number before checking shipment status.
```

Why: a concrete placeholder teaches the format better than explanation.
