Title ""

Controls {
}

Definitions {
	Constant "dopedC" {
		Species = "BoronActiveConcentration"
		Value = 1e+19
	}
	Constant "dopedS" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+21
	}
	Constant "dopedSC" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+21
	}
	Constant "dopedD" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+21
	}
	Constant "dopedDC" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+21
	}
	Constant "dopedB" {
		Species = "BoronActiveConcentration"
		Value = 5e+18
	}
	Refinement "Cha_Mesh" {
		MaxElementSize = ( 0.02 0.02 0 )
		MinElementSize = ( 0.01 0.01 0 )
	}
	Multibox "multiboxSizeChannel"
 {
		MaxElementSize = ( 0.005 0.005 )
		MinElementSize = ( 0 0.001 )
		Ratio = ( 1 0 )
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
		RefineWindow = Rectangle [(0.025 -0.05) (0.101 0.055)]
	}
}

