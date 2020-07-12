module tictactoe.main;

import std.stdio;

void main()
{
    char[3][3] board = ' ';

    writeln("--- TIC TAC TOE ---");

    bool cross = false;

    game: while (true)
    {
        cross = !cross;
        printBoard(board);

        int column;
        int row;

        bool illegalMove;
        do
        {
            illegalMove = false;

            write(cross ? 'X' : 'O', " Column: ");
            readf(" %s", column);
            write(cross ? 'X' : 'O', " Row: ");
            readf(" %s", row);

            if (row < 0 || row > 2 || column < 0 || column > 2 || board[row][column] != ' ')
            {
                writeln("Illegal move");
                illegalMove = true;
            }
        }
        while (illegalMove);

        board[row][column] = cross ? 'X' : 'O';

        if (isWin(board, column, row, cross ? 'X' : 'O'))
        {
            printBoard(board);
            writeln(cross ? 'X' : 'O', " won!");
            break game;
        }

        bool draw = true;

        boardIterator: foreach (char[] rowArr; board)
        {
            foreach (char field; rowArr)
            {
                if (field == ' ')
                {
                    draw = false;
                    break boardIterator;
                }
            }
        }

        if (draw)
        {
            printBoard(board);
            writeln("Draw");
            break game;
        }
    }
}

private @safe nothrow bool isWin(char[3][3] board, int column, int row, char symbol)
{
    foreach (i; 0 .. 3)
    {
        if (board[row][i] != symbol)
        {
            goto rows;
        }
    }
    return true;

    rows: foreach (i; 0 .. 3)
    {
        if (board[i][column] != symbol)
        {
            goto diagonalLeft;
        }
    }
    return true;

    diagonalLeft: foreach (i; 0 .. 3)
    {
        if (board[i][i] != symbol)
        {
            goto diagonalRight;
        }
    }
    return true;

    diagonalRight: foreach (i; 0 .. 3)
    {
        if (board[2 - i][i] != symbol)
        {
            return false;
        }
    }
    return true;
}

@safe nothrow unittest
{
    char[3][3] board = [
        ['O', 'O', ' '],
        ['X', 'X', ' '],
        [' ', 'X', 'O']
    ];
    assert(!isWin(board, 1, 1, 'X'));

    char[3][3] board1 = 'X';
    assert(isWin(board1, 1, 1, 'X'));

    char[3][3] board2 = [
        ['O', 'X', ' '],
        ['X', 'O', ' '],
        [' ', 'X', 'O']
    ];
    assert(isWin(board2, 2, 2, 'O'));

    char[3][3] board3 = [
        ['O', ' ', 'X'],
        [' ', 'X', ' '],
        ['X', 'O', 'O']
    ];
    assert(isWin(board3, 1, 1, 'X'));
}

private void printBoard(char[3][3] board)
{
    writeln(board[0][0], '|', board[0][1], '|', board[0][2]);
    writeln("-----");
    writeln(board[1][0], '|', board[1][1], '|', board[1][2]);
    writeln("-----");
    writeln(board[2][0], '|', board[2][1], '|', board[2][2]);
}
