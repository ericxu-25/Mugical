#!/usr/bin/env bash
EXAMPLES_DIR="${1:-$(realpath $(dirname "$0")/../../examples)}"
TOTAL_EXAMPLES=2
EXAMPLE_STRING1="pymugic, a 3d Mugic device modeler"
EXAMPLE_STRING2="mugic-pypong, a 1-2 player Mugic compatible pong game"
EXAMPLES_STRING=""
echo "### MUGIC EXAMPLES ###"
for i in $(seq 1 $TOTAL_EXAMPLES); do
    TEMP=EXAMPLE_STRING"$i"
    EXAMPLES_STRING=${EXAMPLES_STRING}"Option $i - ${!TEMP}\n"
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
        # we have to install like this due to breaking changes with python3
        pip install pygame --pre && pip install oscpy && pip install PyOpenGL
        echo ; echo "<< Starting pymugic demo! >>"
        python pymugic.py
        echo "deactivating virtual environment"
        deactivate
    )
    ;;
    2) #mugic-pypong example
    (
        cd "${EXAMPLES_DIR}/mugic-pypong"
        python -m venv venv
        echo "starting virtual environment - this can take a while..."
        source venv/bin/activate
        pip install -r requirements.txt
        echo ; echo "<< Starting pypong demo! >>"
        python pypong.py
        echo "deactivating virtual environment"
        deactivate
    )
    ;;
    *)
        echo "example currently unimplemented..."
    ;;
esac

