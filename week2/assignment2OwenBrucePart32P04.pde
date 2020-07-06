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
k=654*3
b=1.7*3
m=6
a = dt(v)
a_resonance=0.02
omega = sqrt(k/m)
uground = 0.001*sin(omega*t)
! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  u: dt(u)=v
  v: m*a+b*v+k*(u-uground)=0
! CONSTRAINTS    { Integral constraints }
BOUNDARIES       { The domain definition }
  REGION 1       { For each material region }
    START(0,0)   { Walk the domain boundary }
    LINE TO (1,0) TO (1,1) TO (0,1) TO CLOSE
TIME 0 TO 5   { if time dependent }
MONITORS         { show progress }
PLOTS            { save result displays }
  for time=0 by 0.1 to endtime
  	history(u,v/25,a/25^2) at (0,0)
SUMMARY
	report eval(u,0,0) as "Final x position "
    report eval(v,0,0) as "Final velocity "
    report eval(a,0,0) as "Final acceleration "
END
