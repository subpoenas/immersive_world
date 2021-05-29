;------------------------------------------------------------------------------------
; dxTokenToIdleScript by Xider
;------------------------------------------------------------------------------------
; This script is effectively the 'database' of animations and relates a token 
; to a sequence of animations. Unfortunately this is very spergy, but it
; is very very fast, hence a worthwhile trade-off.
;
;------------------------------------------------------------------------------------
Scriptname dxTokenToIdleScript extends dxTokenToIdleBase

string[] Function ConvertTokenToIdles(dxAliasActor who, int Sequence = 0)
	
	who.SchlongBends = new int[6]
	who.IsUsingKissing = false
	who.EjaculationStages = new bool[6]
	who.SoundTypes = new int[6]
	who.SoundTimings = new float[6]
	
	IsUsingBed = false
	IsUsingChair = false
	IsUsingThrone = false
	IsUsingWorkbench = false
	IsUsingTable = false
	IsUsingAlchemyBench = false
	IsUsingEnchantingBench = false
	
	; *** Oral Scene	************************
	if (who.SexType == SexPositions.TokenOralFemale)
	
		; Suppress sound for the female
		who.SuppressSound = True
	
		; Use oral expression over-ride
		who.UseOralExpression = True		
		
		if (HasAvailableBed)
			IsUsingBed = True
			bool[] oralExpressions = new bool[6]
			oralExpressions[0] = False
			oralExpressions[1] = True
			oralExpressions[2] = False
			oralExpressions[3] = True
			oralExpressions[4] = True
			oralExpressions[5] = False
			who.OralExpressionToggles = oralExpressions			
			
			who.SoundTypes[1] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[3] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[4] = SOUNDTYPE_ORAL_F_HEAVY
								
			who.SoundTimings[1] = 1.0
			who.SoundTimings[3] = 2.0
			who.SoundTimings[4] = 2.0	
			
			return Bed69FemaleIdles
		elseIf (HasAvailableThrone)
			bool[] oralExpressions = new bool[6]
			oralExpressions[0] = False
			oralExpressions[1] = True
			oralExpressions[2] = True
			oralExpressions[3] = True
			oralExpressions[4] = True
			oralExpressions[5] = False
			who.OralExpressionToggles = oralExpressions
			
			who.SoundTypes[0] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[1] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[2] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[3] = SOUNDTYPE_ORAL_F_HEAVY
			who.SoundTypes[4] = SOUNDTYPE_ORAL_F_HEAVY
			
			who.SoundTimings[0] = 1.0
			who.SoundTimings[1] = 2.0
			who.SoundTimings[2] = 2.0
			who.SoundTimings[3] = 2.0
			who.SoundTimings[4] = 2.0
			
			IsUsingThrone = True
			return ThroneOralFemaleIdles
		else		
			bool[] oralExpressions = new bool[9]
			if (FlowerGirlsConfig.DX_USE_KISSES.GetValueInt() == 1 && FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.GetValueInt() == 0)
				oralExpressions[0] = False
				oralExpressions[1] = False
				oralExpressions[2] = False
				oralExpressions[3] = False
				oralExpressions[4] = False
				oralExpressions[5] = True
				oralExpressions[6] = True
				oralExpressions[7] = True
				oralExpressions[8] = False
			else
				oralExpressions = new bool[6]
				oralExpressions[0] = False
				oralExpressions[1] = False
				oralExpressions[2] = True
				oralExpressions[3] = True
				oralExpressions[4] = True
				oralExpressions[5] = False
			endIf		
			who.OralExpressionToggles = oralExpressions
			
			who.SoundTypes[0] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[1] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[2] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[3] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[4] = SOUNDTYPE_ORAL_F_HEAVY
			
			who.SoundTimings[0] = 1.0
			who.SoundTimings[1] = 1.0
			who.SoundTimings[2] = 2.0
			who.SoundTimings[3] = 2.0
			who.SoundTimings[4] = 2.0
			
			if (Sequence == 0)
				who.PosZOffset = 1
				return GetIdles(who, OralOneFemaleIdles, True)
			elseIf (Sequence == 1)
				who.PosZOffset = 1
				return GetIdles(who, OralTwoFemaleIdles, True)
			elseIf (Sequence == 2)
				return GetIdles(who, OralThreeFemaleIdles, True)
			elseIf (Sequence == 3)
				return GetIdles(who, SixtyNineFemaleIdles, True)
			elseIf (Sequence == 4)
				if (FlowerGirlsConfig.DX_USE_KISSES.GetValueInt() == 1 && FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.GetValueInt() == 0)
					oralExpressions[4] = True
				else
					oralExpressions[1] = True
				endIf
				return GetIdles(who, BillyOralLayingFemaleIdles, True)
			else
				return GetIdles(who, Nibbles69FemaleIdles, True)
			endIf
		endIf
	elseIf (who.SexType == SexPositions.TokenOralMale)
		if (HasAvailableBed)
			IsUsingBed = True
			
			who.SchlongBends[2] = -1
			who.SchlongBends[3] = -1
			who.SchlongBends[4] = -1
			who.SchlongBends[5] = -1
			
			return Bed69MaleIdles
		elseIf (HasAvailableThrone)
			who.SchlongBends[0] = 0
			who.SchlongBends[1] = -1
			who.SchlongBends[2] = -1
			who.SchlongBends[3] = 0
			who.SchlongBends[4] = -1
			who.SchlongBends[5] = 0
			IsUsingThrone = True
			return ThroneOralMaleIdles
		else
			if (Sequence == 0)
				who.SchlongBends[0] = 1
				who.SchlongBends[1] = 6
				who.SchlongBends[2] = 0
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				return GetIdles(who, OralOneMaleIdles)
			elseIf (Sequence == 1)
				who.SchlongBends[0] = 1
				who.SchlongBends[1] = 1
				return GetIdles(who, OralTwoMaleIdles)
			elseIf (Sequence == 2)
				who.SchlongBends[0] = 1
				who.SchlongBends[1] = 1
				return GetIdles(who, OralThreeMaleIdles)
			elseIf (Sequence == 3)
				return GetIdles(who, SixtyNineMaleIdles)
			elseIf (Sequence == 4)
				return GetIdles(who, BillyOralLayingMaleIdles)
			else
				who.SchlongBends[2] = -1
				who.SchlongBends[3] = -1
				return GetIdles(who, Nibbles69MaleIdles)	
			endIf
		endIf
	
	; *** TittyFuck Scene	***********************
	elseIf (who.SexType == SexPositions.TokenTittyFemale)
		return GetIdles(who, TittyFuckFemaleIdles, True)
	elseIf (who.SexType == SexPositions.TokenTittyMale)
		who.EjaculationStages[4] = True
		who.EjaculationStages[5] = True
		return GetIdles(who, TittyFuckMaleIdles)
	
	; *** Cowgirl Scene	************************
	elseIf (who.SexType == SexPositions.TokenCowgirlFemale)
		if (HasAvailableBed)
			IsUsingBed = True
			who.SoundTypes[0] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTimings[0] = 1.5
			if (Sequence == 0)
				return BedAnalRevCowFemaleIdles
			else
				return BedCowgirlFemaleIdles
			endIf
		elseIf (HasAvailableThrone)
			IsUsingThrone = True
			if (Sequence == 0)
				return ThroneAnalCowFemaleIdles
			else
				return ThroneCowgirlFemaleIdles
			endIf
		else
			if (Sequence == 0)
				who.SoundTypes[1] = SOUNDTYPE_SOLO_F
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				who.SoundTimings[1] = 1.5
				who.SoundTimings[4] = 1.5
				return GetIdles(who, CowgirlOneFemaleIdles, True)
			elseif (Sequence == 1)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.5
				who.SoundTimings[4] = 1.5
				return GetIdles(who, CowgirlTwoFemaleIdles, True)
			elseIf (Sequence == 2)
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				who.SoundTimings[4] = 1.5
				return GetIdles(who, ReverseCowFemaleIdles, True)
			elseIf (Sequence == 3)
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				who.SoundTimings[4] = 1.5
				return GetIdles(who, AnalRevCowFemaleIdles, True)
			elseIf (Sequence == 4)
				return GetIdles(who, CowgirlFeetFemaleIdles, True)
			elseIf (Sequence == 5)
				return GetIdles(who, LotusFemaleIdles, True)
			elseIf (Sequence == 6)
				return GetIdles(who, CowgirlThreeFemaleIdles, True)
			elseIf (Sequence == 7)
				return GetIdles(who, CowgirlFourFemaleIdles, True)
			elseIf (Sequence == 8)
				return GetIdles(who, CowgirlFiveFemaleIdles, True)
			elseIf (Sequence == 9)
				return GetIdles(who, MilkyCowgirl1FemaleIdles, True)
			elseIf (Sequence == 10)
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				who.SoundTypes[5] = SOUNDTYPE_SOLO_F
				who.SoundTimings[4] = 1.5
				who.SoundTimings[5] = 1.5
				return GetIdles(who, MilkyCowgirlMissFemaleIdles, True)
			elseIf (Sequence == 11)
				return GetIdles(who, MilkyCowgirl2FemaleIdles, True)
			elseIf (Sequence == 12)
				return GetIdles(who, MilkyRevCow1FemaleIdles, True)
			else
				who.SoundTypes = new int[7]
				who.SoundTimings = new float[7]
				who.EjaculationStages = new bool[7]
				who.SchlongBends = new int[7]
				return GetIdles(who, NibblesReverseCowgirl2FemaleIdles, True)
			endIf
		endIf
	elseIf (who.SexType == SexPositions.TokenCowgirlMale)
		if (HasAvailableBed)
			IsUsingBed = True
			who.SoundTypes[2] = SOUNDTYPE_PIV
			who.SoundTypes[3] = SOUNDTYPE_PIV
			who.SoundTimings[2] = 0.5333328
			who.SoundTimings[3] = 0.333333
			if (Sequence == 0)
				who.SchlongBends[0] = 2
				who.SchlongBends[3] = 2
				who.SchlongBends[4] = 3
				who.SchlongBends[5] = 3
				return BedAnalRevCowMaleIdles
			else
				who.SchlongBends[1] = 2
				return BedCowgirlMaleIdles
			endIf
		elseIf (HasAvailableThrone)
			IsUsingThrone = True
			if (Sequence == 0)
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTimings[2] = 0.666666	; 1.333332 /2
				who.SoundTimings[3] = 0.999999

				who.SchlongBends[2] = 6
				who.SchlongBends[3] = 5
				who.SchlongBends[4] = 6
				return ThroneAnalCowMaleIdles
			else
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTimings[1] = 0.666666	; 1.333332 /2
				who.SoundTimings[3] = 0.5333328
				
				who.SchlongBends[3] = -5
				who.SchlongBends[4] = -1				
				return ThroneCowgirlMaleIdles
			endIf
		else
			if (Sequence == 0)
				who.SchlongBends[3] = 4
				who.SchlongBends[4] = 5
				who.SchlongBends[5] = 4
				
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.333332	;2.666664 /2
				who.SoundTimings[2] = 0.666666	;2.666664
				who.SoundTimings[3] = 0.4999995
				
				return GetIdles(who, CowgirlOneMaleIdles)
			elseif (Sequence == 1)
				who.SchlongBends[0] = -2
				who.SchlongBends[1] = -2
				who.SchlongBends[2] = -2
				who.SchlongBends[3] = -2
				who.SchlongBends[4] = -4
				who.SchlongBends[5] = -2
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.666666
				who.SoundTimings[2] = 0.5333328
				who.SoundTimings[3] = 0.466667
				
				return GetIdles(who, CowgirlTwoMaleIdles)
			elseIf (Sequence == 2)
				who.SchlongBends[1] = 3
				who.SchlongBends[2] = 6
				who.SchlongBends[3] = 6
				who.SchlongBends[4] = 7
				who.SchlongBends[5] = 7
				
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.333332	; 2.666664 /2
				who.SoundTimings[1] = 0.666666	; 1.333332 /2
				who.SoundTimings[2] = 0.666666	; 1.333332 /2
				who.SoundTimings[3] = 0.4999995	; 0.999999 /2
				
				return GetIdles(who, ReverseCowMaleIdles)
			elseIf (Sequence == 3)
				who.SchlongBends[0] = 0
				who.SchlongBends[1] = 1
				who.SchlongBends[2] = 8
				who.SchlongBends[3] = 8
				who.SchlongBends[4] = 8
				who.SchlongBends[5] = 8
				
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.999998
				who.SoundTimings[1] = 0.5	; 1.0 /2
				who.SoundTimings[2] = 0.666667
				who.SoundTimings[3] = 0.466667
				
				return GetIdles(who, AnalRevCowMaleIdles)
			elseIf (Sequence == 4)
				who.SoundTypes[1] = SOUNDTYPE_SOLO_M
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_SOLO_M
				
				who.SoundTimings[1] = 1.0
				who.SoundTimings[2] = 0.8333325	;1.666665 /2
				who.SoundTimings[3] = 1.0
			
				return GetIdles(who, CowgirlFeetMaleIdles)
			elseIf (Sequence == 5)
				who.SchlongBends[0] = 1
				who.SchlongBends[1] = 1
				who.SchlongBends[2] = 2
				who.SchlongBends[3] = 3
				who.SchlongBends[4] = 3
				who.SchlongBends[5] = 3
				
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.333332
				who.SoundTimings[1] = 0.7999992
				who.SoundTimings[2] = 0.5999994
				who.SoundTimings[3] = 0.5333328
				
				return GetIdles(who, LotusMaleIdles)
			elseIf (Sequence == 6)
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 0.999999
				who.SoundTimings[1] = 0.999999 ; Might be 1.1999988
				who.SoundTimings[2] = 0.5999994	; 7.1999928 /12
				who.SoundTimings[3] = 0.46222176	; 6.9333264 /15
				
				who.SchlongBends[2] = 1
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 2
				who.SchlongBends[5] = 2
				
				return GetIdles(who, CowgirlThreeMaleIdles)
			elseIf (Sequence == 7)
			
				who.SchlongBends[0] = 2
				who.SchlongBends[1] = 4
				who.SchlongBends[2] = 3
				who.SchlongBends[3] = 4
				who.SchlongBends[4] = 5
				who.SchlongBends[5] = 5
			
				return GetIdles(who, CowgirlFourMaleIdles)
			elseIf (Sequence == 8)
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTimings[2] = 0.666666 ; 3.999996 /6
				
				return GetIdles(who, CowgirlFiveMaleIdles)
			elseIf (Sequence == 9)
				who.SchlongBends[0] = -1
				who.SchlongBends[1] = -2
				who.SchlongBends[2] = -1
				who.SchlongBends[3] = -1
				who.SchlongBends[4] = 1
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.7
				who.SoundTimings[2] = 0.55
				who.SoundTimings[3] = 0.35
				who.SoundTimings[4] = 0.6
				
				return GetIdles(who, MilkyCowgirl1MaleIdles)
			elseIf (Sequence == 10)
				who.SchlongBends[0] = -1
				who.SchlongBends[1] = -2
				who.SchlongBends[2] = -2
				who.SchlongBends[3] = 2
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 0.5
				who.SoundTimings[2] = 0.57
				who.SoundTimings[3] = 0.45
				
				who.EjaculationStages[4] = True
				return GetIdles(who, MilkyCowgirlMissMaleIdles)
			elseIf (Sequence == 11)
				who.SchlongBends[0] = -1
				who.SchlongBends[1] = -2
				who.SchlongBends[2] = -2
				who.SchlongBends[3] = -2
				who.SchlongBends[4] = -2
				who.SchlongBends[5] = -2
				
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.0
				who.SoundTimings[3] = 0.5
				who.SoundTimings[4] = 0.6
				
				return GetIdles(who, MilkyCowgirl2MaleIdles)
			elseIf (Sequence == 12)
				who.SchlongBends[0] = -2
				who.SchlongBends[2] = -1
				who.SchlongBends[3] = -1
				who.SchlongBends[4] = 2
				who.SchlongBends[5] = 2
				
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 0.8
				who.SoundTimings[1] = 0.7
				who.SoundTimings[2] = 0.5
				who.SoundTimings[3] = 0.4
				
				return GetIdles(who, MilkyRevCow1MaleIdles)
			else
				who.EjaculationStages = new bool[7]
				who.SchlongBends = new int[7]
				who.SchlongBends[0] = -1
				who.SchlongBends[3] = -2
				who.SchlongBends[4] = -1
				who.SchlongBends[5] = -1
				who.SchlongBends[6] = -1
				
				who.SoundTypes = new int[7]
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings = new float[7]
				who.SoundTimings[0] = 0.666666	; 5.333328 /8
				who.SoundTimings[1] = 0.7703696	; 6.9333264 /9
				who.SoundTimings[2] = 0.592592	; 5.333328 /9
				who.SoundTimings[3] = 0.5333328	; 4.7999952 /9
				who.SoundTimings[4] = 0.4923072	; 6.3999936 /13
				
				return GetIdles(who, NibblesReverseCowgirl2MaleIdles)
			endIf
		endIf
	
	; *** Standing Scene	************************
	elseIf (who.SexType == SexPositions.TokenStandingFemale)
		If (HasAvailableWorkbench)
			who.SchlongBends = new int[7]
			who.SoundTypes = new int[7]
			who.SoundTimings = new float[7]
			who.SoundTypes[0] = SOUNDTYPE_SOLO_F
			who.SoundTimings[0] = 1.5
			IsUsingWorkbench = True
			return WorkbenchFemaleIdles
		elseIf (HasAvailableAlchemyBench)
			IsUsingAlchemyBench = True
			if (Sequence == 0)
				who.SchlongBends = new int[7]
				who.SoundTypes = new int[7]
				who.SoundTimings = new float[7]
				who.PosZOffset = 2.5
				return AlchemyTableFemaleIdles
			else
				who.PosZOffset = -1.0
				who.PosYOffset = 60.0
				return MilkyAlchemy1FemaleIdles
			endIf
		elseIf (HasAvailableEnchantingBench)
			who.SoundTypes[0] = SOUNDTYPE_SOLO_F
			who.SoundTimings[0] = 1.5
		
			who.PosZOffset = 2.5
			IsUsingEnchantingBench = True
			return EnchantingTableFemaleIdles
		else
			if (Sequence == 0)
				return GetIdles(who, StandingOneFemaleIdles, True)
			elseIf (Sequence == 1)
				return GetIdles(who, StandingTwoFemaleIdles, True)
			elseIf (Sequence == 2)
				return GetIdles(who, AnalPowerbombFemaleIdles, True)
			elseIf (Sequence == 3)
				return GetIdles(who, BillyStand1FemaleIdles, True)
			elseIf (Sequence == 4)
				return GetIdles(who, BillyStand2FemaleIdles, True)
			elseIf (Sequence == 5)
				return GetIdles(who, MilkyStanding1FemaleIdles, True)
			else
				return GetIdles(who, MilkyStanding2FemaleIdles, True)
						
			;elseIf (Sequence == 3)
			;	who.PosZOffset = -10.0
			;	who.ScaleTo = 0.9
			;	return GetIdles(who, SapStand1FemaleIdles, True)
			;elseIf (Sequence == 4)
			;	who.PosZOffset = -10.0
			;	who.ScaleTo = 0.9
			;	return GetIdles(who, SapStand2FemaleIdles, True)
			;else
			;	who.PosZOffset = -10.0
			;	who.ScaleTo = 0.9
			;	return GetIdles(who, SapStand3FemaleIdles, True)
			endIf
		endIf
	elseIf (who.SexType == SexPositions.TokenStandingMale)
		If (HasAvailableWorkbench)
			who.SchlongBends = new int[7]
			who.SchlongBends[0] = -1
			who.SchlongBends[1] = -1
			
			who.SoundTypes = new int[7]
			who.SoundTypes[1] = SOUNDTYPE_SOLO_M
			who.SoundTypes[3] = SOUNDTYPE_PIV
			who.SoundTypes[4] = SOUNDTYPE_PIV
			who.SoundTypes[5] = SOUNDTYPE_PIV
			
			who.SoundTimings = new float[7]
			who.SoundTimings[1] = 1.5
			who.SoundTimings[3] = 1.3999986	; 8.3999916 /6
			who.SoundTimings[4] = 0.9641016	; 12.5333208 /13
			who.SoundTimings[5] = 1.4999985	; 5.999994 /4
			
			IsUsingWorkbench = True
			return WorkbenchMaleIdles
		elseIf (HasAvailableAlchemyBench)
			IsUsingAlchemyBench = True
			if (Sequence == 0)
				who.SchlongBends = new int[7]
				who.SoundTypes = new int[7]
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings = new float[7]
				who.SoundTimings[1] = 0.666666	; 7.999992 /12
				who.SoundTimings[2] = 0.571428	; 7.999992 /14
				who.SoundTimings[3] = 0.444444	; 7.999992 /18
				who.SoundTimings[4] = 0.3999996	; 7.999992 /20
				
				who.PosZOffset = 2.5
				return AlchemyTableMaleIdles
			else
				who.SchlongBends[0] = -1
				who.SchlongBends[1] = -1
				who.SchlongBends[4] = -1
				who.SchlongBends[5] = -1
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_SOLO_M
				who.SoundTypes[5] = SOUNDTYPE_SOLO_M
				
				who.SoundTimings[1] = 0.6
				who.SoundTimings[2] = 0.5
				who.SoundTimings[3] = 0.4
				who.SoundTimings[4] = 2.0
				who.SoundTimings[5] = 2.0
			
				who.PosZOffset = -1.0
				who.PosYOffset = 60.0
				return MilkyAlchemy1MaleIdles
			endIf
		elseIf (HasAvailableEnchantingBench)
			who.SoundTypes[1] = SOUNDTYPE_PIV
			who.SoundTypes[2] = SOUNDTYPE_PIV
			who.SoundTypes[3] = SOUNDTYPE_PIV
			
			who.SoundTimings[1] = 0.727272	; 7.999992 /11
			who.SoundTimings[2] = 0.5999994	; 7.7999922 /13
			who.SoundTimings[3] = 0.4958328375	; 7.9333254 /16
			
			who.PosZOffset = 2.5
			IsUsingEnchantingBench = True
			return EnchantingTableMaleIdles
		else
			if (Sequence == 0)
				who.SchlongBends[0] = -1
				who.SchlongBends[1] = 0
				who.SchlongBends[2] = 5
				who.SchlongBends[3] = 5
				who.SchlongBends[4] = 5
				who.SchlongBends[5] = 5
				
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 0.5
				who.SoundTimings[1] = 1.0
				who.SoundTimings[2] = 0.533333
				who.SoundTimings[3] = 0.533333
			
				return GetIdles(who, StandingOneMaleIdles)
			elseIf (Sequence == 1)
				who.SchlongBends[0] = 2
				who.SchlongBends[1] = 1
				who.SchlongBends[2] = 1
				who.SchlongBends[3] = 3
				who.SchlongBends[4] = 3
				who.SchlongBends[5] = 3
				
				who.SoundTypes[0] = SOUNDTYPE_ORAL_M
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 0.5
				who.SoundTimings[1] = 0.8
				who.SoundTimings[2] = 0.6
				who.SoundTimings[3] = 0.4
				
				return GetIdles(who, StandingTwoMaleIdles)
			elseIf (Sequence == 2)
				who.SchlongBends[0] = -2
				who.SchlongBends[1] = -2
				who.SchlongBends[2] = -2
				who.SchlongBends[3] = -2
				who.SchlongBends[4] = -2
				who.SchlongBends[5] = -2
				
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.0
				who.SoundTimings[1] = 0.666667
				who.SoundTimings[2] = 0.533333
				who.SoundTimings[3] = 0.466667
				
				return GetIdles(who, AnalPowerbombMaleIdles)
			elseIf (Sequence == 3)
				who.SchlongBends[0] = 2
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 2
				who.SchlongBends[5] = 2
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.7333326		; 7.333326
				who.SoundTimings[2] = 0.6399994		; 6.3999936
				who.SoundTimings[3] = 0.6399994		; 6.3999936
				
				return GetIdles(who, BillyStand1MaleIdles)
			elseIf (Sequence == 4)
				who.SchlongBends[0] = 0
				who.SchlongBends[1] = 1
				who.SchlongBends[2] = 2
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 0.5
				who.SoundTimings[2] = 1.0		; 8.0
				who.SoundTimings[3] = 1.0		; 8.0
				
				return GetIdles(who, BillyStand2MaleIdles)
			elseIf (Sequence == 5)
				who.SchlongBends[2] = 2
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = -1
				who.SchlongBends[5] = -1
				who.EjaculationStages[4] = True
				who.EjaculationStages[5] = True
				
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[4] = SOUNDTYPE_SOLO_M
				who.SoundTypes[5] = SOUNDTYPE_SOLO_M
				
				who.SoundTimings[0] = 0.5
				who.SoundTimings[4] = 0.6
				who.SoundTimings[5] = 0.6
				
				return GetIdles(who, MilkyStanding1MaleIdles)
			else
				who.SchlongBends[3] = -1
				who.SchlongBends[4] = -1
				who.SchlongBends[5] = -1
				who.EjaculationStages[4] = True
				who.EjaculationStages[5] = True
				
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_SOLO_M
				who.SoundTypes[5] = SOUNDTYPE_SOLO_M
				
				who.SoundTimings[3] = 0.6
				who.SoundTimings[4] = 0.5
				who.SoundTimings[5] = 0.5
				
				return GetIdles(who, MilkyStanding2MaleIdles)
				
			;elseIf (Sequence == 3)
			;	who.SchlongBends = new int[13]
			;	who.SchlongBends[0] = 0
			;	who.SchlongBends[1] = 0
			;	who.SchlongBends[2] = 2
			;	who.SchlongBends[3] = 6
			;	who.SchlongBends[4] = 6
			;	who.SchlongBends[5] = 1
			;	who.SchlongBends[6] = 7
			;	who.SchlongBends[7] = 4
			;	who.SchlongBends[8] = 6
			;	who.SchlongBends[9] = 6
			;	who.SchlongBends[10] = 5
			;	who.SchlongBends[11] = 5
			;	who.SchlongBends[12] = 4
			;	return GetIdles(who, SapStand1MaleIdles)
			;elseIf (Sequence == 4)
			;	who.SchlongBends = new int[10]
			;	who.SchlongBends[0] = -1
			;	who.SchlongBends[1] = 6
			;	who.SchlongBends[2] = 7
			;	who.SchlongBends[3] = 1
			;	who.SchlongBends[4] = 0
			;	who.SchlongBends[5] = 5
			;	who.SchlongBends[6] = 6
			;	who.SchlongBends[7] = 6
			;	who.SchlongBends[8] = 7
			;	who.SchlongBends[9] = 7
			;	return GetIdles(who, SapStand2MaleIdles)
			;else
			;	who.SchlongBends = new int[10]
			;	who.SchlongBends[0] = 8
			;	who.SchlongBends[1] = 7
			;	who.SchlongBends[2] = 9
			;	who.SchlongBends[3] = 6
			;	who.SchlongBends[4] = 8
			;	who.SchlongBends[5] = 7
			;	who.SchlongBends[6] = 6
			;	who.SchlongBends[7] = 6
			;	who.SchlongBends[8] = 8
			;	who.SchlongBends[9] = 3
			;	return GetIdles(who, SapStand3MaleIdles)
			endIf
		endIf
		
	; *** Lesbian Scene	************************
	elseIf (who.SexType == SexPositions.TokenLesbianFemale)
		if (Sequence == 0)
			return GetIdles(who, LesbianOneFemaleIdles, True)
		elseIf (Sequence == 1)
			return GetIdles(who, LesbianTwoFemaleIdles, True)
		elseIf (Sequence == 2)
			return GetIdles(who, Lesbian69FemaleIdles, True)
		elseIf (Sequence == 3)
			return GetIdles(who, LesbianTribbingFemaleIdles, True)
		elseIf (Sequence == 4)
			return GetIdles(who, BillyLesbian1MaleIdles, True)
		elseIf (Sequence == 5)
			return GetIdles(who, BillyLesbianFinger2FemaleIdles, True)
		elseIf (Sequence == 6)
			return GetIdles(who, BillyLesbianTribbing1FemaleIdles, True)
		elseIf (Sequence == 7)
			return GetIdles(who, MilkyLesbian1MaleIdles, True)
		elseIf (Sequence == 8)
			return GetIdles(who, BillyLesbianMagicDildo1FemaleIdles, True)
		else
			return GetIdles(who,NibblesLesbianCuddling1FemaleIdles, True)
		endIf
	elseIf (who.SexType == SexPositions.TokenLesbianMale)
		if (Sequence == 0)
			return GetIdles(who, LesbianOneMaleIdles)
		elseIf (Sequence == 1)
			return GetIdles(who, LesbianTwoMaleIdles)
		elseIf (Sequence == 2)
			return GetIdles(who, Lesbian69MaleIdles)
		elseIf (Sequence == 3)
			return GetIdles(who, LesbianTribbingMaleIdles)
		elseIf (Sequence == 4)
			return GetIdles(who, BillyLesbian1FemaleIdles)
		elseIf (Sequence == 5)
			return GetIdles(who, BillyLesbianFinger2MaleIdles)
		elseIf (Sequence == 6)
			return GetIdles(who, BillyLesbianTribbing1MaleIdles)
		elseIf (Sequence == 7)
			return GetIdles(who, MilkyLesbian1FemaleIdles)
		elseIf (Sequence == 8)
			return GetIdles(who, BillyLesbianMagicDildo1MaleIdles)
		else
			who.SchlongBends = new int[7]
			return GetIdles(who, NibblesLesbianCuddling1MaleIdles)
		endIf		
	
	; *** Cunnilingus Scene	************************
	elseIf (who.SexType == SexPositions.TokenCunnilingusFemale)
		if (HasAvailableThrone)
			IsUsingThrone = True
			return ThroneCunniFemaleIdles
		else
			if (Sequence == 0)
				return GetIdles(who, CunniOneMaleIdles, True, False)
			elseIf (Sequence == 1)
				return GetIdles(who, CunniTwoMaleIdles, True, False)
			else
				; Use oral expression over-ride
				who.UseOralExpression = True
				bool[] oralExpressions = new bool[9]
				if (FlowerGirlsConfig.DX_USE_KISSES.GetValueInt() == 1 && FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.GetValueInt() == 0)
					oralExpressions[0] = False
					oralExpressions[1] = False
					oralExpressions[2] = False
					oralExpressions[3] = False
					oralExpressions[4] = False
					oralExpressions[5] = False
					oralExpressions[6] = True
					oralExpressions[7] = False
					oralExpressions[8] = False
				else
					oralExpressions = new bool[6]
					oralExpressions[0] = False
					oralExpressions[1] = False
					oralExpressions[2] = False
					oralExpressions[3] = True
					oralExpressions[4] = False
					oralExpressions[5] = False
				endIf
				who.OralExpressionToggles = oralExpressions
				
				who.SoundTypes[0] = SOUNDTYPE_ORAL_F_LIGHT
				who.SoundTypes[1] = SOUNDTYPE_ORAL_F_MEDIUM
				who.SoundTypes[2] = SOUNDTYPE_ORAL_F_LIGHT
				who.SoundTypes[3] = SOUNDTYPE_ORAL_F_HEAVY
				who.SoundTypes[4] = SOUNDTYPE_ORAL_F_LIGHT
				
				who.SoundTimings[0] = 1.0
				who.SoundTimings[1] = 2.0
				who.SoundTimings[2] = 1.0
				who.SoundTimings[3] = 2.0
				who.SoundTimings[4] = 1.0
				
				return GetIdles(who, MilkyCunni1FemaleIdles, True, False)
			endIf
		endIf
	elseIf (who.SexType == SexPositions.TokenCunnilingusMale)
		who.SuppressSound = True
		if (HasAvailableThrone)
			IsUsingThrone = True
			return ThroneCunniMaleIdles
		else
			who.SchlongBends[0] = 3
			who.SchlongBends[1] = 3
			who.SchlongBends[2] = 3
			who.SchlongBends[3] = 3
			who.SchlongBends[4] = 3
			if (Sequence == 0)
				return GetIdles(who, CunniOneFemaleIdles)
			elseIf (Sequence == 1)
				return GetIdles(who, CunniTwoFemaleIdles)
			else
				who.SchlongBends[1] = -1
				who.SchlongBends[3] = -1
				who.EjaculationStages[4] = True
				return GetIdles(who, MilkyCunni1MaleIdles)
			endIf
		endIf
		
	; *** Lesbian Cunnilingus Scene	*********************
	elseIf (who.SexType == SexPositions.TokenLesbianCunnilingusFemale)
		if (Sequence == 0)
			return GetIdles(who, BillyLesbianCunni1FemaleIdles, True, False)
		else
			return GetIdles(who, BillyLesbianCunni2FemaleIdles, True, False)
		endIf
	elseIf (who.SexType == SexPositions.TokenLesbianCunnilingusMale)
		if (Sequence == 0)
			return GetIdles(who, BillyLesbianCunni1MaleIdles)
		else
			return GetIdles(who, BillyLesbianCunni2MaleIdles)
		endIf
		
	; *** Dildo Scene	************************
	elseIf (who.SexType == SexPositions.TokenDildoFemale)
		if (Sequence == 0)
			return GetIdles(who, DildoOneFemaleIdles, True)
		else
			return GetIdles(who, DildoTwoFemaleIdles, True)
		endIf
	elseIf (who.SexType == SexPositions.TokenDildoMale)
		if (Sequence == 0)
			return GetIdles(who, DildoOneMaleIdles)
		else
			return GetIdles(who, DildoTwoMaleIdles)
		endIf
	
	; *** Doggy Scene	******************************************************************
	elseIf (who.SexType == SexPositions.TokenDoggyFemale)
		if (HasAvailableBed)
			IsUsingBed = True
			who.SoundTypes[0] = SOUNDTYPE_SOLO_F
			who.SoundTimings[0] = 1.5
			if (Sequence == 0)
				return BedAnalDoggyFemaleIdles
			else
				return BedDoggyFemaleIdles
			endIf
		elseIf (HasAvailableThrone)
			IsUsingThrone = True
			if (Sequence == 0)
				return ThroneAnalDoggyFemaleIdles
			else
				return ThroneDoggyFemaleIdles
			endIf
		elseIf (HasAvailableChair)
			IsUsingChair = True
			who.SchlongBends = new int[7]
			who.SoundTypes = new int[7]
			who.SoundTimings = new float[7]
			return ChairDoggyFemaleIdles
		elseIf (HasAvailableWorkbench)
			who.SchlongBends = new int[7]
			who.SoundTypes = new int[7]
			who.SoundTimings = new float[7]
			who.SoundTypes[0] = SOUNDTYPE_SOLO_F
			who.SoundTimings[0] = 1.5
			IsUsingWorkbench = True
			return WorkbenchFemaleIdles
		elseIf (HasAvailableAlchemyBench)
			IsUsingAlchemyBench = True
			if (Sequence == 0)
				who.SchlongBends = new int[7]
				who.SoundTypes = new int[7]
				who.SoundTimings = new float[7]
				who.PosZOffset = 2.5
				return AlchemyTableFemaleIdles
			else
				who.PosZOffset = -1.0
				who.PosYOffset = 60.0
				return MilkyAlchemy1FemaleIdles
			endIf
		elseIf (HasAvailableEnchantingBench)
			who.SoundTypes[0] = SOUNDTYPE_SOLO_F
			who.SoundTimings[0] = 1.5
		
			who.PosZOffset = 2.5
			IsUsingEnchantingBench = True
			return EnchantingTableFemaleIdles
		else
			if (Sequence == 0)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.5
				return GetIdles(who, DoggyOneFemaleIdles, True)
			elseIf (Sequence == 1)
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				who.SoundTypes[5] = SOUNDTYPE_SOLO_F
				
				who.SoundTimings[4] = 1.6
				who.SoundTimings[5] = 1.6
				
				return GetIdles(who, DoggyTwoFemaleIdles, True)
			elseIf (Sequence == 2)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.6
				return GetIdles(who, AnalDoggyOneFemaleIdles, True)
			elseIf (Sequence == 3)
				return GetIdles(who, AnalDoggyTwoFemaleIdles, True)
			elseIf (Sequence == 4)
				return GetIdles(who, DoggyThreeFemaleIdles, True)
			elseIf (Sequence == 5)
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				who.SoundTypes[5] = SOUNDTYPE_SOLO_F
				
				who.SoundTimings[4] = 1.6
				who.SoundTimings[5] = 1.6
				
				return GetIdles(who, SidewaysFemaleIdles, True)
			elseIf (Sequence == 6)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.5
				
				return GetIdles(who, MilkyDoggy1FemaleIdles, True)
			else
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.5
			
				return GetIdles(who, MilkyDoggy2FemaleIdles, True)
			endIf
		endIf
	elseIf (who.SexType == SexPositions.TokenDoggyMale)
		if (HasAvailableBed)
			IsUsingBed = True
			if (Sequence == 0)	
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				who.SoundTypes[5] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 1.1999988
				who.SoundTimings[2] = 0.3999996
				who.SoundTimings[3] = 0.3999996
				who.SoundTimings[4] = 1.333332
				who.SoundTimings[5] = 1.333332
				
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				
				return BedAnalDoggyMaleIdles
			else
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.5333328
				who.SoundTimings[2] = 0.4666662
				who.SoundTimings[3] = 0.3999996
				
				who.SchlongBends[1] = 1
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				
				return BedDoggyMaleIdles
			endIf
		elseIf (HasAvailableThrone)
			IsUsingThrone = True
			who.SoundTypes[0] = SOUNDTYPE_PIV
			who.SoundTypes[1] = SOUNDTYPE_PIV
			who.SoundTypes[2] = SOUNDTYPE_PIV
			who.SoundTypes[3] = SOUNDTYPE_PIV
			
			who.SoundTimings[0] = 0.999999
			who.SoundTimings[1] = 0.666666
			
			if (Sequence == 0)
				who.SoundTimings[2] = 0.5999994
				who.SoundTimings[3] = 0.666666
				
				who.SchlongBends[3] = 4
				who.SchlongBends[4] = 4
				return ThroneAnalDoggyMaleIdles
			else
				who.SoundTimings[2] = 0.5333328
				who.SoundTimings[3] = 0.5333328
				
				who.SchlongBends[0] = 1
				who.SchlongBends[1] = 1
				return ThroneDoggyMaleIdles
			endIf
		elseIf (HasAvailableChair)
			IsUsingChair = True
			who.SchlongBends = new int[7]
			who.SchlongBends[0] = 3
			who.SchlongBends[1] = 6
			who.SchlongBends[2] = 3
			who.SchlongBends[3] = 2
			who.SchlongBends[4] = -1
			
			who.SoundTypes = new int[7]
			who.SoundTypes[0] = SOUNDTYPE_SOLO_M
			who.SoundTypes[2] = SOUNDTYPE_PIV
			who.SoundTypes[3] = SOUNDTYPE_PIV
			who.SoundTypes[4] = SOUNDTYPE_PIV
			
			who.SoundTimings = new float[7]
			who.SoundTimings[0] = 1.5
			who.SoundTimings[2] = 0.7333326	; 8.7999912 /12
			who.SoundTimings[3] = 0.481481	; 8.666658 /18
			who.SoundTimings[4] = 0.5666661	; 5.666661 /10
			
			return ChairDoggyMaleIdles
		elseIf (HasAvailableWorkbench)
			who.SchlongBends = new int[7]
			who.SchlongBends[0] = -1
			who.SchlongBends[1] = -1
			
			who.SoundTypes = new int[7]
			who.SoundTypes[1] = SOUNDTYPE_SOLO_M
			who.SoundTypes[3] = SOUNDTYPE_PIV
			who.SoundTypes[4] = SOUNDTYPE_PIV
			who.SoundTypes[5] = SOUNDTYPE_PIV
			
			who.SoundTimings = new float[7]
			who.SoundTimings[1] = 1.5
			who.SoundTimings[3] = 1.3999986	; 8.3999916 /6
			who.SoundTimings[4] = 0.9641016	; 12.5333208 /13
			who.SoundTimings[5] = 1.4999985	; 5.999994 /4
			
			IsUsingWorkbench = True
			return WorkbenchMaleIdles
		elseIf (HasAvailableAlchemyBench)
			IsUsingAlchemyBench = True
			if (Sequence == 0)
				who.SchlongBends = new int[7]
				who.SoundTypes = new int[7]
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings = new float[7]
				who.SoundTimings[1] = 0.666666	; 7.999992 /12
				who.SoundTimings[2] = 0.571428	; 7.999992 /14
				who.SoundTimings[3] = 0.444444	; 7.999992 /18
				who.SoundTimings[4] = 0.3999996	; 7.999992 /20
				
				who.PosZOffset = 2.5
				return AlchemyTableMaleIdles
			else
				who.SchlongBends[0] = -1
				who.SchlongBends[1] = -1
				who.SchlongBends[4] = -1
				who.SchlongBends[5] = -1
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_SOLO_M
				who.SoundTypes[5] = SOUNDTYPE_SOLO_M
				
				who.SoundTimings[1] = 0.6
				who.SoundTimings[2] = 0.5
				who.SoundTimings[3] = 0.4
				who.SoundTimings[4] = 2.0
				who.SoundTimings[5] = 2.0
			
				who.PosZOffset = -1.0
				who.PosYOffset = 60.0
				return MilkyAlchemy1MaleIdles
			endIf
		elseIf (HasAvailableEnchantingBench)
			who.SoundTypes[1] = SOUNDTYPE_PIV
			who.SoundTypes[2] = SOUNDTYPE_PIV
			who.SoundTypes[3] = SOUNDTYPE_PIV
			
			who.SoundTimings[1] = 0.727272	; 7.999992 /11
			who.SoundTimings[2] = 0.5999994	; 7.7999922 /13
			who.SoundTimings[3] = 0.4958328375	; 7.9333254 /16
			
			who.PosZOffset = 2.5
			IsUsingEnchantingBench = True
			return EnchantingTableMaleIdles
		else
			if (Sequence == 0)
				who.SchlongBends[3] = 2
				who.SchlongBends[4] = 2
				who.SchlongBends[5] = 2
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.833333
				who.SoundTimings[2] = 0.666666
				who.SoundTimings[3] = 0.533333
				
				return GetIdles(who, DoggyOneMaleIdles)
			elseIf (Sequence == 1)
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.666666
				who.SoundTimings[2] = 0.466667
				who.SoundTimings[3] = 0.3999996
				
				return GetIdles(who, DoggyTwoMaleIdles)
			elseIf (Sequence == 2)
				who.SchlongBends[3] = 2
				who.SchlongBends[4] = 3
				who.SchlongBends[5] = 3
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.999999
				who.SoundTimings[2] = 0.499995
				who.SoundTimings[3] = 0.4
				who.SoundTimings[4] = 1.66667
				
				return GetIdles(who, AnalDoggyOneMaleIdles)
			elseIf (Sequence == 3)
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.16667
				who.SoundTimings[1] = 0.8333325
				who.SoundTimings[2] = 0.53333
				who.SoundTimings[3] = 0.466667
				who.SoundTimings[4] = 1.66667
			
				return GetIdles(who, AnalDoggyTwoMaleIdles)	
			elseIf (Sequence == 4)
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.999999	; 5.999994
				who.SoundTimings[2] = 0.5333328	; 7.4666592
				who.SoundTimings[3] = 0.5142852	; 7.1999928
				who.SoundTimings[4] = 2.1333312	; 6.3999936		/3
				
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				
				return GetIdles(who, DoggyThreeMaleIdles)
			elseIf (Sequence == 5)
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.0285704	; 7.1999928
				who.SoundTimings[1] = 0.9714276	; 6.7999932
				who.SoundTimings[2] = 0.761904	; 5.333328
				who.SoundTimings[3] = 0.5999994	; 5.999994
				
				return GetIdles(who, SidewaysMaleIdles)
			elseIf (Sequence == 6)
				who.SchlongBends[0] = -1
				who.SchlongBends[1] = -2
				who.SchlongBends[2] = -1
				who.SchlongBends[3] = -1
				who.SchlongBends[4] = -2
				who.SchlongBends[5] = -2
				
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[2] = 0.8
				who.SoundTimings[3] = 0.5
				
				return GetIdles(who, MilkyDoggy1MaleIdles)
			else
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				who.SoundTypes[5] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.85
				who.SoundTimings[2] = 0.5
				who.SoundTimings[3] = 0.4
				who.SoundTimings[4] = 1.0
				who.SoundTimings[5] = 1.0
			
				return GetIdles(who, MilkyDoggy2MaleIdles)
			endIf
		endIf
	
	; *** Missionary Scene	******************************************************************
	elseIf (who.SexType == SexPositions.TokenMissionaryFemale)
		if (HasAvailableBed)
			IsUsingBed = True
			if (Sequence == 0)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.5
				return BedMissionaryFemaleIdles
			else
				who.SoundTypes[1] = SOUNDTYPE_SOLO_F
				who.SoundTimings[1] = 1.5
				return BedMissFeetFemaleIdles
			endIf
		elseIf (HasAvailableThrone)
			IsUsingThrone = True
			return ThroneMissionaryFemaleIdles
		elseIf (HasAvailableWorkbench)
			who.SchlongBends = new int[7]
			who.SoundTypes = new int[7]
			who.SoundTimings = new float[7]
			who.SoundTypes[0] = SOUNDTYPE_SOLO_F
			who.SoundTimings[0] = 1.5
			IsUsingWorkbench = True
			return WorkbenchFemaleIdles
		elseIf (HasAvailableTable)
			IsUsingTable = True
			return TableOneFemaleIdles
		else
			if (Sequence == 0)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				
				who.SoundTimings[0] = 2.0
				who.SoundTimings[4] = 2.0
				
				return GetIdles(who, SpoonFemaleIdles, True)
			elseIf (Sequence == 1)
				return GetIdles(who, MissOneFemaleIdles, True)
			elseIf (Sequence == 2)
				return GetIdles(who, MissTwoFemaleIdles, True)
			elseIf (Sequence == 3)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 2.0
				
				return GetIdles(who, MissThreeFemaleIdles, True)
			elseIf (Sequence == 4)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				
				who.SoundTimings[0] = 2.0
				who.SoundTimings[4] = 1.333332
				
				return GetIdles(who, AnalMissOneFemaleIdles, True)
			elseIf (Sequence == 5)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				
				who.SoundTimings[0] = 2.0
				who.SoundTimings[4] = 2.0
				
				return GetIdles(who, AnalMissTwoFemaleIdles, True)
			elseIf (Sequence == 6)
				who.SoundTypes[1] = SOUNDTYPE_SOLO_F
				who.SoundTimings[1] = 2.0
				
				return GetIdles(who, MissFeetOneFemaleIdles, True)
			elseIf (Sequence == 7)
				return GetIdles(who, MissFeetTwoFemaleIdles, True)
			elseIf (Sequence == 8)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTypes[4] = SOUNDTYPE_SOLO_F
				
				who.SoundTimings[0] = 1.333332
				who.SoundTimings[4] = 2.0
				
				return GetIdles(who, LotusFemaleIdles, True)
			elseIf (Sequence == 9)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.5
				
				return GetIdles(who, ReverseLotusFemaleIdles, True)
			elseIf (Sequence == 10)
				who.SoundTypes[0] = SOUNDTYPE_SOLO_F
				who.SoundTimings[0] = 1.5
				
				return GetIdles(who, MissFourFemaleIdles, True)
			elseIf (Sequence == 11)
				return GetIdles(who, BillyMissionaryFemaleIdles, True)
			elseIf (Sequence == 12)
				return GetIdles(who, BillyAnalFemaleIdles, True)
			elseIf (Sequence == 13)
				return GetIdles(who, BillyMissionary2FemaleIdles, True)
			elseIf (Sequence == 14)
				who.SchlongBends = new int[7]
				who.SoundTypes = new int[7]
				who.SoundTimings = new float[7]
				return GetIdles(who, NibblesScrewFemaleIdles, True)
			elseIf (Sequence == 15)
				return GetIdles(who, MilkyMiss1FemaleIdles, True)
			elseIf (Sequence == 16)
				return GetIdles(who, MilkyLaying1FemaleIdles, True)
			elseIf (Sequence == 17)
				return GetIdles(who, MilkyMissionary1FemaleIdles, True)
			else
				return GetIdles(who, MilkyLotus1FemaleIdles, True)
				
			;else
			;	who.ScaleTo = 0.9
			;	return GetIdles(who, SapLaying1FemaleIdles, True)
			endIf
		endIf
	elseIf (who.SexType == SexPositions.TokenMissionaryMale)
		if (HasAvailableBed)
			IsUsingBed = True
			if (Sequence == 0)
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.666666
				who.SoundTimings[2] = 0.5333328
				who.SoundTimings[3] = 0.3999996
				
				return BedMissionaryMaleIdles
			else
				who.SchlongBends[2] = -2
				
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[2] = 0.9333324
				who.SoundTimings[3] = 0.4666662	; 0.9333324 /2
				
				return BedMissFeetMaleIdles
			endIf
		elseIf (HasAvailableThrone)
			IsUsingThrone = True
			
			who.SoundTypes[1] = SOUNDTYPE_PIV
			who.SoundTypes[2] = SOUNDTYPE_PIV
			who.SoundTypes[3] = SOUNDTYPE_PIV
			
			who.SoundTimings[1] = 0.666666
			who.SoundTimings[2] = 0.5333328
			who.SoundTimings[3] = 0.5333328
			
			who.SchlongBends[0] = -1
			who.SchlongBends[1] = -1
			who.SchlongBends[3] = -3
			who.SchlongBends[4] = -4
			
			return ThroneMissionaryMaleIdles
		elseIf (HasAvailableWorkbench)
			who.SchlongBends = new int[7]
			who.SchlongBends[0] = -1
			who.SchlongBends[1] = -1
			
			who.SoundTypes = new int[7]
			who.SoundTypes[1] = SOUNDTYPE_SOLO_M
			who.SoundTypes[3] = SOUNDTYPE_PIV
			who.SoundTypes[4] = SOUNDTYPE_PIV
			who.SoundTypes[5] = SOUNDTYPE_PIV
			
			who.SoundTimings = new float[7]
			who.SoundTimings[1] = 1.5
			who.SoundTimings[3] = 1.3999986	; 8.3999916 /6
			who.SoundTimings[4] = 0.9641016	; 12.5333208 /13
			who.SoundTimings[5] = 1.4999985	; 5.999994 /4
			
			IsUsingWorkbench = True
			return WorkbenchMaleIdles
		elseIf (HasAvailableTable)
			IsUsingTable = True
			return TableOneMaleIdles
		else
			if (Sequence == 0)
				who.SchlongBends[0] = 2
				who.SchlongBends[1] = 9
				who.SchlongBends[2] = 9
				who.SchlongBends[3] = 8
				who.SchlongBends[4] = 8
				who.SchlongBends[5] = 8
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
								
				who.SoundTimings[1] = 0.8333325
				who.SoundTimings[2] = 0.6666667
				who.SoundTimings[3] = 0.5333328
				
				return GetIdles(who, SpoonMaleIdles)
			elseIf (Sequence == 1)
				who.SchlongBends[0] = -2
				who.SchlongBends[1] = -2
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.8333325
				who.SoundTimings[2] = 0.5333328
				who.SoundTimings[3] = 0.4666662
				
				return GetIdles(who, MissOneMaleIdles)
			elseIf (Sequence == 2)
				who.SchlongBends[0] = -2
				who.SchlongBends[1] = -2
				who.SchlongBends[2] = -2
				who.SchlongBends[3] = -2
				who.SchlongBends[4] = -2
				who.SchlongBends[5] = -2
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.8333325
				who.SoundTimings[2] = 0.5333328
				who.SoundTimings[3] = 0.4666662
				
				return GetIdles(who, MissTwoMaleIdles)
			elseIf (Sequence == 3)
				who.SchlongBends[2] = -1
				who.SchlongBends[3] = -1
				who.SchlongBends[4] = -1
				who.SchlongBends[5] = -1
			
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.999999
				who.SoundTimings[2] = 0.4999995 ; 1.999998 /4
				who.SoundTimings[3] = 0.4999995 ; 1.999998 /4
			
				return GetIdles(who, MissThreeMaleIdles)
			elseIf (Sequence == 4)
				who.SchlongBends[3] = -7
				who.SchlongBends[4] = -6
				who.SchlongBends[5] = -6
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.999999
				who.SoundTimings[2] = 0.666666
				who.SoundTimings[3] = 0.5333325
								
				return GetIdles(who, AnalMissOneMaleIdles)
			elseIf (Sequence == 5)
				who.SchlongBends[0] = 1
				who.SchlongBends[1] = 1
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.666666
				who.SoundTimings[2] = 0.666666
				who.SoundTimings[3] = 0.4666662
				
				return GetIdles(who, AnalMissTwoMaleIdles)
			elseIf (Sequence == 6)
				who.SchlongBends[2] = -1
				who.SchlongBends[3] = -2
				
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[2] = 0.999999 ; 1.999998 /2
				who.SoundTimings[3] = 0.666666
				
				return GetIdles(who, MissFeetOneMaleIdles)
			elseIf (Sequence == 7)
				who.SchlongBends[0] = 6
				who.SchlongBends[1] = 3
				who.SchlongBends[2] = 1
				who.SchlongBends[3] = 2
				who.SchlongBends[4] = 2
				who.SchlongBends[5] = 2
				
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[1] = SOUNDTYPE_SOLO_M
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_SOLO_M
				
				who.SoundTimings[0] = 1.0
				who.SoundTimings[1] = 1.0
				who.SoundTimings[2] = 0.5333328
				who.SoundTimings[3] = 1.0
				
				return GetIdles(who, MissFeetTwoMaleIdles)
			elseIf (Sequence == 8)
				who.SchlongBends[0] = 1
				who.SchlongBends[1] = 1
				who.SchlongBends[2] = 2
				who.SchlongBends[3] = 3
				who.SchlongBends[4] = 3
				who.SchlongBends[5] = 3
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.7999992
				who.SoundTimings[2] = 0.5999994
				who.SoundTimings[3] = 0.5333328
				
				return GetIdles(who, LotusMaleIdles)
			elseIf (Sequence == 9)
				who.SchlongBends[1] = 1
				who.SchlongBends[3] = 1
				who.SchlongBends[4] = 1
				who.SchlongBends[5] = 1
				
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.9333324	; 2.7999972 /3
				who.SoundTimings[3] = 0.9333324	; 2.7999972 /3
			
				return GetIdles(who, ReverseLotusMaleIdles)
			elseIf (Sequence == 10)
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 2.23999776	; 11.1999888 /5
				who.SoundTimings[2] = 1.5999984	; 6.3999936 /4
				who.SoundTimings[3] = 1.333332	; 5.333328 /4
			
				return GetIdles(who, MissFourMaleIdles)
			elseIf (Sequence == 11)
				who.SchlongBends[1] = 1
				who.SchlongBends[2] = 1
				who.SchlongBends[3] = 5
				who.SchlongBends[4] = 5
				who.SchlongBends[5] = 5
			
				who.SoundTypes[0] = SOUNDTYPE_SOLO_M
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 1.0
				who.SoundTimings[3] = 0.444444	; 7.999992 /18
				
				return GetIdles(who, BillyMissionaryMaleIdles)
			elseIf (Sequence == 12)
				who.SchlongBends[1] = -1
				who.SchlongBends[2] = -1
			
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[1] = 0.814814	; 7.333326 /9
				who.SoundTimings[2] = 0.4923072	; 6.3999936 /13
				who.SoundTimings[3] = 0.3764702	; 6.3999936 /17
			
				return GetIdles(who, BillyAnalMaleIdles)
			elseIf (Sequence == 13)
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				
				who.SoundTimings[0] = 0.666666	; 7.999992 /12
				who.SoundTimings[1] = 0.4999995	; 7.999992 /16
				who.SoundTimings[2] = 0.444444	; 7.999992 /18
				who.SoundTimings[3] = 0.363636	; 7.999992 /22
				
				return GetIdles(who, BillyMissionary2MaleIdles)
			elseIf (Sequence == 14)
				who.SchlongBends = new int[7]
				who.SoundTypes = new int[7]
				who.SoundTypes[0] = SOUNDTYPE_PIV
				who.SoundTypes[1] = SOUNDTYPE_PIV
				who.SoundTypes[2] = SOUNDTYPE_PIV
				who.SoundTypes[3] = SOUNDTYPE_PIV
				who.SoundTypes[4] = SOUNDTYPE_PIV
				
				who.SoundTimings = new float[7]
				who.SoundTimings[0] = 1.0666656	; 6.3999936 /6
				who.SoundTimings[1] = 0.666666	; 5.333328 /8
				who.SoundTimings[2] = 0.666666	; 5.333328 /8
				who.SoundTimings[3] = 0.7333326	; 5.8666608 /8
				who.SoundTimings[4] = 0.444444	; 5.333328 /12
				
				return GetIdles(who, NibblesScrewMaleIdles)
			elseIf (Sequence == 15)
				who.SchlongBends[1] = -1
				who.SchlongBends[2] = -1
				who.SchlongBends[3] = -1
				who.SchlongBends[4] = 2
				who.SchlongBends[5] = 2
				
				return GetIdles(who, MilkyMiss1MaleIdles)
			elseIf (Sequence == 16)
				who.SchlongBends[0] = 3
				who.SchlongBends[1] = -1
				who.SchlongBends[4] = 3
				who.SchlongBends[5] = 3
				return GetIdles(who, MilkyLaying1MaleIdles)
			elseIf (Sequence == 17)
				who.SchlongBends[0] = -1
				who.SchlongBends[2] = -2
				who.SchlongBends[3] = -2
				who.SchlongBends[4] = -1
				who.SchlongBends[5] = -1
				return GetIdles(who, MilkyMissionary1MaleIdles)
			else
				who.SchlongBends[0] = -2
				who.SchlongBends[1] = -3
				who.SchlongBends[2] = -2
				who.SchlongBends[3] = -1
				who.SchlongBends[4] = -2
				who.SchlongBends[5] = -2
				return GetIdles(who, MilkyLotus1MaleIdles)
			;else
			;	who.SchlongBends = new int[11]
			;	who.SchlongBends[0] = 4
			;	who.SchlongBends[1] = 0
			;	who.SchlongBends[2] = -6
			;	who.SchlongBends[3] = 3
			;	who.SchlongBends[4] = 0
			;	who.SchlongBends[5] = -1
			;	who.SchlongBends[6] = 4
			;	who.SchlongBends[7] = -9
			;	who.SchlongBends[8] = -4
			;	who.SchlongBends[9] = -3
			;	who.SchlongBends[10] = -2
			;	return GetIdles(who, SapLaying1MaleIdles)
			endIf
		endIf
	
	; *** Anal Cow Scene	************************
	elseIf (who.SexType == SexPositions.TokenAnalCowFemale)
		return GetIdles(who, AnalRevCowFemaleIdles, True)
	elseIf (who.SexType == SexPositions.TokenAnalCowMale)
		return GetIdles(who, AnalRevCowMaleIdles)
	
	; *** Anal Doggy Scene	************************
	elseIf (who.SexType == SexPositions.TokenAnalDoggyFemale)
		if (Sequence == 0)
			return GetIdles(who, AnalDoggyOneFemaleIdles, True)
		else
			return GetIdles(who, AnalDoggyTwoFemaleIdles, True)
		endIf
	elseIf (who.SexType == SexPositions.TokenAnalDoggyMale)
		if (Sequence == 0)
			who.SchlongBends[0] = 0
			who.SchlongBends[1] = 0
			who.SchlongBends[2] = 0
			who.SchlongBends[3] = 1
			who.SchlongBends[4] = 2
			who.SchlongBends[5] = 2
			return GetIdles(who, AnalDoggyOneMaleIdles)
		else
			return GetIdles(who, AnalDoggyTwoMaleIdles)
		endIf
	
	; *** Anal Standing Scene	************************
	elseIf (who.SexType == SexPositions.TokenAnalStandingFemale)
		return GetIdles(who, AnalPowerbombFemaleIdles, True)
	elseIf (who.SexType == SexPositions.TokenAnalStandingMale)
		who.SchlongBends[0] = -2
		who.SchlongBends[1] = -2
		who.SchlongBends[2] = -2
		who.SchlongBends[3] = -2
		who.SchlongBends[4] = -2
		who.SchlongBends[5] = -2
		return GetIdles(who, AnalPowerbombMaleIdles)
	
	; *** Anal Missionary Scene	************************
	elseIf (who.SexType == SexPositions.TokenAnalMissionaryFemale)
		if (Sequence == 0)
			return GetIdles(who, AnalMissOneFemaleIdles, True)
		elseIf (Sequence == 1)
			return GetIdles(who, AnalMissTwoFemaleIdles, True)
		else
			return GetIdles(who, BillyAnalFemaleIdles, True)
		endIf
	elseIf (who.SexType == SexPositions.TokenAnalMissionaryMale)
		if (Sequence == 0)
			who.SchlongBends[3] = -4
			who.SchlongBends[4] = -4
			who.SchlongBends[5] = -4
			return GetIdles(who, AnalMissOneMaleIdles)
		elseIf (Sequence == 1)
			who.SchlongBends[3] = -2
			who.SchlongBends[4] = -2
			who.SchlongBends[5] = -2
			return GetIdles(who, AnalMissTwoMaleIdles)
		else
			return GetIdles(who, BillyAnalFemaleIdles)
		endIf
	
	; *** Threesome Scene	************************
	elseIf (who.SexType == SexPositions.TokenFFMActor1)
		if (Sequence == 0)
			return FfmOneActor1Idles
		elseIf (Sequence == 1)
			return FfmTwoActor1Idles
		elseIf (Sequence == 2)
			return FfmThreeActor1Idles
		else
			return FfmFourActor1Idles
		endIf		
	elseIf (who.SexType == SexPositions.TokenFFMActor2)
		if (Sequence == 0)
			who.SchlongBends[1] = -4
			who.SchlongBends[3] = -2
			return FfmOneActor2Idles
		elseIf (Sequence == 1)
			who.SchlongBends[1] = -2
			who.SchlongBends[3] = -2
			who.SchlongBends[4] = -2
			who.SchlongBends[5] = -2
			return FfmTwoActor2Idles
		elseIf (Sequence == 2)
			return FfmThreeActor2Idles
		else
			return FfmFourActor2Idles
		endIf
	elseIf (who.SexType == SexPositions.TokenFFMActor3)
		if (Sequence == 0)
			return FfmOneActor3Idles
		elseIf (Sequence == 1)
			return FfmTwoActor3Idles
		elseIf (Sequence == 2)
			return FfmThreeActor3Idles
		else
			return FfmFourActor3Idles
		endIf
	elseIf (who.SexType == SexPositions.TokenMMFActor1)
		if (Sequence > 2 && Sequence < 10)
			; Suppress sound for the female
			who.SuppressSound = True
			; Use oral expression over-ride
			who.UseOralExpression = True
		
			bool[] oralExpressions = new bool[6]
			oralExpressions[0] = False
			oralExpressions[1] = True
			oralExpressions[2] = True
			oralExpressions[3] = True
			oralExpressions[4] = True
			oralExpressions[5] = False	
			who.OralExpressionToggles = oralExpressions

			who.SoundTypes[0] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[1] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[2] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[3] = SOUNDTYPE_ORAL_F_HEAVY
			who.SoundTypes[4] = SOUNDTYPE_ORAL_F_HEAVY
			
			who.SoundTimings[0] = 1.0
			who.SoundTimings[1] = 2.0
			who.SoundTimings[2] = 2.0
			who.SoundTimings[3] = 2.0
			who.SoundTimings[4] = 2.0
		endIf
		if (Sequence == 0)
			return MmfOneActor1Idles
		elseIf (Sequence == 1)
			return MmfTwoActor1Idles
		elseIf (Sequence == 2)
			return MmfThreeActor1Idles
		elseIf (Sequence == 3)
			return MmfFourActor1Idles
		elseIf (Sequence == 4)
			return MMFBillyAnalActor1Idles
		elseIf (Sequence == 5)
			bool[] oralExpressions = new bool[6]
			oralExpressions[0] = False
			oralExpressions[1] = False
			oralExpressions[2] = True
			oralExpressions[3] = True
			oralExpressions[4] = True
			oralExpressions[5] = False	
			who.OralExpressionToggles = oralExpressions
						
			who.SoundTypes[1] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[2] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[3] = SOUNDTYPE_ORAL_F_HEAVY
			who.SoundTypes[4] = SOUNDTYPE_ORAL_F_HEAVY
			
			who.SoundTimings[1] = 1.0
			who.SoundTimings[2] = 2.0
			who.SoundTimings[3] = 2.0
			who.SoundTimings[4] = 2.0		
			
			return MMFBillyCowgirlActor1Idles
		elseIf (Sequence == 6)
			return MMFBillyKneelingActor1Idles
		elseIf (Sequence == 7)
			return MMFBillySpitActor1Idles
		elseIf (Sequence == 8)
			return MMFBillyStandingActor1Idles
		elseIf (Sequence == 9)
			
			bool[] oralExpressions = new bool[7]
			oralExpressions[0] = False
			oralExpressions[1] = False
			oralExpressions[2] = True
			oralExpressions[3] = True
			oralExpressions[4] = True
			oralExpressions[5] = True
			oralExpressions[6] = True			
			who.OralExpressionToggles = oralExpressions
			
			who.SoundTypes = new int[7]
			who.SoundTypes[1] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[2] = SOUNDTYPE_ORAL_F_LIGHT
			who.SoundTypes[3] = SOUNDTYPE_ORAL_F_MEDIUM
			who.SoundTypes[4] = SOUNDTYPE_ORAL_F_HEAVY
			who.SoundTypes[5] = SOUNDTYPE_ORAL_F_HEAVY
			who.SoundTypes[6] = SOUNDTYPE_ORAL_F_HEAVY
			
			who.SoundTimings = new float[7]
			who.SoundTimings[1] = 1.0
			who.SoundTimings[2] = 1.0
			who.SoundTimings[3] = 2.0
			who.SoundTimings[4] = 2.0
			who.SoundTimings[5] = 2.0
			who.SoundTimings[6] = 2.0
			
			return MMFBillyDoubleBJActor1Idles
		else
			return MMFBillyDP1Actor1Idles
		endIf		
	elseIf (who.SexType == SexPositions.TokenMMFActor2)
		if (Sequence == 0)
			return MmfOneActor2Idles
		elseIf (Sequence == 1)
			who.SchlongBends[0] = -1
			return MmfTwoActor2Idles
		elseIf (Sequence == 2)
			who.SchlongBends[2] = 5
			who.SchlongBends[3] = 5
			who.SchlongBends[4] = 5
			who.SchlongBends[5] = 5
			return MmfThreeActor2Idles
		elseIf (Sequence == 3)
			return MmfFourActor2Idles
		elseIf (Sequence == 4)
			who.SchlongBends[1] = -2
			who.SchlongBends[2] = -1
			return MMFBillyAnalActor2Idles
		elseIf (Sequence == 5)
			who.SchlongBends[0] = -1
			return MMFBillyCowgirlActor2Idles
		elseIf (Sequence == 6)
			return MMFBillyKneelingActor2Idles
		elseIf (Sequence == 7)
			who.SchlongBends[2] = -1
			who.SchlongBends[3] = -1
			who.SchlongBends[4] = -3
			who.SchlongBends[5] = -3
			return MMFBillySpitActor2Idles
		elseIf (Sequence == 8)
			return MMFBillyStandingActor2Idles
		elseIf (Sequence == 9)
			return MMFBillyDoubleBJActor2Idles
		else
			who.SchlongBends[1] = 7
			who.SchlongBends[2] = 8
			who.SchlongBends[3] = 8
			who.SchlongBends[4] = 8
			who.SchlongBends[5] = 8
			return MMFBillyDP1Actor2Idles
		endIf
	elseIf (who.SexType == SexPositions.TokenMMFActor3)
		if (Sequence == 0)
			who.SchlongBends[2] = 1
			return MmfOneActor3Idles
		elseIf (Sequence == 1)
			who.SchlongBends[2] = 8
			who.SchlongBends[3] = 8
			who.SchlongBends[4] = 8
			who.SchlongBends[5] = 8
			return MmfTwoActor3Idles
		elseIf (Sequence == 2)
			return MmfThreeActor3Idles
		elseIf (Sequence == 3)
			return MmfFourActor3Idles
		elseIf (Sequence == 4)
			return MMFBillyAnalActor3Idles
		elseIf (Sequence == 5)
			return MMFBillyCowgirlActor3Idles
		elseIf (Sequence == 6)
			return MMFBillyKneelingActor3Idles
		elseIf (Sequence == 7)
			return MMFBillySpitActor3Idles
		elseIf (Sequence == 8)
			return MMFBillyStandingActor3Idles
		elseIf (Sequence == 9)
			return MMFBillyDoubleBJActor3Idles
		else
			who.SchlongBends[1] = 7
			who.SchlongBends[2] = 8
			who.SchlongBends[3] = 8
			who.SchlongBends[4] = 8
			who.SchlongBends[5] = 8
			return MMFBillyDP1Actor3Idles
		endIf
	elseIf (who.SexType == SexPositions.TokenFFFActor1)
		return FffOneActor1Idles
	elseIf (who.SexType == SexPositions.TokenFFFActor2)
		return FffOneActor2Idles
	elseIf (who.SexType == SexPositions.TokenFFFActor3)
		return FffOneActor3Idles
	
	; *** Solo Female Scene ********************
	elseIf (who.SexType == SexPositions.TokenSoloFemale)
		if (HasAvailableChair)
			IsUsingChair = True
			if (Sequence == 0)
				return ChairSoloFemaleIdles
			else
				return ChairSoloTwoFemaleIdles
			endIf
		else
			if (Sequence == 0)
				return SoloFemaleIdles
			elseIf (Sequence == 1)
				return SoloFemaleDildoVagIdles
			elseIf (Sequence == 2)
				return SoloFemaleDildoAnalIdles
			elseIf (Sequence == 3)
				return SoloFemaleTwoIdles
			elseIf (Sequence == 4)
				return SoloFemaleToyAnalIdles
			elseIf (Sequence == 5)
				return SoloFemaleToyVagIdles
			elseIf (Sequence == 6)
				return SoloFemaleBumIdles
			elseIf (Sequence == 7)
				return SoloFemaleKneesIdles
			elseIf (Sequence == 8)
				return SoloFemaleKneesTwoIdles
			elseIf (Sequence == 9)
				return SoloFemaleFitnessIdles
			else
				return SoloFemaleSquatIdles
			endIf
		endIf
		
	; *** Solo Male Scene ********************
	elseIf (who.SexType == SexPositions.TokenSoloMale)
		who.EjaculationStages[5] = True
		if (Sequence == 0)
			who.EjaculationStages = new bool[4]
			who.EjaculationStages[3] = True 
			return SoloMaleKneeling
		elseIf (Sequence == 1)
			return SoloMaleStandingOne
		elseIf (Sequence == 2)
			return SoloMaleStandingTwo
		elseIf (Sequence == 3)
			return SoloMaleStandingThree
		elseIf (Sequence == 4)
			return SoloMaleLayingOne
		elseIf (Sequence == 5)
			return SoloMaleLayingTwo
		elseIf (Sequence == 6)
			return SoloMaleLayingThree
		else
			who.EjaculationStages = new bool[4]
			who.EjaculationStages[3] = True 
			return BillyMaleMasturbation1Idles
		endIf
		
	; *** Kissing Scene	************************
	elseIf (who.SexType == SexPositions.TokenKissingFemale)
		who.IsUsingKissing = True
		return RetrieveKissingSequence(False, True)
	elseIf (who.SexType == SexPositions.TokenKissingMale)
		who.IsUsingKissing = True
		return RetrieveKissingSequence(False, False)
	elseIf (who.SexType == SexPositions.TokenKissingMaleFemale)
		return RetrieveKissingSequence(True, True)
		who.IsUsingKissing = True
	elseIf (who.SexType == SexPositions.TokenKissingMaleMale)
		who.IsUsingKissing = True
		return RetrieveKissingSequence(True, False)
	endIf
	
	Debug.Trace(Self + " ConvertTokenToIdles: Unable to locate the token, empty array returned")
	return new string[1]
