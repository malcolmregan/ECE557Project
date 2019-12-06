Electrode{
 {name="D" voltage=0.0}
 {name="S" voltage=0.0}
 {name="G" voltage=-0.5 WorkFunction=4.8}
 }
 File{
 Grid="n3661_msh.tdr" 
 Plot="n3666_des.tdr"
 Current="n3666_des.plt"
 Output="n3666_des.log"
 parameter="pp3666_des.par"
 }
 Physics{
 Mobility( DopingDep HighFieldSaturation Enormal )
 EffectiveIntrinsicDensity( OldSlotboom )
 Recombination( SRH(DopingDep) )
 eQuantumPotential
 }
 Math{
 -CheckUndefinedModels
 Number_Of_Threads=4
 Extrapolate
 Derivatives
 * Avalderivatives
 RelErrControl
 Digits=5
 ErRef(electron)=1.e10
 ErRef(hole)=1.e10
 Notdamped=50
 Iterations=20
 Directcurrent
 Method=ParDiSo
 Parallel= 2
 NaturalBoxMethod
}

Plot{
eDensity hDensity
 eCurrent hCurrent
 TotalCurrent/Vector eCurrent/Vector hCurrent/Vector
 eMobility hMobility
 eVelocity hVelocity
 eEnormal hEnormal
 ElectricField/Vector Potential SpaceCharge
 eQuasiFermi hQuasiFermi
 Potential Doping SpaceCharge
 SRH Auger
 AvalancheGeneration
 DonorConcentration AcceptorConcentration
 Doping
 eGradQuasiFermi/Vector hGradQuasiFermi/Vector
 eEparallel hEparalllel
 BandGap
 BandGapNarrowing
 Affinity
 ConductionBand ValenceBand
 eQuantumPotential
}

Solve {
 Coupled ( Iterations= 40){ Poisson eQuantumPotential }
 Coupled { Poisson eQuantumPotential Electron Hole }
 Quasistationary(
 	InitialStep= 1e-3 Increment= 1.2
 	MinStep= 1e-12 MaxStep= 0.95
 	Goal { Name= "D" Voltage=1 }){ Coupled { Poisson eQuantumPotential Electron Hole } }
 Quasistationary(
 	InitialStep= 1e-3 Increment= 1.2
 	MinStep= 1e-12 MaxStep= 0.02
 	Goal { Name= "G" Voltage=1.5 }
 	DoZero
 ){ Coupled { Poisson eQuantumPotential Electron Hole } }
}

