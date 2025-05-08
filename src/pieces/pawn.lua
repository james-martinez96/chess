local Pawn = {}
Pawn.__index = Pawn

--- Check to see if pawn move is valid
--- @return boolean
function Pawn.isValidPawnMove(row, col, newRow, newCol, color)
    -- Make sure destination is in bounds
    if not isInBounds(newRow, newCol) then return false end

    -- row 1 is at the top of the board internally
    -- white pawns start at row 7, and black at row 2
    local direction = color == "white" and -1 or 1
    local startRow = color == "white" and 7 or 2
    local target = board[newRow][newCol]

    print(string.format("Checking %s pawn from (%d, %d) to (%d, %d)", color, row, col, newRow, newCol))
    print("Target square:", target)

    -- Forward move (one square)
    if col == newCol and newRow == row + direction and target == "" then
        print("One-step forward valid")
        return true
    end

    -- First move (two square)
     if col == newCol and row == startRow and newRow == row + 2 * direction and target == "" and board[row + direction][col] == "" then
            print("Two-step forward is valid")
            return true
        end

    -- Diagonal capture move
    if math.abs(col - newCol) == 1 and newRow == row + direction and target ~= "" then
        if (color == "white" and target:sub(1,1) == "b") or (color == "black" and target:sub(1,1) == "w") then
            print("Diagonal capture valid")
            return true
        end
    end

    print("Move invalid\n")
    return false
end

return Pawn