endFunction

; -----------------------------------------------------------------------------------------
; ConvertTokenToSequences(): Function to retrieve the number of available
; animation sequences from a given category. Used for gettting the max
; random number.
;------------------------------------------------------------------------------------------
int Function ConvertTokenToSequences(dxAliasActor Who)

	if (HasAvailableBed || HasAvailableChair || HasAvailableThrone || HasAvailableWorkbench || HasAvailableTable \
			|| HasAvailableEnchantingBench || HasAvailableAlchemyBench)
		return 1
	endIf

	if (who.SexType == SexPositions.TokenFFMActor1 || who.SexType == SexPositions.TokenFFMActor2 || who.SexType == SexPositions.TokenFFMActor3)
		return 4
	endIf
	
	if (who.SexType == SexPositions.TokenMMFActor1 || who.SexType == SexPositions.TokenMMFActor2 || who.SexType == SexPositions.TokenMMFActor3)
		return 10
	endIf

	if (who.SexType == SexPositions.TokenStandingFemale || who.SexType == SexPositions.TokenStandingMale)
		return 6
	endIf
	
	if (who.SexType == SexPositions.TokenMissionaryFemale || who.SexType == SexPositions.TokenMissionaryMale)
		return 18
	endIf
	
	if (who.SexType == SexPositions.TokenSoloFemale)
		return 10
	endIf
	
	if (who.SexType == SexPositions.TokenOralFemale || who.SexType == SexPositions.TokenOralMale)
		return 5
	endIf
	
	if (who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale \ 
			|| who.SexType == SexPositions.TokenSoloMale)
		return 7
	endIf
	
	if (who.SexType == SexPositions.TokenCowgirlFemale || who.SexType == SexPositions.TokenCowgirlMale)
		return 13
	endIf
		
	if (who.SexType == SexPositions.TokenAnalMissionaryFemale || who.SexType == SexPositions.TokenAnalMissionaryMale \
			|| who.SexType == SexPositions.TokenCunnilingusFemale || who.SexType == SexPositions.TokenCunnilingusMale)
		return 2
	endIf
	
	if (who.SexType == SexPositions.TokenLesbianFemale || who.SexType == SexPositions.TokenLesbianMale)
		return 9
	endIf
	
	return 1	; Default return value to allow for 1-2 sequences
	
