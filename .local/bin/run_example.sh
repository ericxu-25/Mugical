#!/usr/bin/env bash
EXAMPLES_DIR="${1:-$(realpath $(dirname "$0")/../../examples)}"
TOTAL_EXAMPLES=1
EXAMPLE_STRING1="pymugic, a 3d Mugic device modeler"
EXAMPLES_STRING=""
echo "### MUGIC EXAMPLES ###"
for i in $(seq 1 $TOTAL_EXAMPLES); do
    TEMP=EXAMPLE_STRING"$i"
    EXAMPLES_STRING=${EXAMPLES_STRING}"Option $i - ${!TEMP}"
done
echo -e "${EXAMPLES_STRING}"
read -p 'Select an example to run from the list above [1-'${TOTAL_EXAMPLES}']: ' \
     -N 1 -r EXAMPLE
echo ;
if ! [[ "$EXAMPLE" -le "$TOTAL_EXAMPLES" && "$EXAMPLE" -gt 0 ]]; then
    echo "selected an invalid example: ${EXAMPLE}"
    echo "selection must be a number between 1 and ${TOTAL_EXAMPLES}"
    exit 1
fi
TEMP=EXAMPLE_STRING"${EXAMPLE}"
echo "selected example no.${EXAMPLE} - ${!TEMP}"
case $EXAMPLE in
    1) #pymugic example
    (
        cd "${EXAMPLES_DIR}/pymugic"
        python -m venv venv
        echo "starting virtual environment - this can take a while..."
        source venv/bin/activate
        pip install pygame --pre && pip install oscpy && pip install PyOpenGL
        echo ; echo "<< Starting pymugic demo! >>"
        python pymugic.py
        echo "deactivating virtual environment"
        deactivate
    )
    ;;
    *)
        echo "example currently unimplemented..."
    ;;
esac

