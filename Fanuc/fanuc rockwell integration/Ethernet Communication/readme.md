# PLC-to-Robot Ethernet/IP Setup and Communication Verification  
**Module 6 – Lesson 6.1: PLC to Robot Integration**

---

## Lesson Context

**Demonstration Focus:** Configure Fanuc Robot and Allen-Bradley PLC for Ethernet/IP Communication  
**Standards Alignment:**
- **Controls:** Network communication, tag mapping, system addressing  
- **Robotics:** External control permissions, UOP configuration, and safe remote start/stop enablement  

---

## 1. Instructor Introduction (0:00 – 1:00)

> “In this demonstration, we will walk through how to configure a Fanuc robot controller for Ethernet/IP communication with an Allen-Bradley PLC. By the end, you’ll understand how the PLC and robot exchange input/output data, how to verify communication, and how to enable safe external control of the robot.”

**Learning Objectives**
- Configure the robot’s system parameters for external start/stop control  
- Assign a static IP and subnet for communication  
- Configure Ethernet/IP adapter settings  
- Create and link a Generic Ethernet Module in Studio 5000  
- Verify communication through successful ping and data exchange  

---

## 2. Demonstration Setup (Instructor Preparation)

- Power on **Fanuc Robot Controller**, **Allen-Bradley PLC**, and **connected HMI/PC**  
- Confirm all devices share the same network switch or subnet  
- Verify access to the **robot’s teach pendant** and **Studio 5000 software**  
- Ensure all safety protocols are followed and **motion power remains disabled** during configuration  

![Trainer setup with PLC, robot controller, and HMI visible](/pics/pic1.png)

---

## 3. Robot System Configuration (Fanuc Controller)

> “Let’s begin by configuring the Fanuc controller for external communication.”

**Steps**
1. On the teach pendant, select:  
   `MENU → NEXT → SYSTEM → CONFIG`  
2. Set **#7 Enable UI Signals = TRUE**  
   - Allows PLC to start/stop the robot externally  
3. Scroll to **#41 Remote/Local Setup** and set to **REMOTE**  
   - Enables external start/stop control  
4. Optionally review digital outputs (status bits) that display robot state, mode, or E-Stop condition  

![Fanuc System Config menu showing UI and Remote Mode options](/pics/pic2.png)

**Checkpoint**
> Confirm UI Signals and Remote Mode are both active before continuing.

---

## 4. Configure Host Communications (Robot IP Address)

> “Now we’ll set the robot’s IP address and verify its connection to the PLC and PC.”

**Steps**
1. On teach pendant: `MENU → SETUP → HOST COMM → TCP/IP (F3 Detail)`  
2. Assign a **Robot Name** (e.g., `Robot01`)  
3. Set a **Static IP Address** (e.g., `the.robot.ip.address`) — ensure the first three octets match the PLC and PC  
4. Subnet Mask: `255.255.255.0`  
5. Add connected devices (PLC + PC IPs)  
6. Press **F5 Initiate** to apply settings (or power cycle controller)  
7. Verify communication:
   - `F4 Ping` → PLC IP → expect “Ping Succeeded”  
   - If timed out → check network cable or subnet configuration  

![Host Comm configuration with IP/subnet fields filled](/pics/pic3.png)

**Checkpoint**
> Robot and PLC successfully ping each other on the same subnet.

---

## 5. Configure Ethernet/IP Adapter on Robot

> “With communication established, we’ll configure the Ethernet/IP adapter that allows data exchange between the PLC and robot.”

**Steps**
1. Teach pendant: `MENU → I/O → Ethernet/IP`  
   - If missing, robot requires licensed Ethernet/IP option (Fanuc pack code)  
2. Select **Adapter Configuration (F4 Config)**  
3. Set:
   - **Input Size:** `4 words`  
   - **Output Size:** `4 words`  
   - *(1 word = 16 bits)*  
4. Confirm **Adapter Enabled = TRUE** and **Status = RUNNING**  
5. Verify **Scanner IP** auto-populates to PLC IP  
6. Confirm **Requested Packet Interval (RPI)** = `30 ms`  

![Ethernet/IP Adapter Config screen with sizes and RPI highlighted](/pics/pic4.png)

**Checkpoint**
> Adapter is enabled and running with PLC IP detected automatically.

---

## 6. Configure PLC in Studio 5000

> “Next, we’ll add a generic Ethernet module to the PLC project and verify communication.”

**Steps**
1. Open **Studio 5000** project connected to PLC  
2. Confirm active network path (`Who Active`)  
3. Under Ethernet branch → **Right-click → New Module → Generic Ethernet Module**  
4. Set:  
   - **Name:** `Fanuc_Robot`  
   - **Comm Format:** `Data - INT`  
   - **IP Address:** match robot’s static IP (e.g., `the.robot.ip.address`)  
5. Under **Assembly Instances:**  
   - **Input:** 101 (4 words)  
   - **Output:** 100 (4 words)  
   - **Config:** 1 (0 words)  
6. Under **Connection:**  
   - **Unicast:** Enabled  
   - **RPI:** 30 ms  
7. Click **OK** → Go **Online** → Confirm **Status = Running**  

![Studio 5000 Ethernet Module configuration screen](/pics/pic5.png)

**Checkpoint**
> PLC and robot are online with module status “Running” and no connection faults.

---

## 7. Verify Tag Data in PLC

> “Finally, we’ll confirm that the robot’s data is arriving in the PLC and that the bit mapping is correct.”

**Steps**
1. Open **Controller Tags → Generic Ethernet Module**  
2. Verify **Robot Inputs** and **Robot Outputs** contain four 16-bit words each  
3. Remember:  
   - **Robot Outputs → PLC Inputs**  
   - **PLC Outputs → Robot Inputs**

![Studio 5000 controller tags window showing four 16-bit data words](/pics/pic6.png)

**Checkpoint**
> PLC recognizes all four data words from robot and exchanges outputs correctly.

---

## 8. Wrap-Up Discussion

> “We’ve now established communication between the robot and PLC using Ethernet/IP. In the next demonstration, we’ll map the robot’s internal signals to the PLC tags and complete the handshake logic to start, monitor, and safely stop the process.”

**Key Takeaways**
- Ensure all devices share a **matching subnet** and **static IPs**  
- Configure **UI signals** and **remote mode** before external control  
- Match **data sizes and RPIs** between robot and PLC  
- Understand data direction: **Robot outputs = PLC inputs**

![Trainer system showing module status “Running” on both robot and PLC](/pics/pic7.png)

---

### End of Demonstration 1
Next: *Instructor Demonstration Script 2 – Signal Mapping and Handshake Logic Setup*
