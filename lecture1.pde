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
!E=70E9    !Problem Specific Variables
!nu=0.32
Lx=0.1
Ly=0.1
Lz=0.1

!G=E/(2*(1+nu))

fApplied = 100E9
fPure = fApplied*Lx/Ly

C11 =8.67361769904436e10
C22 = 8.67361769904436e10
C33 = 1.07193901858028e11

C12 = 6.98526725701223e9
C13 = 1.19104335397808e10
C23 = 1.19104335397808e10


C14=1.79081384131957E12e10	!isotropic material
C15=0
C16=0
C24=-1.79081384131957e10
C25=0
C26=0
C34=0
C35=0
C36=0

C44=5.79427767324731e10	!isotropic material
C55=5.79491958802304e10
C66=3.99072812865916e10
C45=0
C46=0
C56=1.79224317155352e10

C21=C12 !matrix is symmetric
C31=C13
C32=C23
C41=C14	
C42=C24
C43=C34
C51=C15
C52=C25
C53=C35
C61=C16
C62=C26
C63=C36
C54=C45
C64=C46
C65=C56

!! Strain
!Axial Strain
ex=dx(u)
ey=dy(v)
ez=dz(w)
!Engineering Shear Strain
gxy=dx(v)+dy(u)
gyz=dy(w)+dz(v)
gxz=dz(u)+dx(w)

!!Stress via Hooke's law: Voigt Notation
sx = C11*ex+C12*ey+C13*ez+C14*gyz+C15*gxz+C16*gxy
sy = C21*ex+C22*ey+C23*ez+C24*gyz+C25*gxz+C26*gxy
sz = C31*ex+C32*ey+C33*ez+C34*gyz+C35*gxz+C36*gxy
syz=C41*ex+C42*ey+C43*ez+C44*gyz+C45*gxz+C46*gxy
sxz=C51*ex+C52*ey+C53*ez+C54*gyz+C55*gxz+C56*gxy
sxy=C61*ex+C62*ey+C63*ez+C64*gyz+C65*gxz+C66*gxy

! INITIAL VALUES
EQUATIONS        { PDE's, one for each variable }
  u: dx(sx) + dy(sxy) + dz(sxz)=0   !Static Equil
  v: dy(sy) + dx(sxy) + dz(syz)=0
  w: dz(sz) + dx(sxz) + dy(syz)=0
EXTRUSION
surface 'bottom' z=0
surface 'top' z= Lz
BOUNDARIES       { The domain definition }
  surface 'bottom'
  	load(u) = 0
    load(v)=0
    load(w)=0
    
surface 'top'
	load(u)=0
    load(v)=0
    load(w)=0

REGION 1
	START(0,0)   !y=0 line
    	load(u)=0
        load(v)=0
        load(w)=0
    
    LINE TO (Lx,0)   !x=Lx line
    	load(u)=fApplied
        load(v)=0
        load(w)=0
    
    LINE TO (Lx,Ly)   !y=Ly line
   	 load(u)=0
     load(v)=0
     load(w)=0
     
     LINE TO (0, Ly)   !x=0 line
     value(u)=0
     value(v)=0
     value(w)=0
      
    LINE TO CLOSE
    
PLOTS            { save result displays }
  grid(x+u,y+v,z+w)
  grid(x+u*100, y+v*100,z+w*100)
  contour(u) on surface z=0
  elevation(sx,sy,sz) from (Lx/2, Ly/2, 0) to (Lx/2, Ly/2, Lz)

Summary 
	!report val(u,Lx,Ly,Lz)
    report val(v,Lx,Ly/2,Lz/2)
    !report val(w,Lx,Ly,Lz)

END
