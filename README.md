Github user's favourite language
================================

To determine a Github user's favourite language, at the root of this project:

Open a console session

```bash
rake console
```

And enter the following command

```ruby
Github.favourite_languange_of 'username'
```

Where `'username'` is the Github username of the user

The response will take a few seconds, and will be the user's most used computer language in Github.

To exit the console, type `exit`

Please note that the API calls used are unauthenticated and limited to 60 per hour. Depending on the
number repositories the user has, this facility may only work once or twice per hour.
