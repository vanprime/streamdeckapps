# Apple Scripts collection
Some tasks are tedious and why not automate them?

Outlook provides only a single app. Thus we have to either navigate inside that app or use the web versions and find the tabs in our never clean tab list.
For me, this creates a surprisingly large context switch and cognitive load which I'd prefer to avoid.

Also, Window management on mac is hard. IMO that's still the case when using Raycast, Loop or even the macOs 15 window management. So I decided to add some scripts that position windows like I enjoy them when working in different scenarios.

Currently, all scripts are .applescript files, but according to [Reddit](https://www.reddit.com/r/elgato/comments/z93cbm/this_post_is_for_my_applescript_loving_stream/) we can use .scp files and add paramters when calling them via the Stream Deck.

```
/Users/<username>/Desktop/test.scpt argument
```

so compiling the scripts to .scp and taking direction and/or app name would make it easier to control more apps. However, I don't care _yet_ 😎

## Setup

To make all shell scripts executable and run them from your terminal, run this command from the project root:

```bash
find . -type f -name "*.sh" -exec chmod +x {} +
```

You don't need to do this for usage with the elgato software, however.