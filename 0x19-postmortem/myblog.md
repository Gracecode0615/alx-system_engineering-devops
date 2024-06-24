Postmortem

Issue Summary
We had just released a new feature to our recently launched Ruby on Rails site that we had our first intake of users complaining about the site. 5 minutes after we performed a feature update, we started receiving emails from our users talking about "they can't sign in or sign up to our platform". It was quite surprising to us because we knew it worked on our machines and it worked before. About 30 emails of the same report  came to our inbox. It was an avalanche of emails. Knowing how hard it can be to attract and keep users, we couldn't afford to lose 30 of our users in that way and decided to take a closer look at the problem. We cloned our site's repository from GitBug, followed the installation instructions on the README and to our surprise the site couldn't start up. It wasn't long before we realized that the cause of the problem was failing to update the requirements for our project. The site was malfunctioning from 7:00 AM GMT+1 to 11:20 AM GMT+1.
Timeline
06-24-2024 7:00 AM GMT+1 - A customer complained that they couldn't sign in to the site.
06-24-2024 7:32 AM GMT+1 - Grace, one of our backend developers, experienced the same issues our customers reported.
06-24-2024  08:05 AM GMT+1 - We investigated the controllers and the views for inconsistencies.
06-24-2024  8:40 AM GMT+1 - We assumed the bcrypt (one of our site's dependencies) gem being used was either at fault or used incorrectly because the error message on the site showed that the bcrypt gem was raising an error over an invalid hash.
06-24-2024  8:42 AM GMT+1 - We checked that the views might not be binding the form fields to the right model fields, which later turned out to be false.
06-24-2024  9:15 AM GMT+1 - We were misled by thinking that our controllers might be creating a different hash for a valid password of the site's admin.
06-24-2024  09:17 AM GMT+1 - Winus thought the issue might have been that the password was not properly hashed.
06-24-2024  9:40 AM GMT+1 - The incident was escalated to the backend development team.
06-24-2024  10:20 AM GMT+1 - The incident was resolved by updating the requirements (the bcrypt gem version) for the backend server.
Root Cause And Resolution
The version of the bcrypt gem we used was outdated. It was raising an error over a hash that was clearly valid and matched what was stored in the database. It could be that the hash we were creating was not supported by the version of bcrypt we had installed. Grace fixed the issue by manually updating the version of bcrypt in the Gemfile.lock file to a more recent version and reinstalling the required gems, and it worked like a charm.
Corrective And Preventative Measures
Setup a continuous integration pipeline to run a build on each pull request branch. This would ensure that builds are passing in the pull request branch before it is merged with the deployment branch.
Setup a monitoring system for the database and application servers to keep track of any issue that may occur.
Develop tests that need to be passed for each new feature and those tests should be passing before they are merged with the deployment branch.


