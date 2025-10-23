# UOP Configuration, Signal Mapping, and Handshake Logic Setup  
**Module 6 – Lesson 6.1: PLC to Robot Integration**

---

## Lesson Context

**Demonstration Focus:** Configure User Operator Panel (UOP) signals and map robot I/O to the PLC for reliable handshake communication.  
**Standards Alignment:**
- **Controls:** Tag mapping, I/O logic alignment, and feedback visualization  
- **Robotics:** External control signals, safety interlocks, and command enable sequencing  

---

## 1. Instructor Introduction (0:00 – 0:30)

> “In this demonstration, we’ll configure the robot’s User Operator Panel (UOP) inputs and outputs, map them to the PLC through Ethernet/IP, and verify handshake logic using Studio 5000 and an HMI screen.”

**Learning Objectives**
- Define UOP input and output assignments on the robot  
- Map UOP bits to PLC tags in Studio 5000  
- Identify critical signals for start, hold, fault, and reset  
- Demonstrate how HMI feedback reflects real-time robot state  

---

## 2. Access the UOP Configuration on the Robot

> “Let’s begin on the Fanuc controller and configure the UOP inputs and outputs used for the handshake.”

**Steps**
1. On the teach pendant, navigate to `MENU → I/O → UOP`.  
2. Use **F3** to toggle between Inputs and Outputs.  
3. Start with the **UOP Inputs** screen.  
   - Remember: UOP inputs are **outputs from the PLC** and **inputs to the robot**.

![Fanuc UOP menu screen showing Inputs and Outputs](/pics/pic1.png)

---

## 3. Configure UOP Inputs

**Steps**
1. Press **F2 Configure**.  
2. Set **Range = 1 through 8 bits** (typical for handshake operations).  
3. Set **Rack = 89** (Ethernet/IP communication).  
   - Other fieldbus types use different racks per Fanuc manuals.  
4. Set **Slot = 1** (for PLC connection).  
5. Set **Start Instance = 21** – aligns to assembly instances on the PLC side.  
   - Avoid overlap with digital I/O bit ranges.  
6. Confirm and exit.

![UOP Input Configuration screen with rack, slot, and instance fields highlighted](/pics/pic2.png)

**Instructor Note**
> Bits 1-8 typically represent Start, Stop, Hold, Fault Reset, and Enable signals. Keep bit assignment consistent with Trane standards for external control mapping.

---

## 4. Configure UOP Outputs

**Steps**
1. Toggle to **Outputs** using F3.  
2. Configure the same **Range (1-8)**, **Rack (89)**, and **Slot (1)**.  
3. Use **Start Instance = 21** to align with PLC assembly instance.  
4. If you change bit ranges or sizes, the status will show *Pending* – you must power cycle to apply.  

![UOP Output Configuration screen showing Pending changes indicator](/pics/pic3.png)

**Checkpoint**
> After power cycling, verify the UOP I/O pages show Active status and correct bit ranges.

---

## 5. Map UOP Signals in Studio 5000

> “Now let’s move to the PLC to link these UOP signals to our controller tags.”

**Steps**
1. Open **Studio 5000 → Controller Tags**.  
2. Expand the Generic Ethernet Module configured in Demo 1.  
3. Locate **Robot Inputs** and **Robot Outputs**.  
4. Open the first word (Word 0) and identify bit positions 0-15.  
5. Based on Start Instance 21, the UOP input bits begin on Word 1 – Bit 4.  
6. Label each bit using descriptions such as `Program Running`, `Faulted`, `Motion Held`, `Command Enable`, etc.

![Studio 5000 controller tags showing UOP bit mapping](/pics/pic4.png)

**Instructor Tip**
> A quick way to confirm bit mapping is to toggle the Teach Pendant Enable switch and observe which bit changes in Studio 5000. That confirms bit 8 mapping.

---

## 6. Describe Common UOP Input Signals (from PLC → Robot)

| Bit # | Signal Name | Function |
|-------|--------------|-----------|
| 1 | Enable | Robot ready for external control (start condition) |
| 2 | Start | Triggers robot program start |
| 3 | Cycle Stop | Pauses active program |
| 4 | Fault Reset | Resets faults from PLC or HMI |
| 5 | Hold | Slow stop – motion can resume |
| 6 | IMSTP | Immediate stop – fault generated |
| 7 | SFSPD | Safety signal required ON for operation |
| 8 | Home Macro (Optional) | Returns robot to home if clear of obstructions |

![Table illustration of UOP input bit functions in HMI layout](/pics/pic5.png)

**Safety Reminder**
> Immediate stop (IMSTP) creates a fault and should only be used when required for safety. Never map home macros without verifying clear motion paths.

---

## 7. Describe Common UOP Output Signals (from Robot → PLC)

| Bit # | Signal Name | Function |
|--------|--------------|-----------|
| 1 | System Ready | Robot power and mode OK for start |
| 2 | Program Running | Active program executing |
| 3 | Program Paused | Robot paused waiting for resume |
| 4 | Motion Held | Hold active, no motion commanded |
| 5 | Fault Active | Robot in fault state |
| 6 | Command Enable | External start command accepted |
| 7 | TP Enable Status | Teach Pendant on/off |
| 8 | At Perch | Robot in home or ready position |

![Studio 5000 tag descriptions for UOP output signals](/pics/pic6.png)

**Checkpoint**
> Verify each output changes state appropriately when robot is started, held, or faulted.

---

## 8. HMI Visualization and Signal Testing

> “Now let’s use an HMI to observe and control the UOP signals in real time.”

**Steps**
1. Open the custom HMI screen built for UOP signals.  
2. Observe four critical bits required for the robot to start (Enable, SFSPD, Hold = Off, IMSTP = Off).  
3. Toggle bits to simulate various conditions:  
   - If any required bit drops low, robot holds.  
   - If IMSTP is triggered, robot faults and requires reset.  
4. Use the HMI to reset faults and resume the program.  

![HMI screen showing UOP start/hold/fault signal states](/pics/pic7.png)

**Instructor Note**
> Demonstrate how real-time feedback on the HMI mirrors the robot’s status lights and Studio 5000 tags. This reinforces the link between logical signals and visible machine behavior.

---

## 9. Verify Full Handshake Operation

**Checklist**
- All four required bits high → Robot Ready to Start  
- Start command issued → Program Running  
- Cycle Stop → Program Paused  
- IMSTP → Fault Active  
- Fault Reset → System Ready again  

![Trainer system display with PLC, HMI, and robot status showing handshake flow](/pics/pic8.png)

---

## 10. Wrap-Up Discussion

> “You’ve now completed the UOP configuration and signal mapping process. Your PLC and robot can now start, pause, hold, and fault safely in sync — the foundation of a reliable handshake.”

**Key Takeaways**
- Maintain consistent bit mapping across PLC, robot, and HMI  
- UOP signals are the heart of safe automation control  
- Always verify signal direction (PLC Output = Robot Input)  
- Document bit assignments in the trainer blueprints for future maintenance  

![Final trainer photo showing robot running in Auto with PLC handshake active](/pics/pic9.png)

---

### End of Demonstration 2
Next: *Integration Activity – Operate and Troubleshoot the Full PLC-Robot Handshake Cycle*
