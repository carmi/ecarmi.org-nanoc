---
title: How I (almost) got an internship at Google
slug: google-internship
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2011-03-28"
updated_at: "2011-12-03"
published: true
featured: true
comments_enabled: true
tags: internship, google
summary: I had a (well, three) interviews with Google for a summer internship position and lived to tell the tale.
---

# Applying for an internship at Google

<div class="disclaimer">
<p><strong>Disclaimer:</strong> This post has gotten nearly 100,000 views after being being on <a href="http://techcrunch.com/2011/05/07/why-the-new-guy-cant-code/">TechCrunch</a> and <a href="http://news.ycombinator.com/item?id=2384018">Hacker News</a> and much feedback. Some people liked it, and some absolutely did not.</p>

<p>I did not share anything I was asked not to share, and I have received no requests to change or remove this post. The <a href="http://devinterviews.pen.io/">hiring process</a> is complicated, and I believe an open discussion about current practices in our industry is important. If you are going to interview me and have an opinion/concern about this article, bring it up. Let's chat.</p></div>


Like most every Computer Science student looking for a summer internship, I applied to Google.

I submitted my application on their [website][internships] on December 31st, 2010 and received a thank you email. About ten days later I was sent an automated email asking me to fill out a Google spreadsheet Beta candidate preference form.

I heard nothing for a month and a half. And then, on Friday, February 25th, at 5:06pm I got an email from member of the Engineering Staffing Team, Hadas:

> Hi Evan,
> 
> Thanks for your interest in Google!
> 
> We've reviewed your resume and would like to learn more about you. We are interested in speaking to you about a possible summer Software Engineering Internship in one of our North American offices. To start the process we'd like to collect a bit of information from you:

I immediately filled out the forms and responded.

At 9:30pm that same evening I got another email back:

> Hi Evan,
> 
> Thank you for filling out the forms.
> I have forwarded all of your information to Becky (cc’d), the recruiter, who will be reaching out to you.
> 
> Good luck :)

I emailed the recruiter, Becky, and the next day heard back from her. At this point I was increasingly impressed by their responsiveness. I had been talking to other companies and everyone had been very slow and unorganized responding to my emails.

She explained the process of applying:
    
> To give you some background, here are the steps for applying for an internship at Google:
> First you'll do 2 technical phone interviews (45 minutes each). If the interviews go well, your information will be shared with potential intern hosts to review as we work to identify a project that is in line with your background and interests. Once a strong match is determined, I will contact you to set up a host interview (30 minute phone call).

This didn't end up being the process for me. I actually had three technical phone interviews (instead of only two), but I'll get to that later.

I wanted to figure out my summer plans as soon as possible, so I scheduled two back-to-back interviews for the following Monday. At this point I had heard from them on Friday after 5pm, and had interviews scheduled for Monday. It seems Googlers don't mind working on weekends.

#Technical Interview #1