endFunction

string[] Function RetrieveKissingSequence(bool IsMaleStart, bool Giving)
	
	if (IsMaleStart)
		if (Giving)
			return KissingMaleFemaleIdles
		else
			return KissingMaleMaleIdles
		endIf
	else
		if (Giving)
			return KissingFemaleIdles
		else
			return KissingMaleIdles
		endIf
	endIf

endFunction

string[] Function GetIdles(dxAliasActor who, string[] Anims, bool Giving = False, bool IsMaleStart = False)
	
	if (FlowerGirlsConfig.DX_USE_KISSES.GetValueInt() != 1 || FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.GetValueInt() > 0)
		return Anims
	endIf
	
	string[] Kisses = RetrieveKissingSequence(IsMaleStart, Giving)
	
	int arrayLen = (Kisses.Length + Anims.Length)
	string[] _idles = new string[9]
	
	if (arrayLen == 7)
		_idles = new string[7]
	elseIf (arrayLen == 8)
		_idles = new string[8]
	elseIf (arrayLen == 10)
		_idles = new string[10]
	elseIf (arrayLen == 11)
		_idles = new string[11]
	elseIf (arrayLen == 13)
		_idles = new string[13]
	elseIf (arrayLen == 16)
		_idles = new string[16]
	endIf
	
	int kissCnt = 0
	while  (kissCnt < Kisses.Length)
		_idles[kissCnt] = Kisses[kissCnt]
		kissCnt += 1
	endWhile
	
	int cnt = kissCnt
	int animsCnt = 0
	while (cnt < arrayLen)
		_idles[cnt] = Anims[animsCnt]
		animsCnt += 1
		cnt += 1
	endWhile
	
	who.IsUsingKissing = True
	
	return _idles
