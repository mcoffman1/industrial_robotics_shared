![LOGO](./LOGO.png)

# FANUC UOP (User Operator Panel) Signals

The **User Operator Panel (UOP)** signals on a FANUC robot allow communication between the robot controller and external devices such as PLCs. These signals are divided into **UO (outputs)** that indicate robot status, and **UI (inputs)** that accept commands from external devices.

---

## Standard UO (User Operator Panel Outputs)

| Signal | Name            | Description                                                                 |
|--------|-----------------|-----------------------------------------------------------------------------|
| UO[1]  | Cmd enabled     | Robot is in Remote mode, not faulted, ready to receive external commands.  |
| UO[2]  | System ready    | Servo motors are ON; robot is ready to move.                               |
| UO[3]  | Prg running     | A program is currently executing.                                          |
| UO[4]  | Prg paused      | The currently running program has been paused.                             |
| UO[5]  | Motion held     | Robot motion is held, typically due to UI Hold signal being OFF.           |
| UO[6]  | Fault           | A fault is present; requires reset to clear.                               |
| UO[7]  | At perch        | Robot is at predefined reference position #1.                              |
| UO[8]  | TP enabled      | Teach Pendant is in use, robot unavailable for remote control.             |
| UO[9]  | Battery Alarm   | Low battery—must be replaced or robot loses calibration data.              |
| UO[10] | Reserved        | Available for custom assignment.                                           |
| UO[11] | Reserved        | Available for custom assignment.                                           |
| UO[12] | TP Active       | Teach Pendant is actively controlling the robot.                           |
| UO[13] | Reserved        | Available for custom assignment.                                           |
| UO[14] | Reserved        | Available for custom assignment.                                           |
| UO[15] | Reserved        | Available for custom assignment.                                           |
| UO[16] | Reserved        | Available for custom assignment.                                           |

---

## Standard UI (User Operator Panel Inputs)

| Signal | Name        | Description                                                                 |
|--------|-------------|-----------------------------------------------------------------------------|
| UI[1]  | *IMSTP      | Immediate Stop—OFF immediately stops robot. Must be ON to allow motion.    |
| UI[2]  | *Hold       | OFF pauses motion; ON resumes from current position.                       |
| UI[3]  | *SFSPD      | Safe Speed—OFF pauses robot and limits override speed.                     |
| UI[4]  | Cycle Stop  | Performs a cycle stop or abort depending on configuration.                 |
| UI[5]  | Fault Reset | Pulsed to clear faults.                                                    |
| UI[6]  | Start       | Starts/resumes a program (behavior depends on `$shell_cfg.$cont_only`).    |
| UI[7]  | Home        | Executes a "home" macro to return robot to a defined position.             |
| UI[8]  | Enable      | ON enables robot to move and run programs.                                 |

---

## Customizing UOP Signals

While many UOP signals have defaults, higher-numbered signals can be remapped or assigned custom functions, such as:

- Signaling a macro is running.  
- Indicating robot entry into a work zone.  
- Informing a PLC that a process step has completed.  

---

## Program Selection Methods

UI[9] through UI[16] are commonly used for **remote program selection**. Two methods exist:

### 1. Robot Service Request (RSR)
- **UI[9-16]** → Correspond to RSR1 through RSR8.  
- **How it works**: Turning ON one of these signals requests execution of a pre-assigned program (e.g., `RSR0001`–`RSR0008`).  
- **Sequencing**: Requested program is queued and executed once the current program finishes.  

### 2. Program Number Selection (PNS)
- **UI[9-16]** → Represent PNS1 through PNS8, forming an 8-bit binary number (1–255).  
- **How it works**: PLC sets a binary combination of UI[9-16].  
- **PNSTROBE (UI[17])**: Pulsed ON/OFF to latch the program selection.  
- **Flexibility**: Supports up to 255 programs, unlike the 8-program RSR limit.  

---

## Checking Configuration on a FANUC Robot

To verify how UI/UO signals are assigned:

1. Press **MENU** on the Teach Pendant.  
2. Navigate to **I/O**.  
3. Select **UOP**.  
4. Review assigned signals, comments, and functions.  

---

## Notes

- The robot must be in **Remote mode** for UI/UO signals to function.  
- Reserved signals can be configured as needed for specific applications.  

## How to Tell if the Robot is in Remote Mode

On the Teach Pendant, look for the Remote/Local setting:

1. Press **MENU** → **SYSTEM** → **Config**.
2. Find the option **Remote/Local Setup**.
3. You can set the default start method:

**Local** = pendant controls program start.

**Remote** = external UI/UO signals control program start.

---
