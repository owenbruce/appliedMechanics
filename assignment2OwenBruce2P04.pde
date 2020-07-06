{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'New Problem'     { the problem identification }
COORDINATES cartesian2  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  u      (threshold=1e-8)
  v(threshold=1e-8) { choose your own names }
SELECT         { method controls }
ngrid=1
penwidth=5
DEFINITIONS    { parameter definitions }
g= 9.81
m = 6
k=654*3
b=1.7*3
a = dt(v)
! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  u: dt(u)=v
  v: m*a+m*g+b*v+k*u=0
! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 1       { For each material region }
    START(0,0)   { Walk the domain boundary }
    LINE TO (1,0) TO (1,1) TO (0,1) TO CLOSE
TIME 0 TO 10   { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
  for time=0 by 0.1 to endtime
  	history(u,v/25,a/25^2) at (0,0)
END
