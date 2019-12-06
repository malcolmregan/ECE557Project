; parameter ;
(define Lg @Lg@)
(define tox @tox@)
(define tac @tac@)
(define Body @Body@)
(define LSDC 24)
(define LSD 25)
(define C_Doping @C_Doping@)
(define D_Doping @DS_Doping@)
(define S_Doping @DS_Doping@)
(define B_Doping @B_Doping@)
(define nm 1e-3)

(define x1 LSDC)
(define x2 (+ x1 LSD))
(define x3 (+ x2 Lg))
(define x4 (+ x3 LSD))
(define x5 (+ x4 LSDC))

(define y1 (- Body))
(define y2 tac)
(define y3 (+ tac tox))

; structure ;
"ABA"
;source
(sdegeo:create-rectangle
   (position   0 0 0)
   (position   x1 y2 0) "Silicon" "SourceC")
(sdegeo:create-rectangle
   (position   x1 0 0)
   (position   x2 y2 0) "Silicon" "Source")
;channel
(sdegeo:create-rectangle
   (position   x2 0 0)
   (position   x3 y2 0) "Silicon" "Channel")
;drain
(sdegeo:create-rectangle
   (position x3 0 0)
   (position x4 y2 0) "Silicon" "Drain")
(sdegeo:create-rectangle
   (position x4 0 0)
   (position x5 y2 0) "Silicon" "DrainC")
;body
(sdegeo:create-rectangle
   (position 0 0 0)
   (position x5 y1 0) "Silicon" "Body")
;gate oxidee
(sdegeo:create-rectangle
   (position x2 y2 0)
   (position x3 y3 0) "HfO2" "Gateoxide")
   
; contact ;
;gate
(sdegeo:define-contact-set "G" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-2d-contact (find-edge-id (position (+ x2 (/ Lg 2)) y3 0)) "G")
;source
(sdegeo:define-contact-set "S" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-2d-contact (find-edge-id (position 10 tac 0)) "S")
;drain
(sdegeo:define-contact-set "D" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-2d-contact (find-edge-id (position (+ 50 Lg 35) tac 0)) "D")
;substrate
(sdegeo:define-contact-set "substrate" 4.0 (color:rgb 1.0 0.0 0.0) "##")
(sdegeo:define-2d-contact (find-edge-id (position (+ x2 (/ Lg 2)) (- Body) 0)) "substrate")

; doping ;
;--- Channel ---
(sdedr:define-constant-profile "dopedC" "BoronActiveConcentration" C_Doping )
(sdedr:define-constant-profile-region "RegionC" "dopedC" "Channel" )
;--- Source ---
(sdedr:define-constant-profile "dopedS" "PhosphorusActiveConcentration" S_Doping )
(sdedr:define-constant-profile-region "RegionS" "dopedS" "Source" )
(sdedr:define-constant-profile "dopedSC" "PhosphorusActiveConcentration" S_Doping )
(sdedr:define-constant-profile-region "RegionSC" "dopedSC" "SourceC" )
;--- Drain ---
(sdedr:define-constant-profile"dopedD" "PhosphorusActiveConcentration" D_Doping )
(sdedr:define-constant-profile-region "RegionD" "dopedD" "Drain" )
(sdedr:define-constant-profile "dopedDC" "PhosphorusActiveConcentration" D_Doping )
(sdedr:define-constant-profile-region "RegionDC" "dopedDC" "DrainC" )
;--- Body ---
(sdedr:define-constant-profile "dopedB" "BoronActiveConcentration" B_Doping )
(sdedr:define-constant-profile-region "RegionB" "dopedB" "Body" )

;----- (5). Mesh -----;
;--- AllMesh ---
(sdedr:define-refinement-size "Cha_Mesh" 20 20 0 10 10 0)
(sdedr:define-refinement-material "channel_RF" "Cha_Mesh" "Silicon" )
;--- ChannelMesh ---
(sdedr:define-refinement-window "multiboxChannel" "Rectangle"
(position 25 (- 50) 0)
(position (+ 50 Lg 25) (+ tac 50) 0))
(sdedr:define-multibox-size "multiboxSizeChannel" 5 5 0 1 1 0)
(sdedr:define-multibox-placement "multiboxPlacementChannel" "multiboxSizeChannel" "multiboxChannel")
(sdedr:define-refinement-function "multiboxPlacementChannel" "DopingConcentration" "MaxTransDiff" 1)
;----- (6). Save (BND and CMD and rescale to nm) -----;
(sde:assign-material-and-region-names (get-body-list) )
(sdeio:save-tdr-bnd (get-body-list) "n@node@_nm.tdr")
(sdedr:write-scaled-cmd-file "n@node@_msh.cmd" nm)

(define sde:scale-tdr-bnd
(lambda (tdrin sf tdrout)
(sde:clear)
(sdegeo:set-default-boolean "XX")
(sdeio:read-tdr-bnd tdrin)
(entity:scale (get-body-list) sf)
(sdeio:save-tdr-bnd (get-body-list) tdrout)))
(sde:scale-tdr-bnd "n@node@_nm.tdr" nm "n@node@_bnd.tdr")
;-------------------------------------------- END ---------------------------------------;
