{ Fill in the following sections (removing comment marks ! if necessary),
  and delete those that are unused.}
TITLE 'New Problem'     { the problem identification }
COORDINATES cartesian3  { coordinate system, 1D,2D,3D, etc }
VARIABLES        { system variables }
  u !x-displacement
  v !y-displacement
  w !z-displacement
! SELECT         { method controls }
DEFINITIONS    { parameter definitions }
E=2e9    !Problem Specific Variables
nu=0.3
Lx=0.4
Ly=1
Lz=0.2


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



sx = C11*ex + C12*ey + C13*ez   !Hooke's Law
sy = C21*ex + C22*ey + C23*ez
sz = C31*ex + C32*ey + C33*ez
! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  u: dx(sx)=0   !Static Equil
  v: dy(sy)=0
  w:dz(sz)=0
EXTRUSION
surface 'bottom' z=0
surface 'top' z= Lz
BOUNDARIES       { The domain definition }
  surface 'bottom'
  	load(u) = 0
    load(v)=0
    value(w)=0
    
surface 'top'
	load(u)=0
    load(v)=0
    load(w)=0

REGION 1
	START(0,0)   !Bottom Line
    	load(u)=0
        value(v)=0
        load(w)=0
    
    LINE TO (Lx,0)   !Right Line
    	load(u)=0
        load(v)=0
        load(w)=0
    
    LINE TO (Lx,Ly)   !Top Line
   	 load(u)=0
     load(v)=(-3481)/(Lx*Lz)
     load(w)=0
     
     LINE TO (0, Ly)   !Left Line
     value(u)=0
     load(v)=0
     load(w)=0
      
    LINE TO CLOSE
    
PLOTS            { save result displays }
  grid(x+u,y+v,z+w)
  grid(x+u*1000, y+v*1000,z+w*1000)
  contour(u) on surface z=0
  elevation(sx,sy,sz) from (Lx/2, Ly/2, 0) to (Lx/2, Ly/2, Lz)


END
