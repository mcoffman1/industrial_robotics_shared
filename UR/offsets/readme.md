# URScript Offset Examples

---

### Purpose:
With UR it is very easy to do relative moves from your current location. However, if you want to move to a location realative to a point **before** moving to that point, you must use ur scripts. These scripts allow you to do these kinds of offsets in different coordinate systems.

---

This repository includes three URScript files that demonstrate different methods of applying positional offsets on a Universal Robots system. Each script is designed to be **reusable** and **parameterized**, meaning no internal modifications are required — simply pass in the required input variables when you call the script.

---

## Script Overview

### 1. `simple_offset.script`

**Purpose:**  
Applies a basic Cartesian offset to the robot’s current tool center point (TCP). The offset is passed in as a variable.

**Inputs:**
- `offset_vector`: A pose or translation `[x, y, z, rx, ry, rz]` applied to the current TCP pose.

**Usage:**
- Call this script from another UR program or script.
- Pass in the `offset_vector` variable before calling.
- The script will move the robot to the offset position relative to the current TCP.

---

### 2. `feature_offset.script`

**Purpose:**  
Moves the robot relative to a defined feature(often called user frame) coordinate system using a passed-in pose and offset.

**Inputs:**
- `feature_pose`: A `pose` representing the origin of the feature frame.
- `offset_vector`: A `pose` or translation to apply within the feature frame.

**Usage:**
- Define `feature_pose` and `offset_vector` in your main program or script.
- Call this script after setting those variables.
- The robot will move to the `feature_pose + offset_vector` position, computed with frame transformation.

---

### 3. `world_rel_to_feature_offs.script`

**Purpose:**  
Computes a position in the world frame based on an offset relative to a feature. This allows precise transformation between frames.

**Inputs:**
- `feature_pose`: The base pose of the feature in world coordinates.
- `offset_vector`: The desired offset in the feature’s local frame.

**Usage:**
- Set `feature_pose` and `offset_vector` before calling the script.
- The robot will compute the equivalent world position and move there.

---

## How to Use

1. Load these scripts onto the UR controller.
2. In your main URScript or URCap logic:
    - Define the input variables (`feature_pose`, `offset_vector`, etc.).
    - Use the `run` or `global` statement to execute the desired script.
3. These scripts handle the math and movement using the provided values — no internal edits are necessary.

> 💡 **Example:**
> ```ur
> feature_pose = p[0.5, 0.2, 0.1, 0, 0, 0]
> offset_vector = p[0.0, 0.0, 0.05, 0, 0, 0]
> run feature_offset.script
> ```

---

## Notes

- These scripts are designed for **modular integration** — useful for any program needing relative motion in tool, feature, or world coordinates.
- You can call them multiple times with different variables to execute dynamic motion logic.
- Make sure your variables are defined with correct types (`pose`, `float`, etc.) before execution.

> ⚠️ **Safety Reminder:** Always test offset movements in simulation or reduced-speed mode to prevent unexpected collisions.

---

## License

These examples are provided for instructional and prototyping use. Feel free to adapt them for your application.
