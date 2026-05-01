![LOGO](./LOGO.png)

# Fanuc Rockwell Integration
> This guide is ment to show how to setup remote control on a fanuc robot in order to control it from a Rockwell PLC. It is not a comprehesive guide. It is simply ment to show some of my prefered methods.

##### If you wish to follow the order listed below the link to the next step can be found at the bottom of each page, however if you prefer a different work flow you can use the links on this page in any order.

## Steps:
1. Setup the [Robot System Config for External Control](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/Ethernet%20Setup/Configure%20Robot%20system%20for%20External%20Control)
2. Setup [Host Comm](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/Ethernet%20Setup/Setup%20Hot%20Comm)
3. Configure the [Ethernet Adapter](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/Ethernet%20Setup/Configure%20Ethernet%20Adapter)
4. Follow the [Remote Control Methods](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/Remote%20Control%20Methods) for the UOP signals
    - There is a signals Guide in the [UOP](https://github.com/mcoffman1/industrial_robotics_shared/tree/main/Fanuc/UOP) folder that shows many of the signals and whay they are used for.
5. Setup the [Fanuc Module on PLC](https://github.com/mcoffman1/basic_shared/tree/main/Allen%20Bradley/Communication%20to%20Fanuc)
    > Some people prefer to setup communication on the PLC first, however it may be easier to discover the module if the robot is setup first. Both methods are fine.