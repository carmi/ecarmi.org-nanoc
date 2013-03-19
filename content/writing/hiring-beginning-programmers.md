---
title: Hiring Beginning Programmers
slug: hiring-beginning-programmers
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2013-03-18"
updated_at: "2013-03-18"
published: true
featured: true
comments_enabled: true
summary: There are plenty of guides to hiring rockstar developers, but how do you tell if someone has potential.
---

# Searching for potential

At my [university](http://wesleyan.edu/) I am the head of a small team of student programmers. We are embedded in a mainly student-run organization within the university's larger IT department. We develop software and websites to help facilitate the smooth running of an organization with around a hundred part-time student workers. Having a student-run programming group is quite interesting because there is constant turnover. (Almost all students spend four years at the university.) We try to hire first or second year computer science students into our group, and managers have always been seniors. This year, as the manager, I've gotten to hire a few new programmers from a pretty good pool of applicants. I've found the process of interviewing and hiring these up-and-coming programmers really interesting. Virtually no one had the exact skill set we needed (Ruby or Node) and I expected this. Instead, the process of hiring was not to find those who already knew what we were doing, but rather find those who could learn. Ideally, who could learn on their own, and learn quickly. And since I was the only one interviewing about a dozen candidates, I needed the process to be somewhat quick. This is my experience and thoughts on hiring beginning programmers.

# Finding applicants

First off, I reached out to students who had taken either introductory programming classes or the year-long introduction to computer science courses. I got responses from students who generally had a taken one or two semesters of programming in either Python or Java. From these I started interviews.

# Interviewing

I had an hour long interview with each applicant. When I scheduled the interviews I planned a start time but didn't say how long the interviews would go. This gave me the freedom to adjust the time as necessary without giving too much away. If after 30 minutes I felt that someone wasn't a good match, I wanted to be able to wrap up the interview. Similarly, I wanted to be able to take a little more time if I needed. Before the in-person interviews I asked for code samples (often final projects for their classes) and for their preferred languages. The biggest thing I tried to do throughout the interviews was let the interviewees share what they were knowledgeable about instead of making them answer specific questions.

# Non-programming questions

I began by asking what experience they had with programming and technology. One kid's father was a VP at Apple, so he told me that his father let him have a PC only if he built it from scratch, so he did. I grabbed the nearest PC, ripped the case off, and asked him to identify all the components. Others said they had experience with HTML/CSS, so I asked them to write a simple web page and style it a bit. I tried to ask open-ended questions and then follow up based on responses.

## How does the internet work

I asked everyone to explain in as much detail as they knew what happens from when you type www.google.com into your browser and press enter to seeing a rendered web page. (This is one of my favorite questions since it's so open ended. If you know a bit about DNS and HTTP requests, you can explain that. If you know about TCP, you can explain how the socket connection is established with a three way handshake. If the frontend is your thing, you can talk about parsing and DOM tree construction.) This question encompasses so much that the parts that people know and choose to talk about explains a lot about their knowledge.

# Programming Questions

I asked a few programming questions. There are two reasons I do this. First, to give people the experience of being asked to code under the spotlight. I know a lot of peers whose first coding under pressure was for a job interview. I think giving people this experience in a calmer setting is beneficial for them. Secondly, while I don't think we should put too much value on how quickly someone can write up [binary search in C](http://ecarmi.org/writing/google-internship/), answering some programming questions is a quick way to see how someone approaches a problem. I asked a few questions. I tried to ask easy questions that once solved could be expanded and made more difficult.

## Reverse a string or list

Writing a reverse function for a string or a list is a simple question that allows for a few follow up questions. Once the interviewee has a working reverse function, I ask them how much memory is required to reverse a string of length N. Since the first solution should return a copy of the list, having them think through this leads to a [in-place](http://en.wikipedia.org/wiki/In-place_algorithm) implementation. So I'll have them code this up. I like to ask about the differences between the two different versions and which would be better used in what circumstances. Some people go for a recursive reverse function, most jump to iterative first.

## FizzBuzz

If I still have time remaining, I'll ask [FizzBuzz](http://www.codinghorror.com/blog/2007/02/why-cant-programmers-program.html). I can usually extend this question by asking them to refactor it into a more Object Oriented solution, if it isn't already. I'm in the middle of the road about the effectiveness of this question, but so far it's been decent, allowing me to see how someone thinks through something they haven't done before.

# What to look for

Overall, I just try to have a conversation with the interviewee throughout the process. It's not so important what they get right and what they don't. Through talking with them and being attentive to their approach and problem solving I develop a general sense about them. Will they be self-directed? Be able to figure things out? Will they take my job in a few years? As many others say, you don't want to be working with someone you don't like. So lastly, I simply ask myself if I like them and would enjoy working and hanging out with them.

Have you hired beginning programmers? Have you hired looking for potential? Share your experience in the comments or on [Hacker News](https://news.ycombinator.com/item?id=5401663).


*[HTML]: HyperText Markup Language
*[DOM]: Document Object Model
*[TCP]: Transmission Control Protocol
*[HTTP]: HyperText Transfer Protocol
*[CSS]: Cascading Style Sheets
*[DNS]: Domain Name System
*[PC]: Remember when people still used PCs?



