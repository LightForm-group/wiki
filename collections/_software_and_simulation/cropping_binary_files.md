---
title: Cropping Binary EBSD Files
author: Peter Crowther
tags:
  - Python
  - EBSD
published: true
---

# Cropping CRC files

A CRC file is a binary file which sotres EBSD data, it is a format used by Oxford Insturments and their software Channel 5. A binary file is not human readable like a text file but it is a very efficient way of storing data.

Because it is not a human readable format the files are hard to process without the Oxford software. This script allows cropping of a CRC file.

## The script

You need to set the input and output filenames, the number of pixels in the uncropped file (find this in the CPR metadata file assopciated with the CRC file) and the desired crop size.

```

# Script for cropping binary crc files. Remember to modify the cpr to reflect the 
# cropped number of pixels.

# Read in binary data
with open("../tests/data/testDataEBSD.crc", 'rb') as inputfile:
    data = inputfile.read()

# Set number of pixels
x_pixels = 359
y_pixels = 243

# Set desired crop size
min_x = 0
max_x = 24
min_y = 0
max_y = 24

# Work out how to bin the binary data
total_pixels = x_pixels * y_pixels
line_length = int(len(data) / total_pixels)

# Convert the data from binary to integers
int_data = [int(i) for i in data]

# Bin the integers into pixels and their x and y positions
subset_int_data = []
for index, point in enumerate(int_data):
    pixel_num = index // line_length
    x = pixel_num % x_pixels
    y = pixel_num // x_pixels
    # Select a subset of the 
    if x <= max_x and x >= min_x and y <= max_y and y >= min_y:
        subset_int_data.append(point)
        
#Write the subset back out to a new binary file
with open("out.txt", 'wb') as outputfile:
    for point in subset_int_data:
        outputfile.write(point.to_bytes(1, byteorder='big'))
        
print(f"{int(len(subset_int_data) / line_length)} pixels written to output file")

```

Remember to make a copy of the CPR metadata file with the updated number of pixels in the x and y dimensions or the file will not be readbale in the future.
