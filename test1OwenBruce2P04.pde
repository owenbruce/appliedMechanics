{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'New Problem'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  u (threshold=1e-4)
  v (threshold=1e-4){ choose your own names }
SELECT         { method controls }
ngrid=1
penwidth=3
DEFINITIONS    { parameter definitions }
F=30*(cos(t))^2-20*t*exp(-t)
muk=0.3
m=5
g=9.81
a=dt(v)
! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  u: dt(u)=v
  v: dt(v)*m=F-muk*m*g
! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 1       { For each material region }
    START(0,0)   { Walk the domain boundary }
    LINE TO (1,0) TO (1,1) TO (0,1) TO CLOSE
TIME 0 TO 2 halt(v<0)   { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
  for t=0 by 0.1 to endtime
  	history(u,v,a) at (0,0)
SUMMARY
	report eval(u,0,0) as "Distance until rest "
    report t as "Time until rest "
END
