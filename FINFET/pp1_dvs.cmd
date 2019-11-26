;------------------ (1) parameter -----------------------;
(define nm 1e-3)
(define Fw 5)
(define Fh 5)
(define Lg 15)
(define LSDC 15)
(define LSD 15)
(define Tox 0.5)
(define x1 LSDC)
(define x2 (+ x1 LSD))
(define x3 (+ x2 Lg))
(define x4 (+ x3 LSD))
(define x5 (+ x4 LSDC))
(define y1 Fw)
(define y2 (+ y1 Tox))
(define y3 (+ y2 10))
(define z1 Fh)
(define z2 (+ z1 Tox))
(define C_Doping 1e17)
;(define C_Doping 1e11)
(define SD_Doping 8e19)
(define SDC_Doping 8e19)
;(define B_Doping 1e15)
(define B_Doping 5e18)
110 3 3D FinFET with L
g = 15 nm and Lg = 10 nm Simulation
; ----------------------- (2) Structure ----------------------;
"ABA"
;--- Source contact and Source ---;
(sdegeo:create-cuboid (position 0 0 0 ) (position x1 y1 z1 ) "Silicon" "SourceC")
(sdegeo:create-cuboid (position x1 0 0 ) (position x2 y1 z1) "Silicon" "Source")
;--- Gate oxide ---;
(sdegeo:create-cuboid (position x2 (- Tox) 0 ) (position x3 y2 z2 ) "SiO2" "Gateoxide")
;--- Channel ---;
(sdegeo:create-cuboid (position x2 0 0 ) (position x3 y1 z1 ) "Silicon" "Channel")
;--- Drain contact and Drain---;
(sdegeo:create-cuboid (position x3 0 0 ) (position x4 y1 z1 ) "Silicon" "Drain")
(sdegeo:create-cuboid (position x4 0 0 ) (position x5 y1 z1 ) "Silicon" "DrainC")
;--- Buried oxide ---;
(sdegeo:create-cuboid (position 0 (- 10) (- 20) ) (position x5 y3 0 ) "SiO2" "Box")
"ABA"
;--- Si Body ---;
(sdegeo:create-cuboid (position 0 0 (- 20) ) (position x5 y1 0 ) "Silicon" "Body")
; --------------------- (3) Contact ------------------;
;----- Source -----;
(sdegeo:define-contact-set "S" 4.0 (color:rgb 1.0 0.0 0.0 ) "##" )
(sdegeo:set-current-contact-set "S")
(sdegeo:set-contact-faces (find-face-id (position 1 1 z1)))
;----- Drain -----;
(sdegeo:define-contact-set "D" 4.0 (color:rgb 1.0 0.0 0.0 ) "##" )
(sdegeo:set-current-contact-set "D")
(sdegeo:set-contact-faces (find-face-id (position (+ x4 1) 1 z1 )))
;----- Front Gate -----;
(sdegeo:define-contact-set "G" 4.0 (color:rgb 1.0 0.0 0.0 ) "||" )
(sdegeo:set-current-contact-set "G")
(sdegeo:set-contact-faces (find-face-id (position (+ x2 1) (- Tox) 1 )))
;----- Top Gate -----;
(sdegeo:define-contact-set "G" 4.0 (color:rgb 1.0 0.0 0.0 ) "||" )
(sdegeo:set-current-contact-set "G")
(sdegeo:set-contact-faces (find-face-id (position (+ x2 1) 1 z2 )))
;----- Back Gate -----;
(sdegeo:define-contact-set "G" 4.0 (color:rgb 1.0 0.0 0.0 ) "||" )
(sdegeo:set-current-contact-set "G")
(sdegeo:set-contact-faces (find-face-id (position (+ x2 1) y2 1 )))
;----- Body -----;
(sdegeo:define-contact-set "B" 4.0 (color:rgb 1.0 0.0 0.0 ) "##" )
(sdegeo:set-current-contact-set "B")
(sdegeo:set-contact-faces (find-face-id (position (* 0.5 x5) (* 0.5 y1) (- 20) )))
; ------------------------ (4) Doping -------------------------;
;----- Channel -----;
(sdedr:define-constant-profile "dopedC" "BoronActiveConcentration" C_Doping )
(sdedr:define-constant-profile-region "RegionC" "dopedC" "Channel" )
;----- Source -----;
(sdedr:define-constant-profile "dopedS" "ArsenicActiveConcentration" SD_Doping )
(sdedr:define-constant-profile-region "RegionS" "dopedS" "Source" )
(sdedr:define-constant-profile "dopedSC" "ArsenicActiveConcentration" SDC_Doping )
(sdedr:define-constant-profile-region "RegionSC" "dopedSC" "SourceC" )
;----- Drain ------;
(sdedr:define-constant-profile "dopedD" "ArsenicActiveConcentration" SD_Doping )
(sdedr:define-constant-profile-region "RegionD" "dopedD" "Drain" )
(sdedr:define-constant-profile "dopedDC" "ArsenicActiveConcentration" SDC_Doping )
(sdedr:define-constant-profile-region "RegionDC" "dopedDC" "DrainC" )
;----- Si Body -----;
(sdedr:define-constant-profile "dopedB" "BoronActiveConcentration" B_Doping )
(sdedr:define-constant-profile-region "RegionB" "dopedB" "Body" )
; --------------------- (5) Mesh -----------------------;
;--- AllMesh ---;
(sdedr:define-refinement-size "Cha_Mesh" 5 5 5 1 1 1)
(sdedr:define-refinement-material "channel_RF" "Cha_Mesh" "Silicon" )
;--- ChannelMesh ---;
(sdedr:define-refinement-window "multiboxChannel" "Cuboid"
(position x1 0 0) (position x4 y1 z1))
(sdedr:define-multibox-size "multiboxSizeChannel" 2 2 2 2 2 2)
(sdedr:define-multibox-placement "multiboxPlacementChannel" "multiboxSizeChannel"
"multiboxChannel")
(sdedr:define-refinement-function "multiboxPlacementChannel" "DopingConcentration"
"MaxTransDiff" 1)
; ----------- (6) Save (BND and CMD and rescale to nm) -----------;
(sde:assign-material-and-region-names (get-body-list) )
(sdeio:save-tdr-bnd (get-body-list) "n1_nm.tdr")
(sdedr:write-scaled-cmd-file "n1_msh.cmd" nm)
(define sde:scale-tdr-bnd
(lambda (tdrin sf tdrout)
(sde:clear)
(sdegeo:set-default-boolean "XX")
(sdeio:read-tdr-bnd tdrin)
(entity:scale (get-body-list) sf)
(sdeio:save-tdr-bnd (get-body-list) tdrout)
))
(sde:scale-tdr-bnd "n1_nm.tdr" nm "n1_bnd.tdr")
; ------------------------------------------ END --------------------------------------------;

