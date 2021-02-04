program solarsys
  implicit none

  !Number of objects


  real :: G_constant, Steps, t_step, T
  real, allocatable :: data(:,:,:),Masses(:), S(: , :)
  integer :: Step_total, i, j, fraction, N, index, M
  Character(len = 80) :: dummy
  Character(len = 80), allocatable :: Names(:)

  !Gravitational constant in AU**3/solar mass/ days**2
  G_constant = 2.959*10.0**(-4.0)


  !Here we read the starting data of our planets from a file

  open (unit = 10, file = "planets.txt")

  !We read the  Number of objects from the file as N and then the fraction of data points we want to save
  !We also read M, the amount of data points we want to plot, T the total time of simulation and t_step the time step we want 
  read(10,*) dummy, dummy, N
  read(10,*) dummy, dummy, fraction
  read(10,*) dummy, dummy, M
  read(10,*) dummy, dummy, T
  read(10,*) dummy, dummy, t_step
  read(10,*)
  !Here we calculate how many steps we have to calculate
  Step_total = int(T/t_step)
  !Here we allocate memory for our arrays, depending on how large N is
  allocate(data(2,Step_total,N))
  allocate(Masses(N))
  allocate(S(6,N))
  allocate(Names(N))

  !S stores each objects 3 dimensional position and velocity
  !Masses stores each objects mass


  !Read the Names, masses, positions and velocities of our objects from file.
  do i = 1,N
    read(10,*) Names(i), Masses(i), s(1,i), s(2,i), s(3,i), s(4,i), s(5,i), s(6,i)
  end do
  close(10)



  !Here we do the simulation with steps calculated from the given time and timestep and save the positions
  !We also always subtract the position of the orbital parent(Sun) of
  !any given position of the objects so that the sun is always at the center
  !We also print information relevant to the simulation during it so we know what is happening

  do i = 1,Step_total
    if (mod(i,fraction) == 0) then
      index = index + 1
    end if

    if (mod(i,M) == 0.or.(i ==Step_total)) then


      print*, "Number of objects: ", N
      print*, "Time from beginning of simulation(days): ", t_step*i
      print*, 'Steps written to file: ', index
      do j = 1,N
        print*, Names(j),':', 'X = (', s(1,j),')', 'Y = (', s(2,j),')'
      end do
    end if

    call timestep(s)
    do j = 1,N
      data(1,i,j) = s(1,j) - s(1,1)
      data(2,i,j) = s(2,j) - s(2,1)
    end do
  end do




  !Here we write our saved data to a file to be read for the plotting, we only save
  !the fraction given as an input to the file
  open(20, file = 'data1.dat')
    do i = 1, size(data,2)
      if (mod(i,fraction) == 0) then

        !IMPORTANT
        !Here for the saving of the data in the correct format you need to change if you change the amount
        !of objects in the simulation and depending on how many of those you want to store into the output file
        !The first dimension is the x or y coordinate with 1 and 2 being x and y respectively
        !Second dimension is I or the i:th data stored
        !The third dimension is the object, So the x position of the sun, object 1
        !in our simulation is data(1,i,1), y would be data(1,i,2)

        write(20,*) data(1,i,1), data(2,i,1), data(1,i,2), data(2,i,2), data(1,i,3), data(2,i,3), &
        data(1,i,4), data(2,i,4), data(1,i,5), data(2,i,5), data(1,i,6), data(2,i,6), data(1,i,7), data(2,i,7), &
        data(1,i,8), data(2,i,8), data(1,i,9), data(2,i,9)

        !These are then read for plotting in python
      end if
    end do
  close(20)





  contains
  !Here we have a subroutine that given the position/velocity matrix of our objects, does a single timestep
  !And updates the new positions and velocities of the given objects to the matrix
  subroutine timestep(s)
    implicit none
    real, intent(inout) :: s(6,N)
    real :: a(3),r(3),v(3),rj(3),a0(3)
    integer :: i,j

    do i = 1,N
      a = accelerations(s,i)
      v = (/s(4,i),s(5,i),s(6,i)/)
      r = (/s(1,i),s(2,i),s(3,i)/)
      a0 = a
      r = r + v * t_step + 1.0/2.0 * a * t_step**2.0
      s(1,i) = r(1)
      s(2,i) = r(2)
      s(3,i) = r(3)

      a = accelerations(s,i)

      v = v + 1.0/2.0 * ((a+a0)*t_step)




      s(4,i) = v(1)
      s(5,i) = v(2)
      s(6,i) = v(3)


    end do


  end subroutine timestep

  !Here we define an acceleration function that we can calculate the acceleration of any given planet when needed
  !It makes it easier to just call upon the function than to have all this in the timestep function

  function accelerations(s,object) result(a)
    implicit none
    real, intent(in) :: s(6,N)
    integer, intent(in) :: object
    real :: a(3),r(3),rj(3)
    integer :: i,j

      i = object
      a = (/0.0,0.0,0.0/)
      r = (/s(1,i),s(2,i),s(3,i)/)

      !Here j is the object we are calculating a for
      do j = 1,N
        !Make sure we dont calculate its acceleration on itself
        if (j /= i) then
        rj = (/s(1,j),s(2,j),s(3,j)/)
          !Newtons law of universal gravitation
          a = a - G_constant*Masses(j)*(r-rj)/(norm2((r-rj)))**(3.0)
        end if
      end do


    end function accelerations



end program solarsys
