local util = require("me.core.util")

local M = {}

local projects = {} -- list of projects
local data_dir = vim.fn.stdpath("cache") .. "/project" -- where plugin data is stored.

if vim.fn.isdirectory(data_dir) == 0 then
	vim.fn.mkdir(data_dir)
end

function M.get_projects()
	return projects
end

function M.get_projects_names()
	local names = {}
	for i = 1, #projects do
		names[#names + 1] = projects[i].name
	end
	return names
end

function M.get_project(name)
	for i = 1, #projects do
		if projects[i].name == name then
			return projects[i]
		end
	end
	return nil
end

function M.add_project(name, path)
	if M.get_project(name) ~= nil then
		vim.notify(
			"[PROJECT] Project '" .. name .. "' already exists.",
			vim.log.levels.ERROR
		)
		return
	end
	projects[#projects + 1] = { name = name, path = path }
	vim.notify("[PROJECT] Project '" .. name .. "' was added succesfully.")
end

function M.delete_project(name)
	for i = 1, #projects do
		if projects[i].name == name then
			table.remove(projects, i)
			vim.notify("[PROJECT] Project '" .. name .. "' succesfully removed.")
		end
	end
	vim.notify("[PROJECT] Project '" .. name .. "' doesn't exist", vim.log.levels.ERROR)
end

function M.read_projects()
	-- No file, no projects to read into memory
	if vim.fn.filereadable(data_dir .. "/projects") == 0 then
		return
	end
	local lines = vim.fn.readfile(data_dir .. "/projects")
	for i = 1, #lines do
		local components = util.split(lines[i], " ")
		local name, path = components[1], components[2]
		projects[#projects + 1] = { name = name, path = path }
	end
end

function M.write_projects()
	local lines = {}
	for i = 1, #projects do
		lines[#lines + 1] = projects[i].name .. " " .. projects[i].path
	end
	vim.fn.writefile(lines, data_dir .. "/projects")
end
return M