endFunction

;--------------------------------------------------------------------------------------
; ConvertTokenToDurations(): Searches the actor for a love token and
; returns the animation durations according to the token. This function
; allows us to customize durations on a scene basis.
;--------------------------------------------------------------------------------------
float[] Function ConvertTokenToDurations(dxAliasActor who, int Sequence)
	
	float[] _durations
	float fMod = 1.0
	int iDuration = FlowerGirlsConfig.DX_SCENE_DURATION.GetValueInt()
	if (iDuration == 0)
		fMod = 0.7
	elseIf (iDuration == 2)
		fMod = 1.5
	elseIf (iDuration == 3)
		fMod = 2.0
	elseIf (iDuration == 4)
		fMod = 3.0
	elseIf (iDuration == 5)
		fMod = 4.0
	elseIf (iDuration == 6)
		fMod = 6.0
	endIf
	
	if (who.SexType == SexPositions.TokenSoloFemale)
		if (IsUsingChair && Sequence == 1)
			_durations = new float[5]
			_durations[0] = 10
			_durations[1] = (10.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = 25.0
			return _durations
		endIf
		if (Sequence == 4 || Sequence == 5)
			_durations = new float[7]
			_durations[0] = 1.5
			_durations[4] = (10.0 * fMod)
			_durations[5] = 2.0
			_durations[6] = 1.0
		elseIf (Sequence == 3) ; Nibbles solo f
			_durations = new float[6]
			_durations[0] = 10.0
			_durations[1] = (10.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = 25.0
			_durations[5] = 1.0
			return _durations
		elseIf (Sequence == 6) ; Bum
			_durations = new float[5]
			_durations[0] = 10.0
			_durations[1] = 30.0
			_durations[2] = 30.0
			_durations[3] = 10.0
			_durations[4] = 1.0
			return _durations
		elseIf (Sequence == 7) ; Knees 1
			_durations = new float[6]
			_durations[0] = 10.0
			_durations[1] = 30.0
			_durations[2] = 30.0
			_durations[3] = 30.0
			_durations[4] = 10.0
			_durations[5] = 1.0
			return _durations
		elseIf (Sequence == 8) ; Knees 2
			_durations = new float[4]
			_durations[0] = 10.0
			_durations[1] = 30.0
			_durations[2] = 20.0
			_durations[3] = 1.0
			return _durations
		elseIf (Sequence == 9) ; Fitness
			_durations = new float[5]
			_durations[0] = 10.0
			_durations[1] = 30.0
			_durations[2] = 30.0
			_durations[3] = 30.0
			_durations[4] = 1.0
			return _durations
		elseIf (Sequence == 10) ; Squat
			_durations = new float[5]
			_durations[0] = 30.0
			_durations[1] = 30.0
			_durations[2] = 30.0
			_durations[3] = 10.0
			_durations[4] = 1.0
			return _durations
		else
			_durations = new float[6]
			_durations[0] = 10
			_durations[4] = (10.0 * fMod)
			_durations[5] = 2.0
		endIf
		_durations[1] = (10.0 * fMod)
		_durations[2] = (20.0 * fMod)
		_durations[3] = (20.0 * fMod)
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenSoloMale)
		if (Sequence == 0)
			_durations = new float[4]
			_durations[0] = 1.3
			_durations[1] = 26.1
			_durations[2] = 26.1
			_durations[3] = 15.0
		elseIf (Sequence >= 1 && Sequence <= 3)
			_durations = new float[6]
			_durations[0] = 5.5
			_durations[1] = 44.0
			_durations[2] = 5.3
			_durations[3] = 22.0	
			_durations[4] = 42.0
			_durations[5] = 21.0
		elseIf (Sequence == 7) ; Billyy's male masturbation
			_durations = new float[5]
			_durations[0] = 25.0
			_durations[1] = 25.0
			_durations[2] = 25.0
			_durations[3] = 25.0
			_durations[4] = 7.4
		else
			_durations = new float[6]
			_durations[0] = 5.5
			_durations[1] = 44.0
			_durations[2] = 5.3
			_durations[3] = 33.0	
			_durations[4] = 42.0
			_durations[5] = 23.0
		endIf		
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenKissingFemale || who.SexType == SexPositions.TokenKissingMale   \
		|| who.SexType == SexPositions.TokenKissingMaleFemale || who.SexType == SexPositions.TokenKissingMaleMale)
			
		_durations = new float[3]
		_durations[0] = 3.45
		_durations[1] = 18.66
		_durations[2] = 1.4
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenFFMActor1) || (who.SexType == SexPositions.TokenFFMActor2) || (who.SexType == SexPositions.TokenFFMActor3)
		_durations = new float[6]
		_durations[0] = (10.0 * fMod)
		_durations[1] = (20.0 * fMod)
		_durations[2] = (20.0 * fMod)
		_durations[3] = (20.0 * fMod)
		_durations[4] = (10.0 * fMod)
		_durations[5] = 1.5
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenMMFActor1) || (who.SexType == SexPositions.TokenMMFActor2) || (who.SexType == SexPositions.TokenMMFActor3)
		if (Sequence == 9)
			_durations = new float[8]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[5] = (20.0 * fMod)
			_durations[6] = 7.2
			_durations[7] = 7.2
			return _durations
		elseIf (Sequence == 10)	; MMFBillyDP1
			_durations = new float[6]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = 16.6
			_durations[5] = 8.33
			return _durations
		else
			_durations = new float[6]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (10.0 * fMod)
			_durations[5] = 1.5
			return _durations
		endIf
	endIf
	
	if (who.SexType == SexPositions.TokenFFFActor1) || (who.SexType == SexPositions.TokenFFFActor2) || (who.SexType == SexPositions.TokenFFFActor3)
		_durations = new float[6]
		_durations[0] = (10.0 * fMod)
		_durations[1] = (20.0 * fMod)
		_durations[2] = (20.0 * fMod)
		_durations[3] = (20.0 * fMod)
		_durations[4] = (10.0 * fMod)
		_durations[5] = 1.5
		return _durations
	endIf
	
	if (IsUsingBed && (who.SexType == SexPositions.TokenOralFemale || who.SexType == SexPositions.TokenOralMale))
		_durations = new float[6]
		_durations[0] = (10.0 * fMod)
		_durations[1] = (20.0 * fMod)
		_durations[2] = (20.0 * fMod)
		_durations[3] = (20.0 * fMod)
		_durations[4] = (10.0 * fMod)
		_durations[5] = 1.67
		return _durations
	endIf
	
	bool bKissingUsed = (FlowerGirlsConfig.DX_USE_KISSES.GetValueInt() == 1 && FlowerGirlsConfig.DX_USE_KISSES_OVERRIDE.GetValueInt() == 0)
	
	if (who.SexType == SexPositions.TokenCowgirlFemale || who.SexType == SexPositions.TokenCowgirlMale)
		if (IsUsingBed)
			_durations = new float[6]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (10.0 * fMod)
			_durations[5] = 1.34
			return _durations
		endIf
		if (IsUsingThrone)
			_durations = new float[6]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (10.0 * fMod)
			_durations[5] = 2.67
			return _durations
		endIf
		if (Sequence == 13)	; NibblesReverseCowgirl2
			if (bKissingUsed)
				_durations = new float[10]
				_durations[0] = 3.45
				_durations[1] = 9.33
				_durations[2] = 1.4
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[5] = (20.0 * fMod)
				_durations[6] = (20.0 * fMod)
				_durations[7] = (20.0 * fMod)
				_durations[8] = 12.0
				_durations[9] = 6.0
			else
				_durations = new float[7]
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[2] = (20.0 * fMod)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[5] = 12.0
				_durations[6] = 6.0
			endIf
		else
			if (bKissingUsed)
				_durations = new float[9]
				_durations[0] = 3.45
				_durations[1] = 9.33
				_durations[2] = 1.4
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[5] = (20.0 * fMod)
				_durations[6] = (20.0 * fMod)
				_durations[7] = (10.0 * fMod)
				_durations[8] = 1.5
			else
				_durations = new float[6]
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[2] = (20.0 * fMod)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (10.0 * fMod)
				_durations[5] = 1.5
			endIf
			if (Sequence == 9)		; MilkyCowgirl1
				if (bKissingUsed)
					_durations[7] = 10.579
					_durations[8] = 1.0579
				else
					_durations[4] = 10.579
					_durations[5] = 1.0579
				endIf
			elseIf (Sequence == 10)	; MilkyCowgirlMiss
				if (bKissingUsed)
					_durations[7] = 13.75
					_durations[8] = 1.375
				else
					_durations[4] = 13.75
					_durations[5] = 1.375
				endIf
			elseIf (Sequence == 11)	; MilkyCowgirl2
				if (bKissingUsed)
					_durations[7] = 13.965
					_durations[8] = 6.982
				else
					_durations[4] = 13.965
					_durations[5] = 6.982
				endIf
			elseIf (Sequence == 12)	; MilkyRevCow1
				if (bKissingUsed)
					_durations[7] = 13.33
					_durations[8] = 1.904
				else
					_durations[4] = 13.33
					_durations[5] = 1.904
				endIf
			endIf
		endIf
		return _durations
	endIf	
	
	; NibblesLesbianCuddling1
	if ((who.SexType == SexPositions.TokenLesbianFemale || who.SexType == SexPositions.TokenLesbianMale) && Sequence == 9)
		if (bKissingUsed)
			_durations = new float[10]
			_durations[0] = 3.45
			_durations[1] = 9.33
			_durations[2] = 1.4
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[5] = (20.0 * fMod)
			_durations[6] = (20.0 * fMod)
			_durations[7] = (20.0 * fMod)
			_durations[8] = 12.8
			_durations[9] = 6.4
		else
			_durations = new float[7]
			_durations[0] = (20.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[5] = 12.8
			_durations[6] = 6.4
		endIf
		return _durations
	endIf
	
	; Set up default durations
	if (bKissingUsed && IsUsingBed == False && IsUsingThrone == False && IsUsingChair == False && IsUsingWorkbench == False \
			&& IsUsingTable == False && IsUsingAlchemyBench == False && IsUsingEnchantingBench == False)
		
		_durations = new float[9]
		_durations[0] = 3.45
		_durations[1] = 9.33
		_durations[2] = 1.4
		_durations[3] = (10.0 * fMod)
		_durations[4] = (10.0 * fMod)
		_durations[5] = (20.0 * fMod)
		_durations[6] = (20.0 * fMod)
		_durations[7] = (10.0 * fMod)
		_durations[8] = 1.5
		
	else
		if (IsUsingWorkbench)
			_durations = new float[7]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (10.0 * fMod)
			_durations[2] = 14.8333185
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[5] = 11.999988
			_durations[6] = 5.999994
			return _durations
		elseIf (IsUsingAlchemyBench)
			if (Sequence == 0)
				_durations = new float[7]
				_durations[0] = (10.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[2] = (20.0 * fMod)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[5] = 8.4
				_durations[6] = 8.4
			else
				_durations = new float[6]
				_durations[0] = (10.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[2] = (20.0 * fMod)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[5] = 8.4
			endIf
			return _durations
		elseIf (IsUsingEnchantingBench)
			_durations = new float[6]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (10.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = 8.4
			_durations[5] = 8.4
			return _durations
		elseIf (IsUsingChair)
			_durations = new float[6]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (10.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (10.0 * fMod)
			_durations[5] = 8.7
			return _durations
		else	
			_durations = new float[6]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (10.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (10.0 * fMod)
			_durations[5] = 1.5
		endIf
	endIf
	
	if (who.SexType == SexPositions.TokenOralFemale || who.SexType == SexPositions.TokenOralMale)
		if (Sequence == 5)		; Nibbles 69 Animation
			if (bKissingUsed)
				_durations[7] = 11.4
				_durations[8] = 5.7
			else
				_durations[4] = 11.4
				_durations[5] = 5.7
			endIf
			return _durations
		endIf
	endIf
	
	if (who.SexType == SexPositions.TokenDoggyFemale || who.SexType == SexPositions.TokenDoggyMale)
		if (Sequence == 6)		; MilkyDoggy1
			if (bKissingUsed)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[7] = 13.75
				_durations[8] = 1.375
			else
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[4] = 13.75
				_durations[5] = 1.375
			endIf
			return _durations
		elseIf (Sequence == 7)	; MilkyDoggy2
			if (bKissingUsed)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[7] = 15.869
				_durations[8] = 1.587
			else
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[4] = 15.869
				_durations[5] = 1.587
			endIf
			return _durations
		endIf
	endIf
	
	if (who.SexType == SexPositions.TokenCunnilingusFemale || who.SexType == SexPositions.TokenCunnilingusMale)
		If (Sequence == 2)	; MilkyCunni1
			if (bKissingUsed)
				_durations[7] = 15.236
				_durations[8] = 3.809
			else
				_durations[4] = 15.236
				_durations[5] = 3.809
			endIf
			return _durations
		else
			if (bKissingUsed)
				_durations[4] = (20.0 * fMod)
				_durations[7] = 6.0
			else
				_durations[1] = (20.0 * fMod)
				_durations[4] = 6.0
			endIf	
			return _durations
		endIf
	endIf
	
	if (who.SexType == SexPositions.TokenLesbianCunnilingusFemale || who.SexType == SexPositions.TokenLesbianCunnilingusMale)
		if (bKissingUsed)
			_durations[7] = (8.1 * fMod)
			_durations[8] = 8.1
		else
			_durations[4] = (8.1 * fMod)
			_durations[5] = 8.1
		endIf
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenLesbianFemale || who.SexType == SexPositions.TokenLesbianMale)
		if (bKissingUsed)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[7] = 5.0
			if (Sequence == 2)
				_durations[4] = 6.0
				_durations[5] = (30.0 * fMod)
				_durations[7] = 12.0
				_durations[8] = 6.0
			elseIf (Sequence == 3)
				_durations[7] = 8.0
				_durations[8] = 4.0
			elseIf (Sequence >= 4 && Sequence <= 6)
				_durations[7] = (16.61 * fMod)
				_durations[8] = 8.33
			elseIf (Sequence == 7)		; MilkyLesbian1
				_durations[7] = 11.849
				_durations[8] = 5.924
			elseIf (Sequence == 8)		; BillyLesbianMagicDildo1
				_durations[7] = 16.61
				_durations[8] = 8.33
			endIf
		else
			_durations[0] = (20.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[4] = 5.0
			if (Sequence == 2)
				_durations[1] = 6.0
				_durations[2] = (30.0 * fMod)
				_durations[4] = 12.0
				_durations[5] = 6.0
			elseIf (Sequence == 3)
				_durations[4] = 8.0
				_durations[5] = 4.0
			elseIf (Sequence >= 4 && Sequence <= 6)
				_durations[4] = (16.61 * fMod)
				_durations[5] = 8.33
			elseIf (Sequence == 7)		; MilkyLesbian1
				_durations[0] = (10.0 * fMod)
				_durations[4] = 11.849
				_durations[5] = 5.924
			elseIf (Sequence == 8)		; BillyLesbianMagicDildo1
				_durations[4] = 16.61
				_durations[5] = 8.33
			endIf
		endIf
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenDildoFemale || who.SexType == SexPositions.TokenDildoMale) 
		if (bKissingUsed)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[7] = 6.0
		else
		    _durations[0] = (20.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[4] = 6.0
		endIf
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenTittyFemale || who.SexType == SexPositions.TokenTittyMale)
		if (bKissingUsed)
			_durations[7] = 5.3
			_durations[8] = 5.3
		else
			_durations[4] = 5.3
			_durations[5] = 5.3
		endIf
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenMissionaryFemale || who.SexType == SexPositions.TokenMissionaryMale)
		if (Sequence == 13)
			if (bKissingUsed)
				_durations = new float[14]
				_durations[0] = 3.45
				_durations[1] = 9.33
				_durations[2] = 1.4
				_durations[3] = 10.0
				_durations[4] = 10.0
				_durations[5] = 10.0
				_durations[6] = 10.0
				_durations[7] = 10.0
				_durations[8] = 10.0
				_durations[9] = 10.0
				_durations[10] = 10.0
				_durations[11] = 10.0
				_durations[12] = 10.0
				_durations[13] = 10.0
			else
				_durations = new float[11]
				_durations[0] = 10.0
				_durations[1] = 10.0
				_durations[2] = 10.0
				_durations[3] = 10.0
				_durations[4] = 10.0
				_durations[5] = 10.0
				_durations[6] = 10.0
				_durations[7] = 10.0
				_durations[8] = 10.0
				_durations[9] = 10.0
				_durations[10] = 10.0
			endIf
			return _durations
		endIf
	elseIf (Sequence == 14) ; Nibbles Screw Animation
		if (bKissingUsed)
			_durations = new float[10]
			_durations[0] = 3.45
			_durations[1] = 9.33
			_durations[2] = 1.4
			_durations[3] = (10.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[5] = (20.0 * fMod)
			_durations[6] = (20.0 * fMod)
			_durations[7] = (20.0 * fMod)
			_durations[8] = (5.93 * fMod)
			_durations[9] = 5.93
		else
			_durations = new float[7]
			_durations[0] = (10.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[2] = (20.0 * fMod)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[5] = (11.867 * fMod)
			_durations[6] = 5.93
		endIf
		return _durations
	elseIf (Sequence == 15)	; MilkyMiss1
		if (bKissingUsed)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[7] = 17.45
			_durations[8] = 5.818
		else
			_durations[0] = (20.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[4] = 17.45
			_durations[5] = 5.818
		endIf
	elseIf (Sequence == 16)	; MilkyLaying1
		if (bKissingUsed)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[7] = 15.272
			_durations[8] = 1.697
		else
			_durations[0] = (20.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[4] = 15.272
			_durations[5] = 1.697
		endIf
	elseIf (Sequence == 17)	; MilkyMissionary1 - NEED ACTUAL
		if (bKissingUsed)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[7] = 15.0
			_durations[8] = 3.0
		else
			_durations[0] = (20.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[4] = 15.0
			_durations[5] = 3.0
		endIf
	elseIf (Sequence == 18)	; MilkyLotus1 - NEED ACTUAL
		if (bKissingUsed)
			_durations[3] = (20.0 * fMod)
			_durations[4] = (20.0 * fMod)
			_durations[7] = 15.0
			_durations[8] = 3.0
		else
			_durations[0] = (20.0 * fMod)
			_durations[1] = (20.0 * fMod)
			_durations[4] = 15.0
			_durations[5] = 3.0
		endIf
	else
		return _durations
	endIf
	
	if (who.SexType == SexPositions.TokenStandingFemale || who.SexType == SexPositions.TokenStandingMale)
		if (Sequence == 3)			; BillyStand1
			if (bKissingUsed)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[7] = 7.33
				_durations[8] = 7.33
			else
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[4] = 7.33
				_durations[5] = 7.33
			endIf
		elseIf (Sequence == 4)	; BillyStand2
			if (bKissingUsed)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[7] = 8.4
				_durations[8] = 8.4
			else
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[4] = 8.4
				_durations[5] = 8.4
			endIf
		elseIf (Sequence == 5)	; MilkyStanding1
			if (bKissingUsed)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[7] = 17.456
				_durations[8] = 3.49
			else
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[4] = 17.456
				_durations[5] = 3.49
			endIf
		elseIf (Sequence == 6)	; MilkyStanding2
			if (bKissingUsed)
				_durations[3] = (20.0 * fMod)
				_durations[4] = (20.0 * fMod)
				_durations[7] = 17.456
				_durations[8] = 3.49
			else
				_durations[0] = (20.0 * fMod)
				_durations[1] = (20.0 * fMod)
				_durations[4] = 17.456
				_durations[5] = 3.49
			endIf
		endIf
	endIf

	return _durations
endFunction

string[] Property KissingFemaleIdles Auto
string[] Property KissingMaleIdles Auto

string[] Property KissingMaleFemaleIdles Auto
string[] Property KissingMaleMaleIdles Auto

string[] Property OralOneFemaleIdles Auto
string[] Property OralOneMaleIdles Auto

string[] Property OralTwoFemaleIdles Auto
string[] Property OralTwoMaleIdles Auto

string[] Property OralThreeFemaleIdles Auto
string[] Property OralThreeMaleIdles Auto 

string[] Property SixtyNineFemaleIdles Auto
string[] Property SixtyNineMaleIdles Auto

string[] Property CunniOneMaleIdles Auto
string[] Property CunniOneFemaleIdles Auto

string[] Property CunniTwoMaleIdles Auto
string[] Property CunniTwoFemaleIdles Auto

string[] Property TittyFuckFemaleIdles Auto
string[] Property TittyFuckMaleIdles Auto

string[] Property DildoOneFemaleIdles Auto
string[] Property DildoOneMaleIdles Auto

string[] Property DildoTwoFemaleIdles Auto
string[] Property DildoTwoMaleIdles Auto

string[] Property CowgirlOneFemaleIdles Auto
string[] Property CowgirlOneMaleIdles Auto

string[] Property CowgirlTwoFemaleIdles Auto
string[] Property CowgirlTwoMaleIdles Auto

string[] Property CowgirlThreeFemaleIdles Auto
string[] Property CowgirlThreeMaleIdles Auto

string[] Property CowgirlFourFemaleIdles Auto
string[] Property CowgirlFourMaleIdles Auto

string[] Property CowgirlFiveFemaleIdles Auto
string[] Property CowgirlFiveMaleIdles Auto

string[] Property ReverseCowFemaleIdles Auto
string[] Property ReverseCowMaleIdles Auto

string[] Property CowgirlFeetFemaleIdles Auto
string[] Property CowgirlFeetMaleIdles Auto

string[] Property StandingOneFemaleIdles Auto
string[] Property StandingOneMaleIdles Auto

string[] Property StandingTwoFemaleIdles Auto
string[] Property StandingTwoMaleIdles Auto

string[] Property DoggyOneFemaleIdles Auto
string[] Property DoggyOneMaleIdles Auto

string[] Property DoggyTwoFemaleIdles Auto
string[] Property DoggyTwoMaleIdles Auto

string[] Property DoggyThreeFemaleIdles Auto
string[] Property DoggyThreeMaleIdles Auto

string[] Property SpoonFemaleIdles Auto
string[] Property SpoonMaleIdles Auto

string[] Property MissOneFemaleIdles Auto
string[] Property MissOneMaleIdles Auto
 
string[] Property MissTwoFemaleIdles Auto
string[] Property MissTwoMaleIdles Auto
 
string[] Property MissThreeFemaleIdles Auto
string[] Property MissThreeMaleIdles Auto

string[] Property MissFourFemaleIdles Auto
string[] Property MissFourMaleIdles Auto

string[] Property LotusFemaleIdles Auto
string[] Property LotusMaleIdles Auto

string[] Property ReverseLotusFemaleIdles Auto
string[] Property ReverseLotusMaleIdles Auto

string[] Property MissFeetOneFemaleIdles Auto
string[] Property MissFeetOneMaleIdles Auto

string[] Property MissFeetTwoFemaleIdles Auto
string[] Property MissFeetTwoMaleIdles Auto

string[] Property LesbianOneFemaleIdles Auto
string[] Property LesbianOneMaleIdles Auto

string[] Property LesbianTwoFemaleIdles Auto
string[] Property LesbianTwoMaleIdles Auto

string[] Property Lesbian69FemaleIdles Auto
string[] Property Lesbian69MaleIdles Auto

string[] Property LesbianTribbingFemaleIdles Auto
string[] Property LesbianTribbingMaleIdles Auto

string[] Property AnalDoggyOneFemaleIdles Auto
string[] Property AnalDoggyOneMaleIdles Auto

string[] Property AnalDoggyTwoFemaleIdles Auto
string[] Property AnalDoggyTwoMaleIdles Auto

string[] Property AnalRevCowFemaleIdles Auto
string[] Property AnalRevCowMaleIdles Auto

string[] Property AnalMissOneFemaleIdles Auto
string[] Property AnalMissOneMaleIdles Auto

string[] Property AnalMissTwoFemaleIdles Auto
string[] Property AnalMissTwoMaleIdles Auto

string[] Property AnalPowerbombFemaleIdles Auto
string[] Property AnalPowerbombMaleIdles Auto

string[] Property SoloFemaleIdles Auto
string[] Property SoloFemaleTwoIdles Auto
string[] Property SoloFemaleDildoVagIdles Auto
string[] Property SoloFemaleDildoAnalIdles Auto
string[] Property SoloFemaleToyVagIdles Auto
string[] Property SoloFemaleToyAnalIdles Auto
string[] Property SoloFemaleBumIdles Auto
string[] Property SoloFemaleKneesIdles Auto
string[] Property SoloFemaleKneesTwoIdles Auto
string[] Property SoloFemaleSquatIdles Auto
string[] Property SoloFemaleFitnessIdles Auto

string[] Property SoloMaleKneeling Auto
string[] Property SoloMaleStandingOne Auto
string[] Property SoloMaleStandingTwo Auto
string[] Property SoloMaleStandingThree Auto
string[] Property SoloMaleLayingOne Auto
string[] Property SoloMaleLayingTwo Auto
string[] Property SoloMaleLayingThree Auto

string[] Property FfmOneActor1Idles Auto
string[] Property FfmOneActor2Idles Auto
string[] Property FfmOneActor3Idles Auto

string[] Property FfmTwoActor1Idles Auto
string[] Property FfmTwoActor2Idles Auto
string[] Property FfmTwoActor3Idles Auto

string[] Property FfmThreeActor1Idles Auto
string[] Property FfmThreeActor2Idles Auto
string[] Property FfmThreeActor3Idles Auto

string[] Property FfmFourActor1Idles Auto
string[] Property FfmFourActor2Idles Auto
string[] Property FfmFourActor3Idles Auto

string[] Property MmfOneActor1Idles Auto
string[] Property MmfOneActor2Idles Auto
string[] Property MmfOneActor3Idles Auto

string[] Property MmfTwoActor1Idles Auto
string[] Property MmfTwoActor2Idles Auto
string[] Property MmfTwoActor3Idles Auto

string[] Property MmfThreeActor1Idles Auto
string[] Property MmfThreeActor2Idles Auto
string[] Property MmfThreeActor3Idles Auto

string[] Property MmfFourActor1Idles Auto
string[] Property MmfFourActor2Idles Auto
string[] Property MmfFourActor3Idles Auto

string[] Property FffOneActor1Idles Auto
string[] Property FffOneActor2Idles Auto
string[] Property FffOneActor3Idles Auto

string[] Property Bed69FemaleIdles Auto
string[] Property Bed69MaleIdles Auto

string[] Property BedAnalDoggyFemaleIdles Auto
string[] Property BedAnalDoggyMaleIdles Auto

string[] Property BedAnalRevCowFemaleIdles Auto
string[] Property BedAnalRevCowMaleIdles Auto

string[] Property BedCowgirlFemaleIdles Auto
string[] Property BedCowgirlMaleIdles Auto

string[] Property BedDoggyFemaleIdles Auto
string[] Property BedDoggyMaleIdles Auto

string[] Property BedMissionaryFemaleIdles Auto
string[] Property BedMissionaryMaleIdles Auto

string[] Property BedMissFeetFemaleIdles Auto
string[] Property BedMissFeetMaleIdles Auto

string[] Property ChairDoggyFemaleIdles Auto
string[] Property ChairDoggyMaleIdles Auto

string[] Property ChairSoloFemaleIdles Auto
string[] Property ChairSoloTwoFemaleIdles Auto

string[] Property ThroneAnalDoggyFemaleIdles Auto
string[] Property ThroneAnalDoggyMaleIdles Auto

string[] Property ThroneAnalCowFemaleIdles Auto
string[] Property ThroneAnalCowMaleIdles Auto

string[] Property ThroneOralFemaleIdles Auto
string[] Property ThroneOralMaleIdles Auto

string[] Property ThroneCowgirlFemaleIdles Auto
string[] Property ThroneCowgirlMaleIdles Auto

string[] Property ThroneCunniFemaleIdles Auto
string[] Property ThroneCunniMaleIdles Auto

string[] Property ThroneDoggyFemaleIdles Auto
string[] Property ThroneDoggyMaleIdles Auto

string[] Property ThroneMissionaryFemaleIdles Auto
string[] Property ThroneMissionaryMaleIdles Auto

string[] Property WorkbenchFemaleIdles Auto
string[] Property WorkbenchMaleIdles Auto

string[] Property TableOneFemaleIdles Auto
string[] Property TableOneMaleIdles Auto

string[] Property SapStand1FemaleIdles Auto
string[] Property SapStand1MaleIdles Auto
string[] Property SapStand2FemaleIdles Auto
string[] Property SapStand2MaleIdles Auto
string[] Property SapStand3FemaleIdles Auto
string[] Property SapStand3MaleIdles Auto

string[] Property SapLaying1FemaleIdles Auto
string[] Property SapLaying1MaleIdles Auto

string[] Property SapBed1FemaleIdles Auto
string[] Property SapBed1MaleIdles Auto

string[] Property SidewaysFemaleIdles Auto
string[] Property SidewaysMaleIdles Auto

string[] Property BillyStand1FemaleIdles Auto
string[] Property BillyStand1MaleIdles Auto

string[] Property BillyStand2FemaleIdles Auto
string[] Property BillyStand2MaleIdles Auto

string[] Property BillyOralLayingFemaleIdles Auto
string[] Property BillyOralLayingMaleIdles Auto

string[] Property BillyAnalFemaleIdles Auto
string[] Property BillyAnalMaleIdles Auto

string[] Property BillyMissionaryFemaleIdles Auto
string[] Property BillyMissionaryMaleIdles Auto

string[] Property BillyMissionary2FemaleIdles Auto
string[] Property BillyMissionary2MaleIdles Auto

string[] Property BillyLesbian1FemaleIdles Auto
string[] Property BillyLesbian1MaleIdles Auto

string[] Property BillyMaleMasturbation1Idles Auto

string[] Property BillyLesbianFinger2FemaleIdles Auto
string[] Property BillyLesbianFinger2MaleIdles Auto

string[] Property BillyLesbianCunni1FemaleIdles Auto
string[] Property BillyLesbianCunni1MaleIdles Auto

string[] Property BillyLesbianCunni2FemaleIdles Auto
string[] Property BillyLesbianCunni2MaleIdles Auto

string[] Property BillyLesbianTribbing1FemaleIdles Auto
string[] Property BillyLesbianTribbing1MaleIdles Auto

string[] Property BillyLesbianMagicDildo1FemaleIdles Auto
string[] Property BillyLesbianMagicDildo1MaleIdles Auto

string[] Property MMFBillyKneelingActor1Idles Auto
string[] Property MMFBillyKneelingActor2Idles Auto
string[] Property MMFBillyKneelingActor3Idles Auto

string[] Property MMFBillyCowgirlActor1Idles Auto
string[] Property MMFBillyCowgirlActor2Idles Auto
string[] Property MMFBillyCowgirlActor3Idles Auto

string[] Property MMFBillyStandingActor1Idles Auto
string[] Property MMFBillyStandingActor2Idles Auto
string[] Property MMFBillyStandingActor3Idles Auto

string[] Property MMFBillyAnalActor1Idles Auto
string[] Property MMFBillyAnalActor2Idles Auto
string[] Property MMFBillyAnalActor3Idles Auto

string[] Property MMFBillySpitActor1Idles Auto
string[] Property MMFBillySpitActor2Idles Auto
string[] Property MMFBillySpitActor3Idles Auto

string[] Property MMFBillyDoubleBJActor1Idles Auto
string[] Property MMFBillyDoubleBJActor2Idles Auto
string[] Property MMFBillyDoubleBJActor3Idles Auto

string[] Property MMFBillyDP1Actor1Idles Auto
string[] Property MMFBillyDP1Actor2Idles Auto
string[] Property MMFBillyDP1Actor3Idles Auto

string[] Property AlchemyTableFemaleIdles Auto
string[] Property AlchemyTableMaleIdles Auto

string[] Property EnchantingTableFemaleIdles Auto
string[] Property EnchantingTableMaleIdles Auto

string[] Property Nibbles69FemaleIdles Auto
string[] Property Nibbles69MaleIdles Auto

string[] Property NibblesScrewFemaleIdles Auto
string[] Property NibblesScrewMaleIdles Auto

string[] Property NibblesReverseCowgirl2FemaleIdles Auto
string[] Property NibblesReverseCowgirl2MaleIdles Auto

string[] Property NibblesLesbianCuddling1FemaleIdles Auto
string[] Property NibblesLesbianCuddling1MaleIdles Auto

string[] Property MilkyCowgirl1FemaleIdles Auto
string[] Property MilkyCowgirl1MaleIdles Auto

string[] Property MilkyCowgirl2FemaleIdles Auto
string[] Property MilkyCowgirl2MaleIdles Auto

string[] Property MilkyCowgirlMissFemaleIdles Auto
string[] Property MilkyCowgirlMissMaleIdles Auto

string[] Property MilkyDoggy1FemaleIdles Auto
string[] Property MilkyDoggy1MaleIdles Auto

string[] Property MilkyDoggy2FemaleIdles Auto
string[] Property MilkyDoggy2MaleIdles Auto

string[] Property MilkyMiss1FemaleIdles Auto
string[] Property MilkyMiss1MaleIdles Auto

string[] Property MilkyStanding1FemaleIdles Auto
string[] Property MilkyStanding1MaleIdles Auto

string[] Property MilkyRevCow1FemaleIdles Auto
string[] Property MilkyRevCow1MaleIdles Auto

string[] Property MilkyCunni1FemaleIdles Auto
string[] Property MilkyCunni1MaleIdles Auto

string[] Property MilkyLaying1FemaleIdles Auto
string[] Property MilkyLaying1MaleIdles Auto

string[] Property MilkyLesbian1FemaleIdles Auto
string[] Property MilkyLesbian1MaleIdles Auto

string[] Property MilkyStanding2FemaleIdles Auto
string[] Property MilkyStanding2MaleIdles Auto

string[] Property MilkyLotus1FemaleIdles Auto
string[] Property MilkyLotus1MaleIdles Auto

string[] Property MilkyMissionary1FemaleIdles Auto
string[] Property MilkyMissionary1MaleIdles Auto

string[] Property MilkyAlchemy1FemaleIdles Auto
string[] Property MilkyAlchemy1MaleIdles Auto
