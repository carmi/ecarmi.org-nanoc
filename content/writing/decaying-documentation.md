---
title: Decaying Documentation
slug: decaying-documentation
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2013-09-01"
updated_at: "2013-09-01"
published: true
featured: true
comments_enabled: true
summary: Don't comment your code; write readable code.
---
> How many times have you seen a comment that is out of date? Because comments are not executable, they are merely a form of decaying documentation.
>
> [Sandi Metz](http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley/dp/0321721330/)

Comments are a form of decaying documentation! When I read this last week I was shocked. I had heard about comments being quickly out of date, but I had never taken it seriously. I didn't think that people were serious about this comment hatred.

Back in college my Computer Science professors always wanted everything to be commented, every function, every non-trivial thing. I developed exactly what you'd expect: a case of over-commentation. I thought it was good. I thought that comments explained the code. I thought wrong. And I'm shocked it took me so long to realize this.

As I've been reading Metz' excellent book, I've been thinking about the point she makes. A point that has been argued by [some of the bravest](http://www.codinghorror.com/blog/2008/07/coding-without-comments.html) and [brightest](http://www.briankotek.com/blog/index.cfm/2008/6/5/Dont-Comment-Your-Code) [among us](http://www.codeodor.com/index.cfm/2008/6/18/Common-Excuses-Used-To-Comment-Code-and-What-To-Do-About-Them/2293). And I've been persuaded.

Don't comment your code.

Rather, great code doesn't need comments. The code should be designed in a way so that it doesn't need comments to be understandable.

Sure, there are times to add comments, but they shouldn't be the default. They shouldn't be the ideal that we strive for.

So next time you see the new kid writing more comments than code, [have an intervention](http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley/dp/0321721330/).
