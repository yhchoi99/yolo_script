#
# Usage: python3 cal_inf.py <data_file_name>
#

import argparse
import re
import statistics

def calculate_statistics(data_file):
    values = []

    with open(data_file, 'r') as file:
        for line in file:
            # e.g. "image 1/100 123.45ms"
            # extract time value
            # e.g. 123.45
            match = re.search(r'(\d+\.\d+)ms', line)
            if match:
                values.append(float(match.group(1)))

    if values:
        average = statistics.mean(values)
        standard_deviation = statistics.stdev(values)
        print(f"Mean: {average:.3f} ms")
        print(f"STD: {standard_deviation:.3f} ms")

    else:
        print("No valid data found.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Calculate statistics for inference time")
    parser.add_argument("data_file", help="Name of the data file")
    args = parser.parse_args()

    calculate_statistics(args.data_file)
