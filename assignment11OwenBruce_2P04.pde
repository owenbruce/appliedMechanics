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

fApplied = 1E9
fPure = fApplied*Lx/Ly

C11 =8E9
C22 = 8E9
C33 =6E9

C12 = 2E9
C13 = 1E9
C23 = 1E9


C14=1E9	!isotropic material
C15=0
C16=0
C24=-1E9
C25=0
C26=0
C34=0
C35=0
C36=0

C44=5E9	!isotropic material
C55=5E9
C66=4E9
C45=0
C46=0
C56=2E9

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
     load(v)=0
     load(w)=0
      
    LINE TO CLOSE
    
PLOTS            { save result displays }
  grid(x+u,y+v,z+w)
  grid(x+u*20, y+v*20,z+w*20)
  contour(ex) painted on x=Lx
  contour(ey) painted on y=0
  contour(ey) painted on y=Ly
  contour(ez) painted on z=0
  contour(ez) painted on z=Lz

Summary 
	report val(u,Lx,Ly/2,Lz/2)
    report val(ex,Lx,Ly/2,Lz/2)

END
