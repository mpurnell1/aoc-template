#!/usr/bin/env python3
import sys

if __name__ == '__main__':

    if len(sys.argv) > 1:
        arg = sys.argv[1]
    else:
        arg = None

    if arg == 'sample':
        input_file = 'day_x_sample_input.txt'
    elif arg == 'input':
        input_file = 'day_x_input.txt'
    else:
        input_file = 'day_x_sample_input.txt'
        # input_file = 'day_x_input.txt'

    with open(input_file, 'r') as f:
        lines = map(str.strip, f.readlines())
