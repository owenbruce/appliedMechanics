{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'New Problem'     { the problem identification }
COORDINATES cartesian3  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  u !x-displacement
  v !y-displacement
  w !z-displacement
!SELECT         { method controls }

DEFINITIONS    { parameter definitions }
a=1
E=if y<a then 5E6 else 500E6    !Problem Specific Variables
nu=0.3

mag=100
G=E/(2*(1+nu))

C11=E/((1+nu)*(1-2*nu))*(1-nu)    !Stiffness matrix
C12=E/((1+nu)*(1-2*nu))*nu
C13=C12
C21=C12
C22=C11
C23=C12
C31=C12
C32=C12
C33=C11


ex = dx(u)   !Strain equations
ey = dy(v)
ez = dz(w)

gxy = dy(u) + dx(v)
gxz = dz(u) + dx(w)
gyz = dz(v) + dy(w)

sx = C11*ex + C12*ey + C13*ez   !Hooke's Law
sy = C21*ex + C22*ey + C23*ez
sz = C31*ex + C32*ey + C33*ez
sxy = G*gxy
sxz = G*gxz
syz = G*gyz

! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  u: dx(sx) + dy(sxy) + dz(sxz)=0   !Static Equil
  v: dy(sy) + dx(sxy) + dz(syz)=0
  w: dz(sz) + dx(sxz) + dy(syz)=0
EXTRUSION
surface 'bottom' z=0
surface 'top' z= a
BOUNDARIES       { The domain definition }
  surface 'bottom'
  	load(u)=0
    load(v)=0
    load(w)=0
    
surface 'top'
	load(u)=0
    load(v)=0
    load(w)=0

REGION 1
	START(0,0)
    	value(u)=0
        value(v)=0
        value(w)=0
    line to (0,a)
    load(u)=0
    load(v)=0
    load(w)=0
    line to (4*a,a) line to (4*a,3*a)
    load(u)=500/a^2
    load(v)=500/a^2
    load(w)=500/a^2
    line to (5*a,3*a)
    load(u)=0
    load(v)=0
    load(w)=0
    line to (5*a,0)
    
      
    LINE TO CLOSE
    
PLOTS            { save result displays }
  grid(x+u,y+v,z+w)
  grid(x+u*mag, y+v*mag,z+w*mag)
  

Summary 
	report val(u*a,4.5*a,3*a,0.5*a)
    report val(v*a,4.5*a,3*a,0.5*a)
	report val(w*a,4.5*a,3*a,0.5*a)
END
