--=======================================================================================================================
-- MASTER TABLES
--=======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CustomModOptions(Name Text, Value INTEGER, Class INTEGER, DbUpdates INTEGER);
CREATE TABLE IF NOT EXISTS JFD_GlobalUserSettings (Type text, Value integer default 1);
--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses
		(Type, 										DefaultBuilding, 					 Description)
VALUES	('BUILDINGCLASS_JFD_SOVIET_UNION_STALIN', 	'BUILDING_JFD_SOVIET_UNION_STALIN',  'TXT_KEY_BUILDING_JFD_SOVIET_UNION_STALIN');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
------------------------------------------------------------------------------------------------------------------------
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 	
		(Type, 									BuildingClass, Cost, GoldMaintenance,   SpecialistType, SpecialistCount, PrereqTech, EspionageModifier, Espionage, Description, 										Civilopedia, 											Help, 												Strategy,								 				ArtDefineTag, MinAreaSize, NeverCapture, HurryCostModifier, IconAtlas,					   PortraitIndex)
SELECT	'BUILDING_JFD_PEOPLES_COMMISSARIAT',	BuildingClass, Cost, GoldMaintenance+1, SpecialistType, SpecialistCount, PrereqTech, EspionageModifier, Espionage, 'TXT_KEY_BUILDING_JFD_PEOPLES_COMMISSARIAT_DESC', 	'TXT_KEY_BUILDINGS_JFD_STALIN_COMMISSARIAT_TEXT', 	'TXT_KEY_BUILDING_JFD_PEOPLES_COMMISSARIAT_HELP', 	'TXT_KEY_BUILDING_JFD_PEOPLES_COMMISSARIAT_STRATEGY',	ArtDefineTag, MinAreaSize, NeverCapture, HurryCostModifier, 'JFD_SOVIET_UNION_STALIN_ICON_ATLAS', 2
FROM Buildings WHERE Type = 'BUILDING_POLICE_STATION';	
------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges
		(BuildingType, 							YieldType, Yield)
SELECT	'BUILDING_JFD_PEOPLES_COMMISSARIAT',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_POLICE_STATION';
--------------------------------------------------------------------------------------------------------------------------	
-- Building_ClassesNeededInCity
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 							BuildingClassType)
SELECT	'BUILDING_JFD_PEOPLES_COMMISSARIAT',	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_POLICE_STATION';	
------------------------------------------------------------------------------------------------------------------------	
-- Building_Flavors
------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_Flavors 
		(BuildingType, 							FlavorType, 				Flavor)
VALUES	('BUILDING_JFD_PEOPLES_COMMISSARIAT', 	'FLAVOR_ESPIONAGE', 		25),
		('BUILDING_JFD_PEOPLES_COMMISSARIAT', 	'FLAVOR_HAPPINESS', 		75),
		('BUILDING_JFD_PEOPLES_COMMISSARIAT', 	'FLAVOR_MILITARY_TRAINING', 50);	
------------------------------------------------------------------------------------------------------------------------
-- Buildings
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings 	
		(Type, 						 						BuildingClass, 								GreatWorkCount, Cost, FaithCost, PrereqTech, NeverCapture,	NukeImmune, Description, 												Help)
VALUES	('BUILDING_JFD_PEOPLES_COMMISSARIAT_PRODUCTION',	'BUILDINGCLASS_JFD_SOVIET_UNION_STALIN', 	-1,				-1,   -1, 		 null, 		 1,				1,			'TXT_KEY_BUILDING_JFD_PEOPLES_COMMISSARIAT_PRODUCTION', 	'TXT_KEY_BUILDING_JFD_PEOPLES_COMMISSARIAT_PRODUCTION_HELP');
------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Building_YieldChanges 
		(BuildingType, 									  YieldType,			Yield)
VALUES	('BUILDING_JFD_PEOPLES_COMMISSARIAT_PRODUCTION',  'YIELD_PRODUCTION',   1);	
------------------------------------------------------------------------------------------------------------------------	
-- Building_CityToolTipYieldFromOther
------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Building_CityToolTipYieldFromOther(BuildingType, YieldType, Yield integer);
INSERT INTO Building_CityToolTipYieldFromOther
		(BuildingType, 										YieldType,			Yield)
VALUES	('BUILDING_JFD_PEOPLES_COMMISSARIAT_PRODUCTION',	'YIELD_PRODUCTION',	1);
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions 
		(Type, 					Description, 					Help, 								Sound, 				AttackFortifiedMod,	DefenseMod,	CannotBeChosen, PortraitIndex, 	IconAtlas, 		   PediaType, 		   PediaEntry)
VALUES	('PROMOTION_JFD_IS2_1',	'TXT_KEY_PROMOTION_JFD_IS2_1', 	'TXT_KEY_PROMOTION_JFD_IS2_1_HELP', 'AS2D_IF_LEVELUP',	15,					0,			1, 				59, 			'ABILITY_ATLAS',  'PEDIA_ATTRIBUTES',  'TXT_KEY_PROMOTION_JFD_IS2_1'),
		('PROMOTION_JFD_IS2_2',	'TXT_KEY_PROMOTION_JFD_IS2_2', 	'TXT_KEY_PROMOTION_JFD_IS2_2_HELP', 'AS2D_IF_LEVELUP',	0,					20,			1, 				59, 			'ABILITY_ATLAS',  'PEDIA_ATTRIBUTES',  'TXT_KEY_PROMOTION_JFD_IS2_2');
