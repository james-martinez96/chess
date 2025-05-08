local Utils = {}
Utils.__index = Utils

--- Print the chess board
function Utils.printBoard(board)
    print("\n  +------------------------+")
    for row = 1, 8 do
        local displayRow = 9 - row -- display 8 at the top and 1 at the bottom
        io.write(displayRow .. " | ")
        for col = 1, 8 do
            local piece = board[row][col]
            if piece == "" then
                io.write(" . ")
            else
                io.write(piece .. " ")
            end
        end
        print("|")
    end
    print("  +------------------------+")
    print("    a  b  c  d  e  f  g  h")
end

return Utils