I had to read and sign a few forms before the interviews. I read through them very carefully and it didn't seem they explicitly forbade me from discussing the interviews. Hopefully I don't get a letter from Google lawyers informing me I broke some agreement. Although a [cease-and-desist](http://en.wikipedia.org/wiki/Cease_and_desist) letter from Google would be a nice wall ornament.

I was called by a Site Reliability Engineer who has worked in the industry for 30 years. He was the nicest of the three technical interviewers, and this interview went best.

He saw [Django](http://www.djangoproject.com/) on my [résume][resume] and asked me a few questions about the templating system. Something along the lines of:

* how could you make Django templating better

Next he asked me some questions that should be implemented in Python. I only needed to describe the solutions and did not need to actually code them up. Each question began simple and got increasingly difficult as he added on functionality or requirements.

Write a function with the following specification:

* _Input:_ a list.
* _Output:_ a copy of the list with duplicates removed.

Ok, now, change the function to remove the last instances of duplicates instead of the first instances.

Modify it to remove the n<sup>th</sup> instance of a given element to be removed

After a quip that since I was still in school and these were fresh in my mind I was asked some questions about data structures.

_Which of the following data structures guarantee O(lg(n)) look up:_

* [Red-black tree][red-black] - yes.
* [AVL tree][avl] - yes.
* [Splay tree][splay] - no (they have the property that recently accessed elements are quick to access again, but this causes look up to be O(n) in the worst case.
* and [others][other trees] I forget.

_Lastly, a few Python language specific questions:_

* What does the [asterisk](http://www.saltycrane.com/blog/2008/01/how-to-use-args-and-kwargs-in-python/) mean before a parameter in a function declaration.
* What does a double asterisk mean before a parameter in a function declaration.
* What do `[]`, `{}`, `()` declare.
* What is the difference between `()` and `(,)`.

His actual last question was if I had any questions for him. We chatted a bit and then he let me go so I could relax for ten minutes before the next interviewer called.

#Technical Interview #2

This interview was much more difficult. And that was because I had to write real code.

My interviewer was somewhat new at Google and was working on the Webmaster Tools Team. She graduated three years ago from Carnegie Mellon and said that Google was her first job.

She had sent me a link to a Google document and asked that I open it up. I opened it up, and she told me the question:

_Implement the following algorithm in valid C in the shared Google document:_

* _Input:_ an array of sorted integers.
* _Output:_ the index of a particular integer.

A [binary search](http://en.wikipedia.org/wiki/Binary_search_algorithm) in C. Of course, she didn't tell me it was binary search, didn't actually tell me anything else. Once I got a recursive implementation seemingly working (I never actually tested my code afterwards) she told me there was a bug. This process repeated a few times as I looked for bugs in my index calculation and forgot to handle the "not in list" case (return -1).

I'd like to point out that given two full hours and any high-level language (including pseudocode) only 10 percent of professional programmers implemented binary search correctly, [according to Jon Bently](http://books.google.com/books?id=gJrmszNHQV4C&lpg=PA87&ots=rLOWuzQ4oe&dq=percentage%20of%20binary%20search%20is%20implemented%20incorrectly&pg=PA87#v=onepage&q&f=false).

I hadn't written any C code for at least a few months. As I began trying to remember proper syntax knowing I was being watched, I wished I had studied up on C before the interview.

This single question took up most of the 45 minute interview, and I don't remember any of the other questions.

I was originally told that I would only have two of these technical interviews. Later that evening after the interviews I got a call from the recruiter. She told me on the phone that they actually wanted to have a third interview with me. I'm not sure exactly why this was, and she wouldn't elaborate. My guess is that I did well enough to move on, but not good enough to straight out hire me. We planned the third interview for Thursday.

#Technical Interview #3

I was called by a guy, who unfortunately, was not as nice as the first interviewer. He asked me which Computer Science classes I had taken, and sounded condescending hearing my response (I was a sophomore and in my fifth C.S. course at the time).

He asked what had been my hardest projects, and then we got started. He wanted me to write some code, but he had not set up a Google doc like interviewer #2, so he said I would just tell him what code to write down over the phone. This sounded miserable. I suggested that he create a Google doc, and he did. The problem was:

_Implement an algorithm that checks whether a [sudoku puzzle](http://en.wikipedia.org/wiki/Sudoku) is correctly solved or not._

I could do this in Python. The input parameters and everything else were up to me to decide. Luckily I knew something about sudoku puzzles. Sadly I hadn't solved one in years.

I got a solution working, but it wasn't terribly short or clean.

# Almost
The next day I got an email from the recruiter (she called me when she wanted me to proceed with another interview, so I assumed an email was a bad sign):

> Hi Evan,
> 
> Thank you for taking the time to interview for the Software Engineer Seattle/Kirkland Internship position. All the feedback has been reviewed from the interviews and at this point we won't be moving forward in the process. I know this wasn't the outcome we were hoping for. We can't thank you enough for your interest in Google's careers and unique culture; we hope you will remain enthusiastic about our company. If you have any questions, please feel free to contact me.

In exactly one week I had gone through the entire process from being contacted to having three technical interviews and hearing back. By far the fastest process of any company I talked with.

I really had the feeling that luck was a huge part of it. If I had more recently implemented a binary search, something I had to do last year in a class, and it was fresher on my mind, I might have done it more quickly and with less errors. If I loved solving sudoku, the second problem would have likely been easier. In the end, if you get lucky and the question you are asked is something you are familiar with, then you're in luck. I had the sense that they did not care very much about prior experience. It only mattered how you did on your interviews in response to a few specific questions.

I'm glad I had the experience interviewing, and after having had trouble finding information on the internship application process and what to expect I thought I should write up my own story.

I got an internship with The New York Times the following week.


[internships]: http://www.google.com/jobs/students/us/internships/
[resume]: https://github.com/carmi/resume/raw/master/resume.pdf  "My LaTeX Resume"
[red-black]: http://en.wikipedia.org/wiki/Red-black_tree
[avl]: http://en.wikipedia.org/wiki/Avl_tree
[splay]: http://en.wikipedia.org/wiki/Splay_tree
[other trees]: http://en.wikipedia.org/wiki/Self-balancing_binary_search_tree#Implementations
