#!/bin/bash

# Print ASCII banner for the bash script
function print_banner() {
    echo "======================================"
    echo "   BANNER-GRABBER Advanced Bash"
    echo "======================================"
}

# Function to check if dependencies are installed
function check_dependencies() {
    # Check for Python3 and Nikto
    for cmd in python3 nikto; do
        if ! command -v $cmd &> /dev/null; then
            echo "Error: $cmd is not installed." >&2
            exit 1
        fi
    done
}

# Function to print help
function print_help() {
    echo "Usage: $0 [-t target_ip] [-s specific_ports] [-r start_port-end_port] [-o output_file] [-h]"
    echo
    echo "Options:"
    echo "  -t    Target IP address (required)"
    echo "  -s    Specific ports (comma-separated)"
    echo "  -r    Port range (e.g., 1-1024)"
    echo "  -o    Output file for Nikto results (optional)"
    echo "  -h    Display this help message"
    echo
    echo "Example:"
    echo "  $0 -t 192.168.1.1 -s 22,80,443 -o nikto_results.txt"
    echo "  $0 -t 192.168.1.1 -r 1-1024"
}

# Parsing command-line arguments
target_ip=""
specific_ports=""
start_port=0
end_port=0
output_file=""

while getopts ":t:s:r:o:h" opt; do
    case ${opt} in
        t )
            target_ip=$OPTARG
            ;;
        s )
            specific_ports=$OPTARG
            ;;
        r )
            IFS="-" read start_port end_port <<< "$OPTARG"
            ;;
        o )
            output_file=$OPTARG
            ;;
        h )
            print_help
            exit 0
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            print_help
            exit 1
            ;;
        : )
            echo "Option -$OPTARG requires an argument." >&2
            print_help
            exit 1
            ;;
    esac
done

# Check if target IP is provided
if [ -z "$target_ip" ]; then
    echo "Error: Target IP address is required."
    print_help
    exit 1
fi

# Check for dependencies
check_dependencies

# Print the banner
print_banner

# Run the Python script with appropriate options
if [ -n "$specific_ports" ]; then
    echo "Scanning specific ports: $specific_ports"
    python3 banner_grabber.py --target "$target_ip" --specific "$specific_ports" ${output_file:+--output "$output_file"}
elif [ $start_port -ne 0 ] && [ $end_port -ne 0 ]; then
    echo "Scanning ports in range: $start_port-$end_port"
    python3 banner_grabber.py --target "$target_ip" --range "$start_port" "$end_port" ${output_file:+--output "$output_file"}
else
    echo "Scanning default port range (1-1024)"
    python3 banner_grabber.py --target "$target_ip" ${output_file:+--output "$output_file"}
fi

# Run Nikto scan
echo "Running Nikto scan..."
if [ -n "$output_file" ]; then
    python3 banner_grabber.py --target "$target_ip" --run-nikto --output "$output_file"
else
    python3 banner_grabber.py --target "$target_ip" --run-nikto
fi
