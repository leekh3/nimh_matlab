import numpy as np
import os
import glob
import pandas as pd

# Em

files = glob.glob('./EmpericalData/*.dat')
Conditions = ['NEU','INC','CON']
newFolder = './EmpericalData_Organized/'
os.system('mkdir -p ' + newFolder)

for F in files:
    data = pd.read_csv(F, header=None, delimiter=r"\s+")
    subjectID = F.split('/')[-1].split('.dat')[0]
    for C in Conditions:
        dataSeg = data[data[0]==C]
        del dataSeg[0]
        # dataSeg[0] = subjectID
        outFile = newFolder + subjectID + '_' + 'ET' + '_' + C + '.dat'
        dataSeg.to_csv(outFile,index=False,sep=' ', header=None)

files = glob.glob('./StimulationData/*.dat')
Conditions = ['NEU','INC','CON']
newFolder = './SimulationData_Organized/'
os.system('mkdir -p ' + newFolder)

for F in files:
    data = pd.read_csv(F, header=None, delimiter=r"\s+")
    subjectID = F.split('/')[-1].split('_ET_')[0]

    # data[2] = subjectID
    outFile = newFolder + F.split('/')[-1]
    data.to_csv(outFile,index=False,sep=' ', header=None)

