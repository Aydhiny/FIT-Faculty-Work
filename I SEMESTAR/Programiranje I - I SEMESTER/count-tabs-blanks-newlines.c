#include <stdio.h>
   /* count characters in input; 2nd version */
int main()
{
  int c, numBlanks = 0, numTabs = 0, numLines = 0;
  while((c = getchar()) != EOF) 
  {
    if(c == ' ')
      ++numBlanks;
    else if (c == '\t')
      ++numTabs;
    else if (c == '\n') 
      ++numLines;
  }
  printf("%d\t%d\t%d", numBlanks, numTabs, numLines);
}
