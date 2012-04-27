#!/usr/bin/lua

local exec_path = arg[0]:match('(.-/)main.lua') or ''

local function new_project(template, name)
    local project_templates = require(exec_path .. 'project_templates')
    return project_templates[template](name)
end

local do_action = {
    ['-n'] = new_project,
}

do_action[arg[1]](unpack(arg, 2))
