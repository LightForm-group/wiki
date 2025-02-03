---
title: Debugging tips
author: Gerard Capes
tags:
  - debugging
subcollection: General
---
If you run or write code as part of your research, sooner or later something isn't going to work as expected. 

# Debugging checklist
- [ ] Compare your code against the last working version (`git diff`).
      If it previously worked, then something you have changed will most likely have brought about the current error.
- [ ] Google the error message.
      It's quite possible that someone else has encountered the same problem as you,
      and had it answered on stack overflow.
- [ ] Are you running the latest version of the software?
      You might have found a bug that has subsequently been fixed.
      Updating your software might resolve the problem.
- [ ] Check on the software's issue tracker.
      Many software packages have a publicly accessible issue tracker (on GitHub or elsewhere) that you can search,
      or use to create a new issue for the problem you're facing.

# How to ask for help
When asking for help (e.g. from colleagues, on stack overflow), you should aim to make it easy for others to help you. This means
- [ ] Give some context - what were you trying to do? This is more useful than just asking what an error message means.
- [ ] Given them something they can run to reproduce your error.
      A [minimum working example](https://en.wikipedia.org/wiki/Minimal_reproducible_example) is the target here.
      A link to your code on GitHub would be great - maybe you want to create an issue too which explains everything
      so the conversation can stay with the code rather than getting lost on slack.
- [ ] What versions of which software are you using?
- [ ] Show the whole error message - the important clue might not be where you think it is
- [ ] What platform are you running on (laptop/CSF etc)?

Very often the process of verbally explaining / writing down the problem causes you to fix the problem on your own. This is known as [rubber ducky debugging](https://en.wikipedia.org/wiki/Rubber_duck_debugging).
