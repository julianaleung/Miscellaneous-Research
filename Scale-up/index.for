! copyright by Vikrant Vishal and Juliana Leung
! Variance of mean calculations
! Vishal, V. and Leung, J.Y. (2015). Modeling impacts of subscale heterogeneities on dispersive solute transport in subsurface systems. 
!Journal of Contaminant Hydrology 182: 63-77. https://doi.org/10.1016/j.jconhyd.2015.08.006 
!Leung, J.Y. and Srinivasan, S. (2011). Analysis of uncertainty introduced by scaleup of reservoir attributes and flow response in heterogeneous reservoirs. 
!SPE Journal 16 (3): 713-724. https://doi.org/10.2118/145678-PA

    program INDIX
        implicit none

        integer nnzmax 
        parameter (nnzmax=1000)
        integer ox(nnzmax,nnzmax),oy(nnzmax,nnzmax)
        real dist(nnzmax,nnzmax),hmaj(nnzmax,nnzmax),hmin(nnzmax,nnzmax)
c        real hstd(nnzmax,nnzmax)
c       integer ,dimension(:,:), allocatable ::ox,oy
        integer q,nx,ny,l,R,j,k,i,n,m,p
c       real ,dimension(:,:,:), allocatable::dist
        real h,roh,Rmaj,Rmin,xsiz,ysiz
        double precision vari_mean,tot_roh,hstd(nnzmax,nnzmax)
        open(unit=1,file='length.dat')
        open(unit=2,file='leng_var.dat')
		
        Rmaj=200.0!200.0
        Rmin=50.0 !50.0
        xsiz=2.0 !grid size in x direction 
        ysiz=2.0 !grid size in y direction 
!!!        R=5.0 
      do l=0,500 !0-500  
          nx=l
          ny=l 
c	      m=(l*l)**10   
c	      p=m*m
c          allocate(ox(100,100))  
c	      allocate(oy(100,100))
c          allocate(dist(100,100,100))   
!!!        write(*,*)'*********************************' 
c        stop  
        n=0
        roh=0.0
        tot_roh=0.0
        vari_mean=0.0
            do j=0,nx
	            do i=0,ny	   
			          ox(i,j)=i
			          oy(i,j)=j
		              n=n+1 			 
!!!	                  write(1,*)n,i,j,ox(i,j),oy(i,j)
		        end do
	        end do
!!!        write(*,*)'*********************************'		
!!!       stop
           n=0
			
            do k=0,ny
		        do q=0,nx   
c		   	         n=n+1 
                    do j=0,ny
	                     do i=0,nx
						      n=n+1 
c	      dist(k,q)=(((ox(k,q)-ox(i,j))**2)+((oy(k,q)-oy(i,j))**2))
c         h=SQRT(dist(k,q))
          hmaj(q,k)=(ox(q,k)-ox(i,j))*xsiz
          hmin(q,k)=(oy(q,k)-oy(i,j))*ysiz
          hstd(q,k)=SQRT((hmaj(q,k)/Rmaj)**2+(hmin(q,k)/Rmin)**2)
c         write(*,*)l,n,q,k,j,i,ox(q,k),ox(i,j),
c     c	            hmaj(q,k),hmin(q,k),hstd(q,k)
c	     stop
                if(hstd(q,k).GE.1)then            
                 roh=0.0                            
                else
		         roh=(1.0-1.0*((1.5*(hstd(q,k)))-(0.5*(hstd(q,k))**3)))
	            end if                            
				
!!!       
	        
c		        roh=(1-1*((1.5*(hstd(q,k)))-(0.5*(hstd(q,k))**3)))
	            tot_roh=tot_roh+roh
				
		      if(roh.LT.0.0)then
		      write(1,'(6(I5,2X),5(F10.3,3X))')l,n,q,k,i,j,
     &             hmaj(q,k),hmin(q,k),hstd(q,k),roh,tot_roh
              end if
			  
		                 end do
	 		        end do   
			    end do 
	        end do
	        vari_mean = tot_roh/((nx+1)*(ny+1))
	        vari_mean = vari_mean/((nx+1)*(ny+1))
        write(2,*)(nx+1)*xsiz*(ny+1)*ysiz,tot_roh,vari_mean
c        stop
c        DEALLOCATE(ox,oy,dist)  
      end do
      close(1)
      close(2)	
      stop
      end program
