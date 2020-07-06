{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'Assignment 2 Part 3d'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  !ut1(threshold=1e-8)
  !vt1(threshold=1e-8) 
  !ut2(threshold=1e-8)
  !vt2(threshold=1e-8) 
  ut3(threshold=1e-8)
  vt3(threshold=1e-8) 
  !uc1(threshold=1e-8)
  !vc1(threshold=1e-8) 
  !uc2(threshold=1e-8)
  !vc2(threshold=1e-8) 
  uc3(threshold=1e-8)
  vc3(threshold=1e-8) 
SELECT         { method controls }
ngrid=1
penwidth=5
DEFINITIONS    { parameter definitions }
g = 9.81
Q =15
mt = 25
kc=654*3
b_c=1.7*3
mc=6
!at1=dt(vt1)
!ac1=dt(vc1)
!at2=dt(vt2)
!ac2=dt(vc2)
at3=dt(vt3)
ac3=dt(vc3)
a_resonance=0.001
omega = sqrt(kc/mc)
omegat1 = 0.4*omega
omegat2 = omega
omegat3 = 3*omega
!kt1 = omegat1^2*mt
!kt2 = omegat2^2*mt
kt3 = omegat3^2*mt
!bt1 = sqrt(mt*kt1)/Q
!bt2 = sqrt(mt*kt2)/Q
bt3 = sqrt(mt*kt3)/Q
ug = 0.001*sin(omega*t)
vg = dt(ug)
! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  !ut1: dt(ut1)=vt1
  !vt1: mt*at1+bt1*(vt1-vg)+kt1*(ut1-ug)=kc*(uc1-ut1)+b_c*(vc1-vc1)
  !uc1: dt(uc1)=vc1
  !vc1: mc*ac1+b_c*(vc1-vt1)+kc*(uc1-ut1)=0
  !ut2: dt(ut2)=vt2
  !vt2: mt*at2+bt2*(vt2-vg)+kt2*(ut2-ug)=kc*(uc2-ut2)+b_c*(vc2-vt2)
  !uc2: dt(uc2)=vc2
  !vc2: mc*ac2+b_c*(vc2-vt2)+kc*(uc2-ut2)=0
  ut3: dt(ut3)=vt3
  vt3: mt*at3+bt3*(vt3-vg)+kt3*(ut3-ug)=kc*(uc3-ut3)+b_c*(vc3-vt3)
  uc3: dt(uc3)=vc3
  vc3: mc*ac3+b_c*(vc3-vt3)+kc*(uc3-ut3)=0
! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 1       { For each material region }
    START(0,0)   { Walk the domain boundary }
    LINE TO (1,0) TO (1,1) TO (0,1) TO CLOSE
TIME 0 TO 20   { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
  for time=0 by 0.1 to endtime
  	!history(uc1) at (0,0)
    !history(ut1) at (0,0)
    !history(uc2) at (0,0)
    !history(ut2) at (0,0)
    history(uc3) at (0,0)
    history(ut3) at (0,0)
END
