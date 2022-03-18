
// GITHUB TEST 2

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdbool.h>
#include <ctype.h>

bool isKey(int x, int y);
bool isDoor(int x, int y);
void move(char grid[][20], char dir, char *player, int *x0, int *y0, int keyVal[2]);
void printGrid();


/* 
/ random grid initiallizer to be added?? (predefined grid/maze for now)
/ might switch to numbers and use an if statement to print the characters i want so i dont have to
/ use so many bytes to store the individual char datatypes considering the array is kinda large
*/
char grid[20][20] = {
{'#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'},
{'#', '0', ' ', ' ', ' ', '3', ' ', '2', ' ', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'},
{'#', ' ', '#', '#', '#', '#', '#', '#', '#', '#', '#', ' ', '#', ' ', '#', 'x', '#', ' ', ' ', '#'},
{'#', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', ' ', '#', ' ', '#', '#', '#', ' ', '#', '#'},
{'#', '#', '#', '#', ' ', '#', ' ', '#', '#', '#', '#', '#', '#', ' ', '#', ' ', ' ', ' ', ' ', '#'},
{'#', ' ', ' ', ' ', ' ', '#', ' ', '#', ' ', '#', ' ', ' ', ' ', ' ', '#', ' ', '#', '#', ' ', '#'},
{'#', ' ', '#', '#', ' ', '#', ' ', '#', ' ', '#', ' ', '#', '#', '#', '#', ' ', '#', ' ', ' ', '#'},
{'#', ' ', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', 'Y', ' ', '#', ' ', '#', '#'},
{'#', '#', ' ', '#', '#', '#', '#', '#', ' ', '#', '#', '#', '#', ' ', '#', '#', '#', ' ', ' ', '#'},
{'#', ' ', ' ', '#', ' ', ' ', ' ', '#', ' ', '#', ' ', ' ', ' ', ' ', '#', ' ', '#', '#', '#', '#'},
{'#', ' ', '#', '#', ' ', '#', ' ', '#', ' ', '#', '#', '#', '#', ' ', '#', ' ', 'X', ' ', ' ', '#'},
{'#', ' ', ' ', ' ', ' ', '#', ' ', '#', ' ', '#', ' ', ' ', ' ', ' ', '#', ' ', '#', '#', ' ', '#'},
{'#', '#', '#', '#', '#', '#', ' ', '#', ' ', '#', ' ', '#', '#', '#', '#', ' ', '#', ' ', ' ', '#'},
{'#', ' ', '#', 'y', ' ', ' ', ' ', '#', ' ', '#', ' ', ' ', '#', ' ', ' ', ' ', '#', ' ', '#', '#'},
{'#', ' ', ' ', ' ', '#', ' ', '#', '#', ' ', '#', '#', ' ', '#', ' ', '#', '#', '#', ' ', ' ', '#'},
{'#', ' ', '#', '#', '#', ' ', '#', ' ', ' ', ' ', ' ', ' ', '#', ' ', '#', ' ', '#', '#', ' ', '#'},
{'#', ' ', '#', ' ', ' ', ' ', '#', '#', '#', '#', '#', '#', '#', ' ', '#', ' ', ' ', ' ', ' ', '#'},
{'#', ' ', '#', '#', '#', '#', '#', ' ', '#', ' ', ' ', ' ', '#', ' ', '#', ' ', '#', '#', '#', '#'},
{'#', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '#', ' ', ' ', ' ', '#', ' ', ' ', ' ', ' ', '#'},
{'#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#'}};

// Basic function to print grid
void printGrid() {

      printf("\n\n\n\n\n\n\n");

      for (int i = 0; i < 20; i++) {
            
            for (int j = 0; j < 20; j++) {

                  printf("%c ", grid[i][j]);

            }

            printf("\n");

      }

}

/*
/ I had initially planned for this function to be split up into each respective part and have the switch
/ statement in the main function, although I found this way used less lines and generally kept the clutter
/ out of main (I will most likely update key/number counters here as well and use functions to check 
/ the status to see if the next tile, grid[x1][y1] will be a door/key/number)                             
*/
void move(char grid[][20], char dir, char *player, int *x, int *y, int keyVal[2]) {

      int x1, y1;
      bool doMove = false;

      switch(dir) {
            case 'w':
            case 'W':
                  y1 = *y-1;
                  x1 = *x;
                  doMove = true;
                  break;
            case 'a':
            case 'A':
                  x1 = *x-1;
                  y1 = *y;
                  doMove = true;
                  break;
            case 's':
            case 'S':
                  y1 = *y+1;
                  x1 = *x;
                  doMove = true;
                  break;
            case 'd':
            case 'D':
                  x1 = *x+1;
                  y1 = *y;
                  doMove = true;
                  break;
            case 'q':
            case 'Q':
                  break;
      }


      switch(grid[y1][x1]) {
            case ' ':
                  break;
            case 'x':
                  keyVal[0]++;
                  break;
            case 'y':
                  keyVal[1]++;
                  break;
            case 'X':
                  if (keyVal[0] >= 1) {

                        keyVal[0]--;

                  } 
                  else {

                        doMove = false;

                  }
                  break;
            case 'Y':
                  if (keyVal[1] >= 1) {

                        keyVal[1]--;

                  }
                  else {

                        doMove = false;

                  }
                  break;
            default:
                  doMove = false;
                  break;
      }

      if (isdigit(grid[y1][x1])) {

            *player = *player + (grid[y1][x1] - 48);
            doMove = true;

      }

      if (doMove) {

            grid[*y][*x] = ' ';
            grid[y1][x1] = *player;
            *x = x1;
            *y = y1;

      }


};

int main() {

      char userInput;
      bool hasWon = false;
      int x = 1, y = 1;
      int keyVal[2] = {0, 0};
      char player = '0';

      while (userInput != 'q' && !hasWon) {

            printGrid();

            printf("\n\n\nINPUT WASD TO MOVE: ");
            scanf("%c", &userInput);

            move(grid, userInput, &player, &x , &y, keyVal);
            printf("\nPOS : %d %d", x, y);
            printf("\nKEYS IN INVENTORY : ");
            printf(keyVal[0] >= 1 ? "X  " : "");
            printf(keyVal[1] >= 1 ? "Y" : "");
            if (x == 18 && y == 18) {

                  hasWon = true;

            }

     }

      return 0;
}