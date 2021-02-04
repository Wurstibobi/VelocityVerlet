import numpy as np
import matplotlib.pyplot as plt


Sun = np.genfromtxt(open('data1.dat',"r"), usecols= [0,1])
Mercury = np.genfromtxt(open('data1.dat',"r"), usecols= [2,3])
Venus = np.genfromtxt(open('data1.dat',"r"), usecols= [4,5])
Earth = np.genfromtxt(open('data1.dat',"r"), usecols= [6,7])
Mars = np.genfromtxt(open('data1.dat',"r"), usecols= [8,9])
Jupiter = np.genfromtxt(open('data1.dat',"r"), usecols= [10,11])
Saturn= np.genfromtxt(open('data1.dat',"r"), usecols= [12,13])
Uranus = np.genfromtxt(open('data1.dat',"r"), usecols= [14,15])
Neptune = np.genfromtxt(open('data1.dat',"r"), usecols= [16,17])








plt.plot(Sun[:,0],Sun[:,1], 'y.',label = 'Sun', markersize = 20)
plt.plot(Mercury[:,0],Mercury[:,1], 'b.',label = 'Mercury', markersize = 1)
plt.plot(Venus[:,0],Venus[:,1], 'g.',label = 'Venus', markersize = 1)
plt.plot(Earth[:,0],Earth[:,1],'m.', label = "Earth" , markersize = 1)
#plt.plot(Moon[:,0],Moon[:,1],'k.',label = "moon", markersize = 3)
plt.plot(Mars[:,0],Mars[:,1], 'k.',label = 'Mars', markersize = 1)
plt.plot(Jupiter[:,0],Jupiter[:,1],'c.',label = 'Jupiter', markersize = 5)
plt.plot(Saturn[:,0],Saturn[:,1], 'C0.',label = 'Saturn', markersize = 4)
plt.plot(Uranus[:,0],Uranus[:,1], 'C1.',label = 'Uranus', markersize = 4)
plt.plot(Neptune[:,0],Neptune[:,1], 'C2.',label = 'Neptune', markersize = 4)


plt.axes().set_aspect('equal')
plt.ylim(-31,31)
plt.xlim(-31,31)
plt.title('Inner solar system with t_step of 1 day over 88 days')
plt.xlabel('X(Au)')
plt.ylabel('Y(Au)')


plt.legend(fontsize = 5)
plt.show()