--------------------------------------------------------------------------------------------------------------------------	
-- UnitPromotions_UnitCombatMods
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO UnitPromotions_UnitCombatMods 	
		(PromotionType, 		UnitCombatType,		Modifier)
VALUES	('PROMOTION_JFD_IS2_1',	'UNITCOMBAT_ARMOR',	10),
		('PROMOTION_JFD_IS2_1',	'UNITCOMBAT_GUN',	10);
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Units 	
		(Type, 				Class, PrereqTech, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 				Help, 							Strategy, 							Civilopedia, 					MilitarySupport, MilitaryProduction, ObsoleteTech, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, XPValueDefense, UnitArtInfoEraVariation, Mechanized, MoveRate, UnitArtInfo, 				UnitFlagIconOffset, UnitFlagAtlas, 								IconAtlas,								PortraitIndex)
SELECT	'UNIT_JFD_IS2',		Class, PrereqTech, Combat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_IS2', 	'TXT_KEY_UNIT_HELP_JFD_IS2', 	'TXT_KEY_UNIT_JFD_IS2_STRATEGY', 	'TXT_KEY_UNITS_JFD_IS2_TEXT', 	MilitarySupport, MilitaryProduction, ObsoleteTech, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, XPValueDefense, UnitArtInfoEraVariation, Mechanized, MoveRate, 'ART_DEF_UNIT_JFD_IS2',	0,					'JFD_SOVIET_UNION_STALIN_UNIT_FLAG_ATLAS',  'JFD_SOVIET_UNION_STALIN_ICON_ATLAS',	3
FROM Units WHERE Type = 'UNIT_TANK';
--------------------------------------------------------------------------------------------------------------------------	
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 			SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_IS2', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_TANK';	
--------------------------------------------------------------------------------------------------------------------------		
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Unit_AITypes 	
		(UnitType, 			UnitAIType)
SELECT	'UNIT_JFD_IS2',		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_TANK';
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 			UnitClassType)
SELECT	'UNIT_JFD_IS2',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_TANK';	
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Unit_Flavors 	
		(UnitType, 			FlavorType, Flavor)
SELECT	'UNIT_JFD_IS2',		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_TANK';	
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 			ResourceType, Cost)
SELECT	'UNIT_JFD_IS2',		ResourceType, Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_TANK';	
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 			PromotionType)
SELECT	'UNIT_JFD_IS2',		PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_TANK';	

INSERT INTO Unit_FreePromotions 	
		(UnitType, 			PromotionType)
VALUES	('UNIT_JFD_IS2',	'PROMOTION_JFD_IS2_1'),
		('UNIT_JFD_IS2',	'PROMOTION_JFD_IS2_2');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Leaders
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 								Description, 								Civilopedia, 									CivilopediaTag, 										ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 								PortraitIndex)
VALUES	('LEADER_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_PEDIA', 'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_SOVIET_UNION_STALIN', 	'JFD_SovietUnionStalin_Scene.xml',	7, 						3, 						9, 							9, 			4, 				3, 				6, 						4, 				3, 			1, 			2, 				4, 			9, 			'JFD_SOVIET_UNION_STALIN_ICON_ATLAS', 	1);
--------------------------------------------------------------------------------------------------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 						MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_SOVIET_UNION_STALIN', 	'MAJOR_CIV_APPROACH_WAR', 			5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 						MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_SOVIET_UNION_STALIN', 	'MINOR_CIV_APPROACH_IGNORE', 		1),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	9),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'MINOR_CIV_APPROACH_BULLY', 		3);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 						FlavorType, 						Flavor)
VALUES	('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_OFFENSE', 					8),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_DEFENSE', 					6),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_CITY_DEFENSE', 				7),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_MILITARY_TRAINING', 		8),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_RECON', 					4),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_RANGED', 					4),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_MOBILE', 					5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_NAVAL', 					4),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_NAVAL_RECON', 				3),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_NAVAL_GROWTH', 				2),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_AIR', 						5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_EXPANSION', 				8),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_GROWTH', 					8),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_TILE_IMPROVEMENT', 			9),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_INFRASTRUCTURE', 			9),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_PRODUCTION', 				9),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_GOLD', 						6),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_SCIENCE', 					8),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_CULTURE', 					4),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_HAPPINESS', 				5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_WONDER', 					6),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_RELIGION', 					0),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_DIPLOMACY', 				4),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_SPACESHIP', 				3),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_NUKE', 						3),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_USE_NUKE', 					3),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_ESPIONAGE', 				9),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_AIRLIFT', 					1),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_SOVIET_UNION_STALIN', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 						TraitType)
VALUES	('LEADER_JFD_SOVIET_UNION_STALIN', 	'TRAIT_JFD_SOVIET_UNION_STALIN');
--==========================================================================================================================	
-- DIPLOMACY
--==========================================================================================================================	
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
		(LeaderType, 						ResponseType, 								Response, 																Bias)
