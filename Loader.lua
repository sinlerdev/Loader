local Loader = {}

local function isModuleScript(instance : Instance)
	return instance:IsA("ModuleScript")
end

local function load(tbl, filter)
	local RequiredModules = table.create(#tbl)
	for _, ModuleScript : ModuleScript in tbl do
		if filter == nil or (filter(ModuleScript) == true) and isModuleScript(ModuleScript) then
			table.insert(RequiredModules,require(ModuleScript))
		end
	end

	return RequiredModules
end

function Loader.loadChildren(Parent : Instance, filter : (ModuleScript) -> {ModuleScript})
	return load(Parent:GetChildren(), filter)
end

function Loader.loadDescendants(Parent : Instance, filter : (ModuleScript) -> {ModuleScript})
	return load(Parent:GetDescendants(), filter)

end

function Loader.SpawnAll(LoaderFunction, Methodname)
	local RequiredModules = LoaderFunction
	
	for _, Module in RequiredModules do
		Module[Methodname]()
	end
	
end

return Loader