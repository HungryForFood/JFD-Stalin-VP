-- JFD_Civs_SovietUnionStalin_Functions
-- Author: JFD
-- DateCreated: 5/6/2014 4:50:19 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  = Locale.ConvertTextKey
local g_MapGetPlot		= Map.GetPlot
local g_MathCeil		= math.ceil
local g_MathFloor		= math.floor
local g_MathMax			= math.max
local g_MathMin			= math.min
				
local Players 			= Players
local HexToWorld 		= HexToWorld
local ToHexFromGrid 	= ToHexFromGrid
local Teams 			= Teams
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- CORE UTILITIES
----------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local g_IsCPActive = (Game_IsCPActive() and Player.HasStateReligion)
----------------------------------------------------------------------------------------------------------------------------
--HasTrait
function HasTrait(player, traitID)
	if Player.HasTrait then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
-- GAME UTILITIES
----------------------------------------------------------------------------------------------------------------------------
local traitSovietUnionID = GameInfoTypes["TRAIT_JFD_SOVIET_UNION_STALIN"]

--IsAllyWithSovietUnion
function IsAllyWithSovietUnion(player)
	local ideologyID = player:GetLateGamePolicyTree()
	if player:IsMinorCiv() then
		local playerAllyID = player:GetAlly() 
		if playerAllyID > -1 then
			local playerAlly = Players[playerAllyID]
			if HasTrait(playerAlly, traitSovietUnionID) then
				return true
			end
		end
	elseif (ideologyID > -1 and player:IsPolicyBranchUnlocked(ideologyID)) then
		return true
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
local defineMaxMinorCivs = GameDefines["MAX_MINOR_CIVS"]

--IsAtWarWithSovietUnion
function IsAtWarWithSovietUnion(player)
	local isAtWar = false
	local playerTeamID = player:GetTeam()
	for otherPlayerID = 0, 63 - 1 do
		local otherPlayer = Players[otherPlayerID]
		if otherPlayer:IsAlive() then
			if Teams[otherPlayer:GetTeam()]:IsAtWar(playerTeamID) then
				if HasTrait(otherPlayer, traitSovietUnionID) then
					isAtWar = true
					break
				end
			end
		end
	end
	return isAtWar
end
--==========================================================================================================================
-- GAME DEFINES
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- INIT
----------------------------------------------------------------------------------------------------------------------------
--g_Civilization_FreePolicies_Table
local g_Civilization_FreePolicies_Table = {}
local g_Civilization_FreePolicies_Count = 1
for row in DB.Query("SELECT * FROM Civilization_FreePolicies;") do 	
	g_Civilization_FreePolicies_Table[g_Civilization_FreePolicies_Count] = row
	g_Civilization_FreePolicies_Count = g_Civilization_FreePolicies_Count + 1
end

--JFD_LoadScreenClose
local function JFD_LoadScreenClose()
	for playerID = 0, defineMaxMajorCivs - 1 do
		local player = Players[playerID]
		if player:IsAlive() then

			--g_Civilization_FreePolicies_Table
			local policiesTable = g_Civilization_FreePolicies_Table
			local numPolicies = #policiesTable
			for index = 1, numPolicies do
				local row = policiesTable[index]
				local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
				if civType == row.CivilizationType then
					local policyID = GameInfoTypes[row.PolicyType]
					if (not player:HasPolicy(policyID)) then
						if Player.GrantPolicy then 
							player:GrantPolicy(policyID, true)
						else
							player:SetNumFreePolicies(1)
							player:SetNumFreePolicies(0)
							player:SetHasPolicy(policyID, true)
						end
					end
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(JFD_LoadScreenClose)
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
----------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local buildingPeoplesCommissariatID = GameInfoTypes["BUILDING_JFD_PEOPLES_COMMISSARIAT"]
local civilizationSovietUnionID = GameInfoTypes["CIVILIZATION_JFD_SOVIET_UNION_STALIN"]
local unitTS2ID = GameInfoTypes["UNIT_JFD_TS2"]
----------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------
--JFD_SovietUnion_PlayerDoTurn
local buildingPeoplesCommissariatProductionID = GameInfoTypes["BUILDING_JFD_PEOPLES_COMMISSARIAT_PRODUCTION"]
local promotionSovietUnionID = GameInfoTypes["PROMOTION_JFD_SOVIET_UNION_STALIN"]
local function JFD_SovietUnion_PlayerDoTurn(playerID)
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	if (not player:IsAlive()) then return end
	--if player:IsBarbarian() then return end
	
	--WARSAW PACT
	if (not g_IsCPActive) and IsAtWarWithSovietUnion(player) then
		for unit in player:Units() do
			local isInSovietBorders = false
			local plot = g_MapGetPlot(unit:GetX(), unit:GetY())
			if plot then
				local plotOwnerID = plot:GetOwner()
				if plotOwnerID > -1 then
					local playerOwner = Players[plotOwnerID]
					if (HasTrait(playerOwner, traitSovietUnionID) or IsAllyWithSovietUnion(playerOwner)) then
						isInSovietBorders = true
					end
				end
			end
			unit:SetHasPromotion(promotionSovietUnionID, isInSovietBorders)
		end
	end

	--PEOPLE'S COMMISSARIAT
	local numAllies = 0
	if HasTrait(player, traitSovietUnionID) then
		for otherPlayerID = 0, defineMaxMinorCivs - 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsMinorCiv() and otherPlayer:IsAlive() then
				if otherPlayer:GetAlly() == playerID then
					numAllies = numAllies + 1
				end
			end
		end
		for city in player:Cities() do
			city:SetNumRealBuilding(buildingPeoplesCommissariatProductionID, 0) 
			if city:IsHasBuilding(buildingPeoplesCommissariatID) then
				if city:IsCapital() then
					city:SetNumRealBuilding(buildingPeoplesCommissariatProductionID, numAllies*2, true)
				else
					city:SetNumRealBuilding(buildingPeoplesCommissariatProductionID, numAllies, true)
				end
			end	
		end	
	end
end
GameEvents.PlayerDoTurn.Add(JFD_SovietUnion_PlayerDoTurn)	
--=======================================================================================================================
--=======================================================================================================================