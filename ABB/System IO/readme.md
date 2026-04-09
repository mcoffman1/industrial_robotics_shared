![LOGO](./LOGO.png)

# ABB System Inputs (SI) and System Outputs (SO)

On ABB robots, **System Inputs (SI)** and **System Outputs (SO)** provide the interface between the robot controller and external devices such as PLCs. These signals are used for program control, fault handling, and status monitoring.  

- **SI (inputs)** → Commands sent *to the robot* from external devices.  
- **SO (outputs)** → Status signals sent *from the robot* to external devices.  

---

## Standard SO (System Outputs)

| Signal | Name             | Description                                                                 |
|--------|------------------|-----------------------------------------------------------------------------|
| SO[1]  | Motors On        | Indicates that robot drives (servo power) are ON.                          |
| SO[2]  | Motors Off       | Indicates that robot drives are OFF.                                       |
| SO[3]  | Program Running  | A program is currently executing.                                          |
| SO[4]  | Program Stopped  | Program has finished or been stopped.                                      |
| SO[5]  | Program Fault    | A fault or error condition is present.                                     |
| SO[6]  | Emergency Stop   | Robot is in an E-stop state.                                               |
| SO[7]  | Hold Active      | Robot motion is currently being held.                                      |
| SO[8]  | Cycle Complete   | Program or cycle has finished successfully.                                |

*(Exact numbering may vary depending on system configuration — check the I/O mapping in RobotStudio or on the FlexPendant.)*

---

## Standard SI (System Inputs)

| Signal | Name         | Description                                                                 |
|--------|--------------|-----------------------------------------------------------------------------|
| SI[1]  | Motors On    | Turns robot drives ON. Must be ON before the robot can move.                |
| SI[2]  | Motors Off   | Turns robot drives OFF.                                                     |
| SI[3]  | Start        | Starts or resumes program execution.                                        |
| SI[4]  | Stop         | Stops the currently running program.                                        |
| SI[5]  | Hold         | Temporarily pauses robot motion until released.                             |
| SI[6]  | Emergency Stop | Triggers an immediate E-stop of the robot.                                |
| SI[7]  | Reset        | Clears certain faults or errors (depending on configuration).               |
| SI[8]  | Cycle Start  | Initiates a programmed cycle when configured for external control.          |

---

## Customizing SI/SO

ABB robots allow flexible mapping of additional **System Signals** or **User Signals** for application-specific needs. Examples include:

- Indicating that the robot has entered a specific work zone.  
- Signaling process completion to a PLC.  
- Triggering macros or routines (e.g., “Go Home,” “Clamp Open/Close”).  

Signal assignments are configured through **RobotStudio** or on the **FlexPendant → Controller → I/O Configuration** menus.  

---

## Program Selection Methods

ABB supports several methods for external program selection and execution:  

### 1. PP to Main
- A **Start** input begins execution from the `main` routine.  
- Simple configuration, often used in smaller cells.  

### 2. PP to Routine / Program Number Selection
- An external device (e.g., PLC) selects which program to run by setting designated SI signals.  
- A strobe signal is typically used to latch the selection.  

### 3. RAPID Triggers
- RAPID programs can monitor **digital inputs** to dynamically select or call routines.  
- Provides more flexibility for complex applications.  

---

## Checking Configuration on an ABB Robot

To verify how SI/SO are assigned:

1. On the **FlexPendant**, open **Menu → I/O → Signal**.  
2. Select **System Inputs** or **System Outputs**.  
3. Review assigned signals, their comments, and mapped hardware I/O.  
4. In **RobotStudio**, use the **Controller tab → Configuration → I/O System** for a complete overview.  

---

## Notes

- The robot must be in **Automatic – External** mode for SI/SO to function under PLC control.  
- In **Automatic – Local**, programs can only be started from the FlexPendant.  
- Reserved or unused signals can be mapped for custom integration needs.  

---
