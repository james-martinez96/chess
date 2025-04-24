function love.load()
    love.window.setTitle("Chess Engine")
    love.window.setMode(640, 640)
    font = love.graphics.newFont(32)

    tileSize = 80
    selected = nil

    board = {
        {"br","bn","bb","bq","bk","bb","bn","br"},
        {"bp","bp","bp","bp","bp","bp","bp","bp"},
        {"","","","","","","",""},
        {"","","","","","","",""},
        {"","","","","","","",""},
        {"","","","","","","",""},
        {"wp","wp","wp","wp","wp","wp","wp","wp"},
        {"wr","wn","wb","wq","wk","wb","wn","wr"}
    }

    -- Load piece sprites
    pieces = {}
    local names = {"bp","br","bn","bb","bq","bk","wp","wr","wn","wb","wq","wk"}
    for _, name in ipairs(names) do
        pieces[name] = love.graphics.newImage("assets/" .. name .. ".png")
    end
end

function printBoard()
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

function isInBounds(row, col)
    return row >= 1 and row <= 8 and col >= 1 and col <= 8
end

function isFriendlyPiece(row, col, color)
    -- Check if the piece at the position belongs to the same color
    local piece = board[row][col]
    if piece == "" then
        return false
    end
    return (color == "white" and piece:sub(1, 1) == "w") or (color == "black" and piece:sub(1, 1) == "b")
end

function isValidPawnMove(row, col, newRow, newCol, color)
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

function drawBoard()
    --Draw board
    local tileSize = 80
    for row = 1, 8 do
        for col = 1, 8 do
            -- color the board
            if (row + col) % 2 == 0 then
                love.graphics.setColor(0.9, 0.9, 0.9)
            else
                love.graphics.setColor(0.2, 0.2, 0.2)
            end
            love.graphics.rectangle("fill", (col-1)*tileSize, (row-1)*tileSize, tileSize, tileSize)

            -- selected piece color
            if selected and selected[1] == row and selected[2] == col then
                love.graphics.setColor(1,0,0,0.5) -- red highlight
                love.graphics.rectangle("fill", (col-1)*tileSize, (row-1)*tileSize, tileSize, tileSize)
            end
        end
    end
end

function drawPieces()
    for row = 1, 8 do
        for col = 1, 8 do
            local piece = board[row][col]
            if piece ~= "" and pieces[piece] then
                local x = (col - 1) * tileSize
                local y = (row - 1) * tileSize
                love.graphics.setColor(1,1,1)
                love.graphics.draw(pieces[piece], x, y, 0, tileSize / pieces[piece]:getWidth())
            end
        end
    end
end

function love.mousepressed(x, y, button)
    if button == 1 then -- left click
        local col = math.floor(x / tileSize) + 1
        local row = math.floor(y / tileSize) + 1

        if selected then
            local fromRow, fromCol = selected[1], selected[2]
            local piece = board[fromRow][fromCol]
            local color = piece:sub(1, 1) == "w" and "white" or "black"
            local type = piece:sub(2, 2)
            print(piece, color, type)

            local valid = false

            if type == "p" then
                valid = isValidPawnMove(fromRow, fromCol, row, col, color)
                -- print(string.format("Trying to move %s pawn from (%d, %d) to (%d, %d)", color, fromRow, fromCol, row, col))
                -- print("Valid move:", valid)
            else
                -- Other pieces always valid (no validation yet)
                valid = true
            end

            if valid then
                board[row][col] = piece
                board[fromRow][fromCol] = ""
                printBoard()
            end

            selected = nil
        else
            -- Select piece
            if board[row][col] ~= "" then
                selected = {row, col}
            end
        end
    end
end

function love.draw()
    drawBoard()
    drawPieces()
end
