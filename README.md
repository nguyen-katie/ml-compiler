# ml-compiler

Members of team: Katie Nguyen

<!-- HW 1 NOTES: -->
How you handled comments: 
    I handled comments by first defining a COMMENT state. Now, when the beginning comment symbol appears ("/*"), the lexer will enter the COMMENT state until the end ("*/"). 

    To account for comment nesting, I added a commentDepth reference that increments every time a new comment is nested and decrements every time a comment is ended. That way, when eof is ran, it can check if there are any nested comments based on if the depth is 0 or not before ending successfully.

How you handled errors/end-of-file: 
        When eof is ran, it can check if there are any open comments based on if the depth is 0 or not before ending successfully. It also checks if a string is open by checking the boolean inString, which only returns true if the compiler ends in the STRING state. Otherwise, an error is returned.


Anything else you think is of interest about your lexer: 
    linePos does not seem to reset every time the test cases are ran, causing the line count to be far bigger in the results. I noticed that the character for a new line has to be accounted for in every state even with the same lexResult everytime. 
