#!/usr/bin/lua

local exec_path = arg[0]:match('(.-)/main.lua')

local project_templates = require(exec_path .. '/project_templates')

local function new_project(name, template)
    return project_templates[template](name)
end
