# URScript Offset Examples

This repository contains three example URScript files that demonstrate how to apply position offsets using different reference frames in a Universal Robots program.

## Script Overview

### 1. `simple_offset.script`

**Description:**
This script demonstrates how to apply a basic position offset to the robot's current pose. It adds a fixed XYZ translation to the current TCP (Tool Center Point) position.

**Use Case:**
Ideal for simple movements where you need to shift the end-effector in a specific direction, such as picking an object at a known offset.

**How to Use:**
- Load the script into the UR controller or paste into a Program node.
- Modify the `pose_trans` offset vector as needed.
- Run the program to see the tool move to the offset position.

---

### 2. `feature_offset.script`

**Description:**
This script applies an offset relative to a predefined feature or coordinate system (e.g., a fixture or part location defined in the UR Polyscope feature list).

**Use Case:**
Useful for consistent movements relative to a workpiece, regardless of the robot’s base or tool orientation.

**How to Use:**
- Define a feature frame in the UR teach pendant.
- Edit the script to reference the feature’s pose.
- The tool will move relative to that feature plus the specified offset.

---

### 3. `world_rel_to_feature_offs.script`

**Description:**
This advanced script computes an offset in the world coordinate system, relative to a feature. It transforms the target location from one reference frame to another.

**Use Case:**
Ideal when performing tasks that require precise spatial relationships between objects in different frames (e.g., aligning to a feature in the world space).

**How to Use:**
- Ensure both the feature frame and world pose are properly defined.
- The script calculates the transformation using `pose_trans` and inverse kinematics.
- Run the script to move the robot based on this transformed pose.

---

## Getting Started

1. Copy the desired `.script` file to a USB drive or send it to the UR controller via FTP.
2. Open the file in Polyscope via the "Script" node or insert the code into a URCap if integrating with other program logic.
3. Adjust the poses and offset values in the script to match your application.
4. Run the program and observe the toolpath.

> ⚠️ **Safety Notice:** Always run scripts in simulation mode first to verify the path before executing on a live robot.

---

## License

This project is provided for educational and instructional use. Modify freely for your application needs.
