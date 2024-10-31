#!/bin/bash
# startup.sh for Retroactyl Java Minecraft Server

# Load variables from the panel environment
SERVER_SOFTWARE="${SERVER_SOFTWARE:-paper}"       # Default to Paper if not specified
MINECRAFT_VERSION="${MINECRAFT_VERSION:-latest}"  # Default to latest if not specified
SERVER_JARFILE="${SERVER_JARFILE:-server.jar}"    # Default jar file name

# Define default startup commands for each server type
case "$SERVER_SOFTWARE" in
  paper)
    STARTUP_COMMAND="java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar $SERVER_JARFILE"
    ;;
  pufferfish)
    STARTUP_COMMAND="java -Xms4096M -Xmx4096M -Dterminal.jline=false -Dterminal.ansi=true -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar $SERVER_JARFILE nogui"
    ;;
  purpur)
    STARTUP_COMMAND="java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar $SERVER_JARFILE"
    ;;
  forge)
    STARTUP_COMMAND="java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar $SERVER_JARFILE nogui"
    ;;
  vanilla)
    STARTUP_COMMAND="java -Xms128M -XX:MaxRAMPercentage=95.0 -jar $SERVER_JARFILE nogui"
    ;;
  *)
    echo "Unknown server software. Defaulting to Paper."
    STARTUP_COMMAND="java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar $SERVER_JARFILE"
    ;;
esac

# Move to the server directory
SERVER_DIR="/mnt/server"
cd "$SERVER_DIR" || exit 1

# Display startup message
echo "Starting Minecraft Server with the following configuration:"
echo "Server Software: $SERVER_SOFTWARE"
echo "Minecraft Version: $MINECRAFT_VERSION"
echo "Server JAR File: $SERVER_JARFILE"
echo "Startup Command: $STARTUP_COMMAND"

# Run the server with the chosen startup command
exec $STARTUP_COMMAND
