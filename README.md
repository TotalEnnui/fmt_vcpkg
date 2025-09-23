# UCT64  
vs code defaults to MSVC, and not configured for for ucrt64 so configuration and compile must be done via ucrt64 bash  


## Using makefile:  Within MSYS64 UCRT64 bash  
cmake --preset ucrt64-release  
cmake --build --preset build-ucrt64-release  

## Using ninja: ucrt64-ninja with ucrt64 bash  
cmake --preset ucrt64-ninja  
cmake --build --preset ucrt64-ninja  

# Git

## Configure git, within bash   
git config --global user.nam "TotalEnnui"  
git config --global user.email "aprpkp@gmail.com"  

# Reconfiguring cmake  
deleting <u>CMakeCache.txt</u> file, CMake will reconfigure the project from scratch the next time you run cmake or build using a preset  

