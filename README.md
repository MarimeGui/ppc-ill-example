# PPC Illegal Instructions in compiled code

Build with ```cargo build -Z build-std=core,alloc --target powerpc-none-eabi.json```

Dev build works fine, Release build has ```lwsync``` instructions