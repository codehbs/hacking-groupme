# Hacking GroupMe
Learn how to hack your section's GroupMe. Who gives out the most hearts in your section's GroupMe? Who makes the best Memes? We are in business school and we use data. Ben and Jesse will show us how they hacked GroupMe (legally, through an API) and pull out interesting statistics from their section's group chat. Armed with Ruby, SQL and some Regex magic, we may go into the details during Hour of Code so you can also do this at home! 

It's a slippery slope after that... Remember those reckless jokes you made about your FRC professors? Yes, they are coming back to haunt you.

# Sample App 
For instance, you could create an app like this - https://inchuition.com/pensieve using Groupme APIs. See source code here - 
https://github.com/inchara/groupmeflashback (Look for groupmeparse.js which contains most of the API logic)

# Steps to create an app
## Step 1
Go to the [GroupMe](http://groupme.com) website for your group

## Step 2
Right click anywhere on the page and select "Inspect"

## Step 3
Right below the webpage you will see a bar that lists "Elements", "Console", "Sources", "Network" etc. Click on "Console"

## Step 4
Within the Console, search for "group/". The number listed directly after it is your group number. Put that number into Lines 14 and 15 where marked. MAKE SURE ALL QUOTES, SPACES AND + SIGNS ARE DELTED AFTER!

## Step 5
Within the Console, search for "access_token". Write it down (note, do not copy the quotes). Put that number into Lines 14 and 15 where marked. MAKE SURE ALL QUOTES, SPACES AND + SIGNS ARE DELTED AFTER!

## Step 6
In the same folder (if one is not included in the Github), create a file called "members.csv" and a file called "data.csv". Note: These should already be there so only make if you don't have them.

## Step 7
Line 144 calls a method "stats" and passes it a number. For the moment that number doesn't matter. Put something in and run the method. NOTE: Make sure that Lines 14 and 145 are turned OFF, Line 15 is turned ON, and Line 20 is ON. This will cause your method to pause at Line 20 in the terminal.

## Step 8
In the terminal, type "test". This will return to you a JSON object. Look in the hash where is says "messages". Those look familiar? They should. Those are the most recent texts to your Group! In the top message, find the "id" and copy the number next to it.

## Step 9
Go back to Line 144 and pass it the number you just took down. Now turn ON Lines 14 and 34, and turn off Lines 15 and 20. Run your code again. This is going to throw an error. That's ok! Take a look at your terminal. There should be a super long list of numbers.Find the very last number and copy it down. Go to Line 22 in the code and change the number to reflect what you just found.

## Step 10
FINALLY! Now, make sure both Line 144 and 145 are turned on. Also, make sure that the "data.csv" file is empty. Now, with those two lines on, run your code ago and check the terminal. It will give you the Top 10 messages, as well as the full list of how many times the people in your group are posting.


**Disclaimer**: There is a bunch of extra code in this right now. I had originally intended to do more with the members section, but...yea....lazy..... That said, whoever wants to take up the mantle, more power to you. 

*Hint: Submit a pull request!*
