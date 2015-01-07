---
title: How to Make Calls with iPhone from Mac OSX
slug: call-with-iphone-from-mac-osx
markup: markdown
kind: article
author: Evan H. Carmi
created_at: "2015-01-07"
updated_at: "2015-01-07"
published: true
featured: true
comments_enabled: true
summary: Browsing the web, and want to call a phone number with you iPhone with just a click? Now you can!
---
# The Short Version:

Here is a [Mac OS X Services file](/static/files/call-phone-number.zip), that you can download, unzip, and install (by clicking on) to select a phone number in Chrome, Preview, or any application and right click to call the number with your iPhone. Cool!

<img src="/static/img/call-phone-animation.gif" alt="Example using the call phone service">

# The Technical Version

Mac OS X Yosemite introduced the ability to make and receive phone calls on your Mac using your iPhone's cellular number. Once you [get it setup](http://support.apple.com/kb/PH18756) when you receive a call a notification pops up on your Mac.

<img src="/static/img/zuck-calling.png" alt="Phone call from Zuck" title="When Zuck calls me" height="73px">

That's all fine and dandy. But what about making phone calls from you Mac?

## Making Phone Calls From Your Mac

Out of the box, there a few ways to do this.

1. You can open up FaceTime and select Audio and type in a phone number. Too many steps! Boo!
2. In Safari, you can select a phone number as text and a small button appears next to it where you can call with your iPhone.

![Calling the White House](/static/img/calling-from-safari.png "Ringing Barack")

But come on, who uses Safari?

## Making Phone Calls from Any Application

Ok, so I want the Safari feature but on Chrome, Firefox, and anywhere really. I can do this with Services.

I've created a really simple Mac OS X Service that you can [download here](/static/files/call-phone-number.zip), unzip, and install (by double clicking).

Once you install this Service you can go to Chrome or any application that allows for selecting text. If you can copy and paste the text from the app, then you can select a phone number, right click, and click "Call phone number". This will pop up the FaceTime dialog box with a confirmation that you want to call the number. And, voilà, we now can make calls using our iPhone from our Mac.

## Behind the scenes

Behind the scenes, and if you open the Call phone number workflow in [Automator](http://support.apple.com/en-us/HT2488) you'll see this is pretty much just piping the selected text into a AppleScript snippet.

At first, I was looking for a way to make FaceTime calls, thinking that since the FaceTime app checks if the phone number is a FaceTime enabled line and if it is not, calls using your cellular the same would happen if instantiated from an Applescript. But this was not the case, and it just failed, frustratingly.

This did not work:

    #!applescript
    on run {input, parameters}
      open location "facetime-audio://" & input & "?audio=yes"
      return input
    end run

So I was wondering if there were other location bindings in FaceTime that were similar to facetime-audio. I searched the Facetime.app and found this:

    #!bash
    » ag -C 5 facetime-audio /Applications/FaceTime.app
    /Applications/FaceTime.app/Contents/Info.plist
    38-     <string>FaceTime URL</string>
    39-     <key>CFBundleURLSchemes</key>
    40-     <array>
    41-       <string>tel</string>
    42-       <string>facetime</string>
    43:       <string>facetime-audio</string>
    44-     </array>
    45-     <key>LSIsAppleDefaultForScheme</key>
    46-     <true/>
    47-   </dict>
    48- </array>

Hmm, sure looks like I should try `tel`. And that did the trick. I put this AppleScript in the Service, and it worked!

    #!applescript
    on run {input, parameters}
      open location "tel://" & input & "?audio=yes"
      return input
    end run

Let me know in the comments if this works for you or if any issues pop up with the workflow.
