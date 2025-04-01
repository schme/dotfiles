#!/usr/bin/env python3

import subprocess
import re


def create_name_from_word_list(device_list_words: list) -> str:
    # Assume everything before the word 'id' is the name
    if "id:" in device_list_words:
        id_index = device_list_words.index("id:")
        result = " ".join(device_list_words[:id_index])
        print("Device name: {}".format(result))
        return result
    return None


def get_wacom_device(device_type: str ="STYLUS"):
    """
    Finds the Wacom device with the specified type (e.g., "Pad").
    """
    try:
        output = subprocess.check_output(["xsetwacom", "list", "devices"], text=True)
        for line in output.splitlines():
            if device_type in line:
                words = line.split()
                match = device_type in words
                if match:
                    return create_name_from_word_list(words)
    except subprocess.CalledProcessError as e:
        print(f"Error finding Wacom device: {e}")
    return None

def get_monitor_resolution():
    """
    Gets the current monitor resolution using xrandr.
    Returns (width, height) as integers.
    """
    try:
        output = subprocess.check_output(["xrandr"], text=True)
        for line in output.splitlines():
            active_mode = False
            for word in line.split():
                if "*" in word:
                    active_mode = True
                    break
            if not active_mode:
                continue
            words = line.split()
            # Assume first is the resolution
            res = (words[0].split("x"))
            return (int(res[0]), int(res[1]))

    except subprocess.CalledProcessError as e:
        print(f"Error getting monitor resolution: {e}")
    return None, None

def calculate_centered_area(monitor_width, monitor_height, tablet_aspect_ratio=(16, 9)):
    """
    Calculates the centered area on the monitor that matches the tablet's aspect ratio.
    Returns (width, height, x_offset, y_offset).
    """
    tablet_width_ratio, tablet_height_ratio = tablet_aspect_ratio
    # Calculate the target height and width based on the aspect ratio
    target_width = monitor_width
    target_height = int(monitor_width * tablet_height_ratio / tablet_width_ratio)

    if target_height > monitor_height:
        # If the height exceeds the monitor, scale down based on height
        target_height = monitor_height
        target_width = int(monitor_height * tablet_width_ratio / tablet_height_ratio)

    # Calculate offsets to center the area
    x_offset = (monitor_width - target_width) // 2
    y_offset = (monitor_height - target_height) // 2

    return target_width, target_height, x_offset, y_offset

def map_tablet_to_area(device_name, width, height, x_offset, y_offset):
    """
    Maps the tablet to the specified area using xsetwacom.
    """
    area = f"{width}x{height}+{x_offset}+{y_offset}"
    try:
        subprocess.run(["xsetwacom", "set", device_name, "MapToOutput", area], check=True)
        print(f"Mapped '{device_name}' to area: {area}")
    except subprocess.CalledProcessError as e:
        print(f"Error mapping tablet: {e}")

def main():
    # Step 1: Find the Wacom device with type "Pad"
    device_name = get_wacom_device("STYLUS")
    if not device_name:
        print("No Wacom device with type 'Pad' found.")
        return

    # Step 2: Get the monitor resolution
    monitor_width, monitor_height = get_monitor_resolution()
    if not monitor_width or not monitor_height:
        print("Unable to determine monitor resolution.")
        return

    # Step 3: Assume a 16:9 aspect ratio for the tablet and calculate the centered area
    tablet_aspect_ratio = (16, 9)
    target_width, target_height, x_offset, y_offset = calculate_centered_area(
        monitor_width, monitor_height, tablet_aspect_ratio
    )

    # Step 4: Map the tablet to the calculated area
    map_tablet_to_area(device_name, target_width, target_height, x_offset, y_offset)

if __name__ == "__main__":
    main()
