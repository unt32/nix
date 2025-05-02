for i in {1..10}; do
    SCREEN_VAR="SCREEN$i"
    SCREEN_VALUE="${!SCREEN_VAR}"

    if [[ -n "$SCREEN_VALUE" ]]; then
        eval "xrandr $SCREEN_VALUE"
        echo "xrandr $SCREEN_VALUE"
    else
	echo "isn't existing $SCREEN_VAR $SCREEN_VALUE"
        break
    fi
done
