if [[ -n "$SCREEN" ]]; then
        eval "xrandr $SCREEN"
        echo "xrandr $SCREEN"
else
        echo "isn't existing $SCREEN"
fi
