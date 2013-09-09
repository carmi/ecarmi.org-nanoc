---
title: Hours, Technical Debt, and Company Culture
slug: hours-technical-debt-culture
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2013-09-08"
updated_at: "2013-09-08"
published: true
featured: true
comments_enabled: true
summary: Hours don't measure performance, and caring about them is dangerous.
---
I've been thinking a lot about startups, long hours, and excellent company culture.

Excellence applied to a product is easily definable. We all know of the products we love and how excellent they are.

However, the question of what excellence means for a company is less easily defined. But building an excellent company is as important as -- if not more important than -- building a successful product. Thus it is something critical to think about as you build a product. You are also building a company and company culture

Fundamentally, companies consist of people, and I think excellent companies consist of happy people who productively do meaningful work.

Excellent companies have environments where people can be productive.

A productive environment is free of interruptions or other disturbances where people can get work done. Happy employees feel excited to come to work and enjoy their working; and feel what they do matters, has an effect, is meaningful.

Programming is distinct from most other types of work. The code you write will almost certainly last much longer than an email or Powerpoint. Future developers will have to use the systems you build. The design decisions you make right now are thus very important.

#Technical Debt

The brilliant programmer and author [Sandi Metz wrote](http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley/dp/0321721330): 

> If lack of a feature will force you out of business today it doesn’t matter how much it will cost to deal with the code tomorrow; you must do the best you can in the time you have. Making this kind of design compromise is like borrowing time from the future and is known as taking on technical debt. This is a loan that will eventually need to be repaid, quite likely with interest.

At every company there are examples of technical debt. Some critical part of the application that needed to be done, at whatever the cost. But later on you see the cost. Hours spent agonizing over a confusing, poorly designed part of the code. How much stress does it cause your engineers? And how damaging is it to their happiness if they have to wrangle frustrating systems?

Taking on technical debt may be necessary, maybe it isn't. But you will definitely be paying back this debt with interest.

I think that at almost any point in the timeline of a company you must avoid technical debt furiously. And if you have debt you must deal with it, you must improve your codebase, improve your tests, improve everything.

Technical debt should be used like duck tape. It should be used when something is broken, and you need to fix it as fast as possible, no matter how terribly. But you will have to spend even more time in the future fixing it. It doesn't simply fade away.

When you share [user passwords](https://blog.dropbox.com/2011/06/yesterdays-authentication-bug/) or the like you use duck tape to fix it. And that's the only time.

When you start deciding to take on technical debt to push a feature, you are making a poor choice. You may end up finishing the feature, but then you find bugs in it later, and fixing those bugs is costly and damaging in numerous ways. It is not effective, efficient, or worthwhile.
In this way, I think programming is very different from writing, or cramming for a test, or creating a powerpoint for a talk. When you're done with any of these, you are done. With programming you aren't, instead you are taking on dangerous technical debt.

Working long hours is dangerous, and ultimately stupid for programmers. It is impossible to write great code after some amount of time. After some period of time (some say 6 hours of actual programming) you stop being able to write great code. You start making poor decisions. At that point in time you begin taking on technical debt.

Once a company starts caring even the slightest about hours we enter the dangerous world of caring about hours. Zach Holman of Github [explains the danger](http://zachholman.com/posts/how-github-works-hours/),

> Because as soon as you make it about hours, their job becomes less about code and more about hours.

And then this terrible thing happens. People start feeling like they need to put in hours regardless of whether they are being productive because there is the expectation that they should be working until 7pm. If a company starts valuing these things then people begin playing games to fulfill these expectations. He continues on to explain why managers like hours: 

> It gives them the illusion that hours can measure performance.

When a manager asks you to work the weekend to stay on pace with your sprint, they are really saying that hours measure performance. It is a result of the belief that working more hours would cause the team to stay on pace with the sprint. Within this paradigm any failure to complete previous sprints was simply a lack of hours worked. This is false.

I fundamentally and unequivocally believe that a company culture that cares about hours instead of productivity is broken. Disastrously flawed. The antithesis of excellence.

# Deadlines

So you have a deadline and that's not going to change. How do you meet that deadline? Work smarter, not longer hours. You prioritize intensely, working on only the key things that are necessary for the release. You focus intelligently, removing meetings, hiring, and devops that aren't completely required for the release. (Generally meetings, devops, etc, need to be done, but not doing them doesn't create a debt with interest like poor design decisions in your code do.)

If your are hitting a wall on something, you stop, leave the office, hangout with friends, and then go back at it with fresh eyes.

The 37Signals folks say this in [Rework](http://37signals.com/rework):

 >   Our culture celebrates the idea of the workaholic. We hear about people burning the midnight oil. They pull all-nighters and sleep at the office. It's considered a badge of honor to kill yourself over a project. No amount of work is too much work.
 >   Not only is this workaholism unnecessary, it's stupid. Working more doesn't mean you care more or get more done. It just means you work more.
 >   Workaholics wind up creating more problems than they solve. First off, working like that just isn't sustainable over time. When the burnout crash comes -- and it will -- it'll hit that much harder.
 >   Workaholics miss the point, too. They try to fix problems by throwing sheer hours at them. They try to make up for intellectual laziness with brute force. This results in inelegant solutions.
 >   They even create crises. They don't look for ways to be more efficient because they actually like working overtime. They enjoy feeling like heroes. They create problems (often unwittingly) just so they can get off on working more.
 >   Workaholics make the people who don't stay late feel inadequate for "merely" working reasonable hours. That leads to guilt and poor morale all around. Plus, it leads to an ass-in-seat mentality--people stay late out of obligation, even if they aren't really being productive.
 >   If all you do is work, you're unlikely to have sound judgments. Your values and decision making wind up skewed. You stop being able to decide what's worth extra effort and what's not. And you wind up just plain tired. No one makes sharp decisions when tired.
 >   In the end, workaholics don't actually accomplish more than nonworkaholics. They may claim to be perfectionists, but that just means they're wasting time fixating on inconsequential details instead of moving on to the next task.
 >   Workaholics aren't heroes. They don't save the day, they just use it up. The real hero is already home because she figured out a faster way to get things done.

On Friday I was frustrated, hitting my head against a stupid bug. I continued hitting me head against this bug for a few hours. And I didn't figure it out. On Saturday night on a train ride I looked at it again, because it was gnawing at me, and I quickly figured it out. It was really enjoyable to figure it out then, in fact. I didn't have internet, so I looked at the source code of Rails to figure out how it worked, and learned a lot in addition to fixing the bug. I fixed it faster and I felt great about it. This is how it should be done.

Zach Holman finally says:

> By allowing for a more flexible work schedule, you create an atmosphere where employees can be excited about their work. Ultimately it should lead to more hours of work, with those hours being even more productive. Working weekends blur into working nights into working weekdays, since none of the work feels like work.

So if you have a deadline looming, you shouldn't work more hours, you should work more focused, smarter hours. By prioritization and working smart you will get your release done on time.
