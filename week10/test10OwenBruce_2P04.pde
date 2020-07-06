{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'New Problem'     { the problem identification }
COORDINATES cartesian3  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  u !x-displacement
  v !y-displacement
  w !z-displacement
SELECT         { method controls }
stages=10
DEFINITIONS    { parameter definitions }
Lx=0.4
Ly=0.1
Lz=2

E=76E9
nu=0.21
rho=2300

omega=2034.7!+0.01*stage


mag=1E3

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
  u: dx(sx) + dy(sxy) + dz(sxz)=-rho*omega^2*u   !Static Equil
  v: dy(sy) + dx(sxy) + dz(syz)=-rho*omega^2*v   
  w: dz(sz) + dx(sxz) + dy(syz)=-rho*omega^2*w   
EXTRUSION
surface 'bottom' z=0
surface 'top' z= Lz
BOUNDARIES       { The domain definition }
  surface 'bottom'
  	value(u)=0
    value(v)=0
    load(w)=0
    
surface 'top'
	value(u)=0
    value(v)=0
    value(w)=0

REGION 1
	START(0,0)   !y=0 line
    	load(u)=0
        load(v)=7
        load(w)=0
    
    LINE TO (Lx,0)   !x=Lx line
    	load(u)=0
        load(v)=0
        load(w)=0
    
    LINE TO (Lx,Ly)   !y=Ly line
   	 load(u)=0
     load(v)=0
     load(w)=0
     
     LINE TO (0, Ly)   !x=0 line
     load(u)=0
     load(v)=0
     load(w)=0
      
    LINE TO CLOSE
    
PLOTS            { save result displays }
  grid(x+u,y+v,z+w)
  grid(x+u*mag, y+v*mag,z+w*mag)
  
  elevation(v) from (Lx/2, Ly/2, 0) to (Lx/2, Ly/2, Lz)   !y-transverse plots
  history(v) at (Lx/2,Ly/2,Lz*0.6)

Summary 
	report val(w,Lx/2,Ly/2,0)

END
