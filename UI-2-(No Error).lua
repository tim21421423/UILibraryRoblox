-- ExploitUILibrary.lua
-- UI library for Roblox exploits, loadable via loadstring

local ExploitUILibrary = {}

-- Safely get a service
local function safeGetService(serviceName)
    return game:GetService(serviceName) or error("Failed to get service: " .. serviceName)
end

-- Create main window
function ExploitUILibrary:CreateWindow(name, size, position)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = name or "ExploitUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = safeGetService("CoreGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = size or UDim2.new(0, 300, 0, 400)
    mainFrame.Position = position or UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10) -- UICorner 10 degrees
    uiCorner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Text = name or "Exploit UI"
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 10)
    titleCorner.Parent = title

    -- Enable dragging
    local dragging, dragInput, dragStart, startPos
    title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    return mainFrame, screenGui
end

-- Create button
function ExploitUILibrary:CreateButton(parent, name, size, position, text, labelText, callback)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Name = name or "ButtonFrame"
    buttonFrame.Size = size or UDim2.new(0.9, 0, 0, 40)
    buttonFrame.Position = position or UDim2.new(0.05, 0, 0, 0)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = parent

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.7, 0, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = text or "Click Me"
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = buttonFrame

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 9) -- UICorner 9 degrees
    uiCorner.Parent = button

    if labelText then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.3, 0, 1, 0)
        label.Position = UDim2.new(0.7, 5, 0, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Text = labelText
        label.Font = Enum.Font.SourceSans
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = buttonFrame
    end

    if callback then
        button.MouseButton1Click:Connect(callback)
    end

    return buttonFrame
end

-- Create exit button
function ExploitUILibrary:CreateExitButton(parent, screenGui, size, position)
    local exitButton = Instance.new("TextButton")
    exitButton.Name = "ExitButton"
    exitButton.Size = size or UDim2.new(0, 30, 0, 30)
    exitButton.Position = position or UDim2.new(1, -40, 0, 5)
    exitButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    exitButton.Text = "X"
    exitButton.Font = Enum.Font.SourceSansBold
    exitButton.TextSize = 16
    exitButton.Parent = parent

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 9) -- UICorner 9 degrees
    uiCorner.Parent = exitButton

    exitButton.MouseButton1Click:Connect(function()
        screenGui:Destroy() -- Destroy the entire UI
    end)

    return exitButton
end

-- Create textbox
function ExploitUILibrary:CreateTextBox(parent, name, size, position, placeholder, labelText, callback)
    local textBoxFrame = Instance.new("Frame")
    textBoxFrame.Name = name or "TextBoxFrame"
    textBoxFrame.Size = size or UDim2.new(0.9, 0, 0, 40)
    textBoxFrame.Position = position or UDim2.new(0.05, 0, 0, 0)
    textBoxFrame.BackgroundTransparency = 1
    textBoxFrame.Parent = parent

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.7, 0, 1, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.PlaceholderText = placeholder or "Enter text..."
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 16
    textBox.Parent = textBoxFrame

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8) -- UICorner 8 degrees
    uiCorner.Parent = textBox

    if labelText then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.3, 0, 1, 0)
        label.Position = UDim2.new(0.7, 5, 0, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Text = labelText
        label.Font = Enum.Font.SourceSans
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = textBoxFrame
    end

    if callback then
        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(textBox.Text)
            end
        end)
    end

    return textBoxFrame
end

-- Create checkbox
function ExploitUILibrary:CreateCheckBox(parent, name, size, position, labelText, callback)
    local checkBoxFrame = Instance.new("Frame")
    checkBoxFrame.Name = name or "CheckBoxFrame"
    checkBoxFrame.Size = size or UDim2.new(0.9, 0, 0, 30)
    checkBoxFrame.Position = position or UDim2.new(0.05, 0, 0, 0)
    checkBoxFrame.BackgroundTransparency = 1
    checkBoxFrame.Parent = parent

    local checkBox = Instance.new("Frame")
    checkBox.Size = UDim2.new(0, 20, 0, 20)
    checkBox.Position = UDim2.new(0, 0, 0.5, -10)
    checkBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    checkBox.Parent = checkBoxFrame

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8) -- UICorner 8 degrees
    uiCorner.Parent = checkBox

    local checkMark = Instance.new("TextButton")
    checkMark.Size = UDim2.new(0, 14, 0, 14)
    checkMark.Position = UDim2.new(0.5, -7, 0.5, -7)
    checkMark.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    checkMark.Text = ""
    checkMark.Parent = checkBox

    local checkMarkCorner = Instance.new("UICorner")
    checkMarkCorner.CornerRadius = UDim.new(0, 6)
    checkMarkCorner.Parent = checkMark

    local isChecked = false
    checkMark.MouseButton1Click:Connect(function()
        isChecked = not isChecked
        checkMark.BackgroundColor3 = isChecked and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
        if callback then
            callback(isChecked)
        end
    end)

    if labelText then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 200, 1, 0)
        label.Position = UDim2.new(0, 30, 0, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Text = labelText
        label.Font = Enum.Font.SourceSans
        label.TextSize = 14
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = checkBoxFrame
    end

    return checkBoxFrame
end

-- Create label
function ExploitUILibrary:CreateLabel(parent, name, size, position, text)
    local label = Instance.new("TextLabel")
    label.Name = name or "Label"
    label.Size = size or UDim2.new(0.9, 0, 0, 30)
    label.Position = position or UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Text = text or "Label"
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent

    return label
end

-- Create tabs
function ExploitUILibrary:CreateTabs(parent, name, size, position, tabs)
    local tabsFrame = Instance.new("Frame")
    tabsFrame.Name = name or "TabsFrame"
    tabsFrame.Size = size or UDim2.new(0.9, 0, 0, 40)
    tabsFrame.Position = position or UDim2.new(0.05, 0, 0, 0)
    tabsFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabsFrame.Parent = parent

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8) -- UICorner 8 degrees
    uiCorner.Parent = tabsFrame

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 40)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = tabsFrame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = Enum.FillDirection.Horizontal
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Parent = tabContainer

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -50)
    contentFrame.Position = UDim2.new(0, 0, 0, 50)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = tabsFrame

    local tabContents = {}
    for i, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1/#tabs, 0, 0, 40)
        tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Text = tabName
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 16
        tabButton.Parent = tabContainer

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabButton

        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = (i == 1)
        tabContent.Parent = contentFrame
        tabContents[tabName] = tabContent

        tabButton.MouseButton1Click:Connect(function()
            for _, content in pairs(tabContents) do
                content.Visible = false
            end
            tabContent.Visible = true
        end)
    end

    return tabContents
end

-- Toggle window visibility
function ExploitUILibrary:ToggleWindow(window)
    window.Visible = not window.Visible
end

return ExploitUILibrary
