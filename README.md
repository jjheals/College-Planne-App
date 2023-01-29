# College-Planner-App

Authors: 

jjheals (Justin Healey) - justinhealey.com, github.com/jjheals
anaygandhi (Anay Gandhi) - github.com/anaygandhi

Inspiration: 

Our inspiration for this particular application stems directly from our own experiences. We're both college students - undergraduates - and are both extremely ambitious. Ambitious is great, but with that comes a need for some serious organiztional skills. That's why we wanted to develop a planner app for college students, by college students. We've looked everywhere for an app like this, and there are a few, but none are really what we're looking for. 

Amibious college students need organization - they need a way to see everything in one place: assignments, classes, schedules, and to be reminded of their stuff. We certainly do. Even more, everyone is on their phones in modern days, and everyone is always texting. We concluded that text message reminders would be incredibly helpful. Personally, we both turn off notifications for most apps because they're distracting; but no one turns off text messages. And school is important! No one wants to miss a deadline, an exam, or fall behind, especially us. 

**How we did it**

Neither of us have developed a mobile app before. We are both pretty decent at OOP and OO languages like python (which we used for the backend server API) and Java, so Swift wasn't all too bad. We also both have minimal experience in third-party API integration, so it was fun to learn more about **Twilio** and **Auth0** as we developed our application and had new ideas. 

**How it works** 

The planner works like any normal planner would: it has a to-do list, a clean dashboard, a list of subjects, and a calendar tab for better organization and prioritizing. There is also a section for notes where the user can link files and separate them by class. 

The text message reminders are the gold lining of our app. Texts are *so* convenient, and instant, and you can get them on almost any device, anytime! We aimed to help keep ourselves organized and on target, so text message reminders seemed like the perfect solution. We utilized Twilio's SMS API to integrate this feature. Every day at the same time the server scans the database for assignments that are due the next day and sends users a text with the number of assignments and which assignments are due tomorrow! In the future, we want to expand this to be more customizable - maybe some students only want one summary a week, or maybe they want them three times a day. That's a feature we plan to implement in the near future. 

The authentication through *Auth0* is super cool. Upon opening the app, the user is prompted to login through Auth0's authentication service. Unfortunately, we had a hard time implementing Auth0 into the backend of our app, but that is our number one priority for the near future. Security is *incredibly* important, and without proper authentication to endpoints, its mere security by obscurity. 

Last but not least, **Linode** was our cloud provider of choice for hosting our server. Linode servers are cheap (yay!), easy to deploy, easy to manage, and have extremely good uptimes. They're also customizable and scalable to your needs, so we struggled to really find a downside there!



