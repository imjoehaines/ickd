local colour1 = 'ffFF9900'
local colour2 = 'ffFFCC33'

local function listTasks ()
  if #ickdToDoTasks > 0 then
    print('|c' .. colour1 .. 'ickd:|r Your to do list:')

    for i,v in pairs(ickdToDoTasks) do
      print(i .. '. |c' .. colour2 .. v .. '|r')
    end
  else
    print('|c' .. colour1 .. 'ickd:|r You don\'t have any tasks in your to do list, congrats!')
  end
end

local function addTask (task)
  if task == nil or task == '' then
    print('|c' .. colour2 .. 'Oops|r! You didn\'t give a task, please try again.')
  else
    print('|c' .. colour1 .. 'ickd:|r Added "|c' .. colour2 .. task .. '|r" to your to do list!')
    table.insert(ickdToDoTasks, task)
  end
end

local function removeTask (task)
  if #ickdToDoTasks == 0 then
    print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! There aren\'t any tasks on your to do list!')
  else
    task = tonumber(task)
    if type(task) ~= 'number' then
      print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! You need to give the number of the task to remove, please try again.')
    elseif task == nil or task == '' or task <= 0 then
      print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! You didn\'t give a task, please try again.')
    elseif not ickdToDoTasks[task] then
      print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! There\'s no task number "|c' .. colour2 .. task .. '|r", please try again.')
    else
      print('|c' .. colour1 .. 'ickd:|r Removed "|c' .. colour2 .. ickdToDoTasks[task] .. '|r" from your to do list!')
      table.remove(ickdToDoTasks, task)
    end
  end
end

local function editTask (stuff)
  local task, edit = stuff:match('^(%S*)%s*(.-)$')

  if #ickdToDoTasks == 0 then
    print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! There aren\'t any tasks on your to do list!')
  else
    task = tonumber(task)
    if type(task) ~= 'number' then
      print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! You need to give the number of the task to edit, please try again.')
    elseif task == nil or task == '' or task <= 0 then
      print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! You didn\'t give a task, please try again.')
    elseif edit == nil or edit == '' then
      print('|c' .. colour1 .. 'ickd:|r |c' .. colour2 .. 'Oops|r! You didn\'t give an edit to the task, please try again.')
    else
      print('|c' .. colour1 .. 'ickd:|r Edited task "|c' .. colour2 .. task .. '|r" to "|c' .. colour2 .. edit .. '|r"!')
      table.remove(ickdToDoTasks, task)
      table.insert(ickdToDoTasks, task, edit)
    end
  end

end

local function clearList ()
  print('|c' .. colour1 .. 'ickd:|r Your to do list has been cleared!')
  ickdToDoTasks = {}
end


local function help ()
  print('|c' .. colour1 .. 'ickd|r to do list help:')
  print('|c' .. colour2 .. ' list |r- lists the tasks currently on your to do list')
  print('|c' .. colour2 .. ' add |r|cffffff66 <a task> |r- adds a task to your to do list')
  print('|c' .. colour2 .. ' remove |r|cffffff66 <task number> |r- removes a task on your to do list')
  print('|c' .. colour2 .. ' edit |r|cffffff66 <task number> <edited task> |r- edits a task on your to do list')
  print('|c' .. colour2 .. ' clear |r- removes every task on your to do list - |cffffff66be careful!|r')
  print('All commands will work with just their first letter (eg. |c' .. colour2 .. 'a|r = |c' .. colour2 .. 'add|r)')
end

SLASH_ickd1, SLASH_ickd2 = '/td', '/ickd'
function SlashCmdList.ickd (msg)
  local command, rest = msg:match('^(%S*)%s*(.-)$')
  command = strlower(command)

  if command == 'help' or command =='h' then
    help()
  elseif command == '' or command == 'list' or command == 'l' then
    listTasks()
  elseif command == 'add' or command == 'a' then
    addTask(rest)
  elseif command == 'rem' or command == 'remove' or command == 'r' or command == 'del' or command == 'delete' or command == 'd' then
    removeTask(rest)
  elseif command == 'edit' or command == 'e' then
    editTask(rest)
  elseif command == 'clear' then
    clearList()
  else
    print('|c' .. colour1 .. 'ickd:|r Oops! The command "' .. msg .. '" was not recognised.')
  end
end

local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')

f:SetScript('OnEvent', function (self, event, addon, ...)
  if (addon ~= 'ickd') then return end

  ickdToDoTasks = ickdToDoTasks or {}

  listTasks()
  f:UnregisterEvent('ADDON_LOADED')
end)
