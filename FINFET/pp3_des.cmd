File{
Grid="n8_msh.tdr"
Plot="n3_des.tdr"
Current="n3_des.plt"
Output="n3_des.log"
}

Electrode {
{ name="S" Voltage=0.0 }
{ name="D" Voltage=0.0 }
{ name="G" Voltage=-0.5 WorkFunction=4.43}
{ name="B" Voltage=0.0 }
}

Physics{
Mobility( DopingDep HighFieldSaturation Enormal )
EffectiveIntrinsicDensity( OldSlotboom )
Recombination( SRH(DopingDep) )
}

Math{
Extrapolate
Derivatives
* Avalderivatives
RelErrControl
Digits=5
ErRef(electron)=1.e10
ErRef(hole)=1.e10
Notdamped=50
Iterations=20
*Newdiscretization
Directcurrent
Method=ParDiSo
Parallel= 2
*-VoronoiFaceBoxMethod
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
}

Solve{
NewCurrentFile=""
Coupled(Iterations=100){ Poisson }
Coupled(Iterations=100){ Poisson Electron Hole }
Coupled{ Poisson Electron Hole }
Quasistationary(
InitialStep=0.01 Increment=1.35
MinStep=1e-5 MaxStep=0.2
Goal{ Name="D" Voltage= 1 }
){ Coupled{ Poisson Electron Hole } }
Quasistationary(
InitialStep=1e-3 Increment=1.35
MinStep=1e-5 MaxStep=0.05
Goal{ Name="G" Voltage= 1.5 }
){ Coupled{ Poisson Electron Hole} }
}


