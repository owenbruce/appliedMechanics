{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'Dual Resonance'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  uA(threshold=1e-4)
  vA(threshold=1e-4)
  uB(threshold=1e-4)
  vB(threshold=1e-4){ choose your own names }
SELECT         { method controls }
ngrid=1
DEFINITIONS    { parameter definitions }
mA=5
kA=10
bA=2
mB=10
kB=20
bB=2
omega=sqrt(2)
uW=0.01*sin(omega*t)
vW=dt(uW)
FNetA=-kA*(uA-uB)-bA*(vA-vB)
FNetB=-kB*(uB-uW)-bB*(vB-vW)+kA*(uA-uB)+bA*(vA-vB) !Equation for block B in 1(b)
!FNetB=-kB*(uB-uW)-bB*(vB-vW)  !Equation for block B in 1(d)
aA=FNetA/mA
aB=FNetB/mB
! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  uA: dt(uA)=vA
  vA: dt(vA)=aA
  uB: dt(uB)=vB
  vB: dt(vB)=aB
! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 1       { For each material region }
    START(0,0)   { Walk the domain boundary }
    LINE TO (1,0) TO (1,1) TO (0,1) TO CLOSE
TIME 0 TO 60    { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
  for time=0 by 1 to endtime
  	history(uA) at (0,0)
    history(uB) at (0,0)
END
