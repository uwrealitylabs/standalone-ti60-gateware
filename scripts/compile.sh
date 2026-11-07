#!/usr/bin/env bash

EFINITY_INSTALL_DIR="${EFINITY_INSTALL_DIR:-/opt/efinity/2025.2}"
PROJECT_XML="${1:-my_project.xml}"
FLOW_STEP="${2:-compile}"         
OUTPUT_DIR="outflow"
PROGRAM_BOARD="${PROGRAM_BOARD:-0}"

SETUP_SCRIPT="${EFINITY_INSTALL_DIR}/bin/setup.sh"

if [[ ! -f "$SETUP_SCRIPT" ]]; then
    echo "[ERROR] Efinity setup.sh not found at: $SETUP_SCRIPT"
    echo "        Update EFINITY_INSTALL_DIR in the script or export it in your shell."
    exit 1
fi

echo "[INFO] Sourcing Efinity environment from: $SETUP_SCRIPT"
source "$SETUP_SCRIPT"

echo "[INFO] EFINITY_HOME is set to: $EFINITY_HOME"
echo "[INFO] Using efx_run.py at: $(which efx_run.py)"

if [[ ! -f "$PROJECT_XML" ]]; then
    echo "[ERROR] Project XML file not found: $PROJECT_XML"
    exit 1
fi

echo "[INFO] Starting Efinity flow '${FLOW_STEP}' for project '${PROJECT_XML}'..."
efx_run.py "$PROJECT_XML" \
    --flow "$FLOW_STEP" \
    --output_dir "$OUTPUT_DIR"


PROJECT_NAME=$(basename "$PROJECT_XML" .xml)
TIMING_RPT="${OUTPUT_DIR}/${PROJECT_NAME}.timing.rpt"
BITSTREAM_HEX="${OUTPUT_DIR}/${PROJECT_NAME}.hex"
BITSTREAM_BIT="${OUTPUT_DIR}/${PROJECT_NAME}.bit"


if [[ -f "$TIMING_RPT" ]]; then
    echo "[INFO] Timing Summary excerpts:"
    grep -E "Slack| Frequency|Failed" "$TIMING_RPT" | head -n 15 || true
fi

if [[ -f "$BITSTREAM_BIT" || -f "$BITSTREAM_HEX" ]]; then
    echo "[SUCCESS] Build complete. Bitstream files generated in ./${OUTPUT_DIR}/"
else
    echo "[INFO] Flow '${FLOW_STEP}' finished (no bitstream expected or generated)."
fi