VALUES 	('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_AI_DOF_BACKSTAB', 				'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_DENOUNCE_FRIEND%', 				500),
		('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_ATTACKED_HOSTILE', 				'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_ATTACKED_HOSTILE%', 			500),
		('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_DEFEATED', 						'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_DEFEATED%', 					500),
		('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_DOW_GENERIC', 					'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_DOW_GENERIC%', 					500),
		('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_FIRST_GREETING', 					'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_FIRSTGREETING%', 				500),
		('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_RESPONSE_TO_BEING_DENOUNCED',		'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_RESPONSE_TO_BEING_DENOUNCED%', 	500),
		('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_WORK_AGAINST_SOMEONE', 			'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_DENOUNCE%', 					500),
		('LEADER_JFD_SOVIET_UNION_STALIN',  'RESPONSE_WORK_WITH_US', 					'TXT_KEY_LEADER_JFD_SOVIET_UNION_STALIN_DEC_FRIENDSHIP%', 				500);
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 								Description, 								ShortDescription)
VALUES	('TRAIT_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_TRAIT_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_TRAIT_JFD_SOVIET_UNION_STALIN_SHORT');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_FreePolicies
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilization_FreePolicies(CivilizationType, PolicyType);	
INSERT INTO Civilization_FreePolicies
		(CivilizationType,							PolicyType)
VALUES	('CIVILIZATION_JFD_SOVIET_UNION_STALIN',	'POLICY_JFD_SOVIET_UNION_STALIN');
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
		(Type,									Description,								AfraidMinorPerTurnInfluence)
VALUES	('POLICY_JFD_SOVIET_UNION_STALIN',		'TXT_KEY_TRAIT_JFD_SOVIET_UNION_STALIN',	200);	
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions 
		(Type, 									Description, 									Help, 												Sound, 				EnemyDamageChance,	EnemyDamage,	CannotBeChosen, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_PROMOTION_JFD_SOVIET_UNION_STALIN',	'TXT_KEY_PROMOTION_JFD_SOVIET_UNION_STALIN_HELP', 	'AS2D_IF_LEVELUP', 	50,					10,				1, 				57, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_SOVIET_UNION_STALIN');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilizations
		(Type, 										DerivativeCiv,			Description, 									ShortDescription, 									Adjective, 											Civilopedia, 									CivilopediaTag, 						DefaultPlayerColor, 					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 								PortraitIndex, 	AlphaIconAtlas, 						SoundtrackTag, 	MapImage, 							DawnOfManQuote, 									 DawnOfManImage)
SELECT	'CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'CIVILIZATION_RUSSIA',	'TXT_KEY_CIV_JFD_SOVIET_UNION_STALIN_DESC', 	'TXT_KEY_CIV_JFD_SOVIET_UNION_STALIN_SHORT_DESC', 	'TXT_KEY_CIV_JFD_SOVIET_UNION_STALIN_ADJECTIVE',	'TXT_KEY_CIV5_JFD_SOVIET_UNION_STALIN_TEXT_1', 	'TXT_KEY_CIV5_JFD_SOVIET_UNION_STALIN',	'PLAYERCOLOR_JFD_SOVIET_UNION_STALIN', 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_SOVIET_UNION_STALIN_ICON_ATLAS', 	0, 				'JFD_SOVIET_UNION_STALIN_ALPHA_ATLAS', 	'Russia', 		'JFD_MapSovietUnionStalin512.dds',  'TXT_KEY_CIV5_DAWN_JFD_SOVIET_UNION_STALIN_TEXT',   'JFD_DOM_SovietUnionStalin.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames
		(CivilizationType, 							CityName)
VALUES	('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_MOSCOW'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_01'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_02'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_03'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_04'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_05'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_06'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_07'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_08'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_09'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_10'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_11'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_12'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_13'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_14'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_15'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_16'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_17'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_18'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_19'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_20'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_21'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_22'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_23'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_24'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_25'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_26'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_27'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_28'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_29'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_30'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_31'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_32'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_33'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_34'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_35'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_36'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_37'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_38'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_39'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_40'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_41'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_42'),
		('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'TXT_KEY_CITY_NAME_JFD_STALIN_43');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	'CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------		
-- Civilization_FreeTechs
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	'CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_SOVIET_UNION_STALIN',		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 							LeaderheadType)
VALUES	('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'LEADER_JFD_SOVIET_UNION_STALIN');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 							UnitClassType, 		UnitType)
VALUES	('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'UNITCLASS_TANK', 	'UNIT_JFD_IS2');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 							BuildingClassType, 			  BuildingType)
VALUES	('CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	'BUILDINGCLASS_POLICE_STATION', 	  'BUILDING_JFD_PEOPLES_COMMISSARIAT');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Religions
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
SELECT	'CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	ReligionType
FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 							SpyName)
SELECT	'CIVILIZATION_JFD_SOVIET_UNION_STALIN', 	SpyName
FROM Civilization_SpyNames WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--==========================================================================================================================
--==========================================================================================================================