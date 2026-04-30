![LOGO](pics/LOGO.png)

# There will be three differnt *```Program Select Mode```* options covered here
> Currently other is the only complete setup guide, but RSR and PNS are coming soon

---

## 1. [RSR](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/Remote%20Control%20Methods/RSR)
    
- RSR allows you to use the indiviual bits of a byte to select which program to run. This means you can call up to 8 different programs from the remote PLC.

## 2. [PNS](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/Remote%20Control%20Methods/PNS)

- PNS uses the same byte as RSR but looks at it as an integer and calls programs based on it's value. This means that you can call up to 255 different programs from the PLC. This number can be increased if necessary but that is not covered here.

## 3. [Other](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/Remote%20Control%20Methods/Other)

- Other allows you to set a main programed that is called whenever a start request is recieved. The initial setup is a bit quicker, and for that reason this method is often prefered by people who are more familiar with robot programing than PLC programing. 