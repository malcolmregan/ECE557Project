Title ""

Controls {
}

Definitions {
	Constant "dopedC" {
		Species = "BoronActiveConcentration"
		Value = 1e+17
	}
	Constant "dopedS" {
		Species = "ArsenicActiveConcentration"
		Value = 8e+19
	}
	Constant "dopedSC" {
		Species = "ArsenicActiveConcentration"
		Value = 8e+19
	}
	Constant "dopedD" {
		Species = "ArsenicActiveConcentration"
		Value = 8e+19
	}
	Constant "dopedDC" {
		Species = "ArsenicActiveConcentration"
		Value = 8e+19
	}
	Constant "dopedB" {
		Species = "BoronActiveConcentration"
		Value = 5e+18
	}
	Refinement "Cha_Mesh" {
		MaxElementSize = ( 0.005 0.005 0.005 )
		MinElementSize = ( 0.001 0.001 0.001 )
	}
	Multibox "multiboxSizeChannel"
 {
		MaxElementSize = ( 0.002 0.002 )
		MinElementSize = ( 0.002 0.002 )
		Ratio = ( 2 2 )
	}
}

Placements {
	Constant "RegionC" {
		Reference = "dopedC"
		EvaluateWindow {
			Element = region ["Channel"]
		}
	}
	Constant "RegionS" {
		Reference = "dopedS"
		EvaluateWindow {
			Element = region ["Source"]
		}
	}
	Constant "RegionSC" {
		Reference = "dopedSC"
		EvaluateWindow {
			Element = region ["SourceC"]
		}
	}
	Constant "RegionD" {
		Reference = "dopedD"
		EvaluateWindow {
			Element = region ["Drain"]
		}
	}
	Constant "RegionDC" {
		Reference = "dopedDC"
		EvaluateWindow {
			Element = region ["DrainC"]
		}
	}
	Constant "RegionB" {
		Reference = "dopedB"
		EvaluateWindow {
			Element = region ["Body"]
		}
	}
	Refinement "channel_RF" {
		Reference = "Cha_Mesh"
		RefineWindow = material ["Silicon"]
	}
	Multibox "multiboxPlacementChannel" {
		Reference = "multiboxSizeChannel"
		RefineWindow = Cuboid [(0.015 0 0) (0.06 0.005 0.005)]
	}
}

