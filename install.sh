#!/bin/bash
#=============================================================================
#  RJD Wifi Solutions - PisoWiFi Management System Installer v1.0
#  Powered by RJD PISOWIFI v3.6.0
#
#  One command setup for Raspberry Pi, Orange Pi, and x86_64 PC.
#  License server pre-configured — just activate your license key.
#
#  Usage:
#    curl -sSL https://bit.ly/YOUR_LINK | sudo bash
#
#  Hardware Support:
#    - Raspberry Pi (all models)
#    - Orange Pi (Zero 3, 5, PC, One, 3 LTS)
#    - x86_64 PC (Ubuntu/Debian)
#=============================================================================

set -e

#=============================================================================
#  BRANDING & CONFIGURATION — EDIT THESE VALUES
#=============================================================================

# Your company information (displayed during installation)
COMPANY_NAME="RJD Wifi Solutions"
COMPANY_WEBSITE="https://wifi.rjdtech.shop"
COMPANY_SUPPORT_EMAIL="admin@rjdtech.shop"
COMPANY_SUPPORT_PHONE="+63948-678-1331"

# Your Supabase license server credentials
SUPABASE_URL="https://tnztavqzkclpfywkfrcd.supabase.co"
SUPABASE_ANON_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRuenRhdnF6a2NscGZ5d2tmcmNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE0NjY5OTksImV4cCI6MjA5NzA0Mjk5OX0.nIH4eDjUnu_ctzStrZC7N8BRlZnTUjDhBQ1I1mA89mg"

# License server URL (optional — for future auto-activation)
LICENSE_SERVER_URL="https://rjdtech.shop/api/license"

# System branding
SYSTEM_NAME="RJD PisoWiFi"
SYSTEM_VERSION="1.0.0"
INSTALL_DIR="/opt/rjd-pisowifi"

# GitHub repo (fork this to your own account for full control)
REPO_URL="https://github.com/syntaxcasino/RJD-PISOWIFI-Management-System.git"

#=============================================================================
#  COLOR CODES
#=============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

#=============================================================================
#  FUNCTIONS
#=============================================================================

print_banner() {
    clear
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║${WHITE}          ${BOLD}$SYSTEM_NAME${NC}${WHITE}                ${BLUE}║${NC}"
    echo -e "${BLUE}║${WHITE}          Automated Installation Script         ${BLUE}║${NC}"
    echo -e "${BLUE}╠══════════════════════════════════════════════════════╣${NC}"
    echo -e "${BLUE}║${NC}  Version:    ${GREEN}$SYSTEM_VERSION${NC}                          ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}  License:    Pre-configured for instant setup     ${BLUE}║${NC}"
    echo -e "${BLUE}║${NC}  Support:    ${CYAN}$COMPANY_SUPPORT_EMAIL${NC}         ${BLUE}║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

print_step() {
    echo ""
    echo -e "${BLUE}[${GREEN}$1${BLUE}/${CYAN}8${BLUE}]${NC} ${WHITE}$2${NC}"
    echo -e "${BLUE}──────────────────────────────────────────────${NC}"
}

print_success() {
    echo -e "  ${GREEN}✅${NC} $1"
}

print_info() {
    echo -e "  ${CYAN}ℹ️${NC}  $1"
}

print_warning() {
    echo -e "  ${YELLOW}⚠️${NC}  $1"
}

print_error() {
    echo -e "  ${RED}❌${NC} $1"
}

print_footer() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║${WHITE}          ✅  INSTALLATION COMPLETE!            ${GREEN}║${NC}"
    echo -e "${GREEN}╠══════════════════════════════════════════════════════╣${NC}"
    echo -e "${GREEN}║${NC}                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD}Admin Dashboard:${NC}                                          ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${CYAN}http://$1/admin${NC}                             ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD}Default Login:${NC}                                           ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  Username: ${YELLOW}admin${NC}                                           ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  Password: ${YELLOW}admin${NC}                                           ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD}⚠️  CHANGE YOUR PASSWORD IMMEDIATELY!${NC}                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD}Next Steps:${NC}                                               ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  1. Open the Admin Dashboard above                     ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  2. Go to ${YELLOW}System Settings → License${NC}                ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  3. Enter your license key to unlock full features      ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  4. Go to ${YELLOW}Hardware Manager${NC} to configure your coin slot    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  ${BOLD}Need Help?${NC}                                               ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  Email: ${CYAN}$COMPANY_SUPPORT_EMAIL${NC}                  ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}  Phone: ${CYAN}$COMPANY_SUPPORT_PHONE${NC}                       ${GREEN}║${NC}"
    echo -e "${GREEN}║${NC}                                                    ${GREEN}║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

#=============================================================================
#  MAIN INSTALLATION
#=============================================================================

# Show banner
print_banner

#-------------------------------------------------------------------------
#  CHECK ROOT
#-------------------------------------------------------------------------
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}❌ Please run as root (use sudo)${NC}"
    echo ""
    echo -e "  ${YELLOW}Correct command:${NC}"
    echo -e "  ${CYAN}curl -sSL https://bit.ly/3Qh0y80 | sudo bash${NC}"
    echo ""
    exit 1
fi

#-------------------------------------------------------------------------
#  STEP 1/8 — Hardware Detection
#-------------------------------------------------------------------------
print_step "1" "Detecting Hardware Architecture"

ARCH=$(uname -m)
BOARD="generic"
BOARD_FRIENDLY="Generic Device"

if grep -q "Raspberry Pi" /proc/device-tree/model 2>/dev/null; then
    BOARD="raspberry_pi"
    MODEL=$(tr -d '\0' < /proc/device-tree/model)
    BOARD_FRIENDLY="$MODEL"
    print_success "Detected: ${CYAN}Raspberry Pi${NC} — ${WHITE}$MODEL${NC}"
elif [ -f /etc/armbian-release ] || grep -q "Orange Pi\|sunxi\|rockchip" /proc/cpuinfo 2>/dev/null; then
    BOARD="orange_pi"
    # Try to get the actual model name
    if [ -f /proc/device-tree/model ]; then
        MODEL=$(tr -d '\0' < /proc/device-tree/model 2>/dev/null || echo "Orange Pi")
    else
        MODEL="Orange Pi"
    fi
    BOARD_FRIENDLY="$MODEL"
    print_success "Detected: ${CYAN}Orange Pi${NC} — ${WHITE}$MODEL${NC}"
elif [[ "$ARCH" == "x86_64" ]]; then
    BOARD="x64_pc"
    BOARD_FRIENDLY="x86_64 PC ($(grep -m1 'model name' /proc/cpuinfo | cut -d':' -f2 | xargs | cut -d' ' -f1-3))"
    print_success "Detected: ${CYAN}x86_64 PC${NC} — ${WHITE}$BOARD_FRIENDLY${NC}"
elif [[ "$ARCH" == "aarch64" ]]; then
    BOARD="arm64"
    BOARD_FRIENDLY="ARM64 Device"
    print_success "Detected: ${CYAN}ARM64${NC} — ${WHITE}$ARCH${NC}"
else
    print_warning "Unknown hardware: ${YELLOW}$ARCH${NC}. Proceeding with generic installation."
fi

MEMORY_MB=$(free -m | awk '/^Mem:/{print $2}')
print_info "Memory: ${WHITE}${MEMORY_MB}MB${NC} RAM"
print_info "Storage: ${WHITE}$(df -h / | awk 'NR==2 {print $2}')${NC} available"

#-------------------------------------------------------------------------
#  STEP 2/8 — System Update
#-------------------------------------------------------------------------
print_step "2" "Updating System Repositories"

echo -e "  ${YELLOW}Cleaning apt cache...${NC}"
apt-get clean -qq 2>/dev/null || true
rm -rf /var/lib/apt/lists/* 2>/dev/null || true

echo -e "  ${YELLOW}Updating package lists...${NC}"
apt-get update -qq 2>/dev/null || apt-get update

print_success "System repositories updated"

#-------------------------------------------------------------------------
#  STEP 3/8 — Installing System Dependencies
#-------------------------------------------------------------------------
print_step "3" "Installing System Dependencies"

echo -e "  ${YELLOW}Installing core packages...${NC}"
apt-get install -y -qq \
    git curl wget \
    sqlite3 iptables bridge-utils \
    hostapd dnsmasq \
    build-essential \
    python3 python3-dev python3-pip \
    ufw 2>/dev/null || apt-get install -y \
    git curl wget sqlite3 iptables bridge-utils \
    hostapd dnsmasq build-essential python3 python3-dev python3-pip ufw

# Install esptool for NodeMCU
echo -e "  ${YELLOW}Installing ESP flashing tool...${NC}"
if apt-get install -y -qq esptool 2>/dev/null; then
    print_success "esptool installed"
elif apt-get install -y -qq python3-esptool 2>/dev/null; then
    print_success "python3-esptool installed"
else
    python3 -m pip install --quiet esptool 2>/dev/null || true
    print_info "esptool installed via pip"
fi

print_success "System dependencies installed"

#-------------------------------------------------------------------------
#  STEP 4/8 — Installing Node.js
#-------------------------------------------------------------------------
print_step "4" "Installing Node.js v20 (LTS)"

DEB_ARCH=$(dpkg --print-architecture 2>/dev/null || echo "")

if [[ "$DEB_ARCH" == "amd64" || "$DEB_ARCH" == "arm64" ]]; then
    if ! command -v node &> /dev/null || [[ $(node -v | cut -d'.' -f1) != "v20" ]]; then
        echo -e "  ${YELLOW}Installing Node.js 20 LTS from NodeSource...${NC}"
        curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
        apt-get install -y -qq nodejs
    else
        print_info "Node.js $(node -v) already installed"
    fi
else
    if ! command -v node &> /dev/null; then
        echo -e "  ${YELLOW}Installing Node.js from distro packages...${NC}"
        apt-get install -y -qq nodejs npm
    else
        print_info "Node.js $(node -v) already installed"
    fi
fi

# Install global tools
echo -e "  ${YELLOW}Installing PM2 and build tools...${NC}"
if [[ "$DEB_ARCH" == "amd64" || "$DEB_ARCH" == "arm64" ]]; then
    npm install -g npm@latest node-gyp pm2 --silent 2>/dev/null || \
    npm install -g node-gyp pm2 --silent
else
    npm install -g node-gyp@10 pm2 --silent
fi

print_success "Node.js $(node -v) + PM2 installed"

#-------------------------------------------------------------------------
#  STEP 5/8 — Preparing Project Directory
#-------------------------------------------------------------------------
print_step "5" "Preparing Project Directory"

if [ -d "$INSTALL_DIR" ]; then
    print_info "Directory already exists. Updating..."
    cd "$INSTALL_DIR"
    git fetch origin 2>/dev/null || true
else
    echo -e "  ${YELLOW}Cloning repository...${NC}"
    git clone --depth 1 "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

print_success "Project directory ready: ${CYAN}$INSTALL_DIR${NC}"

#-------------------------------------------------------------------------
#  ★ CRITICAL STEP — Inject License Configuration (.env)
#-------------------------------------------------------------------------
echo ""
echo -e "${MAGENTA}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║${WHITE}     🔑  CONFIGURING LICENSE SERVER           ${MAGENTA}║${NC}"
echo -e "${MAGENTA}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "  ${YELLOW}Writing license server credentials...${NC}"

cat > "$INSTALL_DIR/.env" << ENDENV
#=============================================================================
#  $SYSTEM_NAME — License & Environment Configuration
#  Provided by $COMPANY_NAME
#  Support: $COMPANY_SUPPORT_EMAIL
#=============================================================================

# Supabase License Server
# These credentials connect your system to the license verification server.
# Do NOT modify unless instructed by support.
SUPABASE_URL=$SUPABASE_URL
SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY

# System Configuration
NODE_ENV=production
PORT=80
ENDENV

print_success "License server configured: ${CYAN}$COMPANY_NAME${NC}"
print_info "Your system will verify licenses against our secure server"
print_info "No manual .env editing needed — ready to go!"

#-------------------------------------------------------------------------
#  STEP 6/8 — Building Application
#-------------------------------------------------------------------------
print_step "6" "Building Application"

echo -e "  ${YELLOW}Cleaning previous build...${NC}"
rm -rf node_modules package-lock.json dist 2>/dev/null || true

echo -e "  ${YELLOW}Installing Node.js dependencies...${NC}"
echo -e "  ${CYAN}(This may take 3-10 minutes on ARM devices)${NC}"
npm install --unsafe-perm --no-audit --no-fund --build-from-source 2>&1 | tail -5

echo -e "  ${YELLOW}Building frontend...${NC}"
npm run build 2>&1 | tail -3

print_success "Application built successfully"

#-------------------------------------------------------------------------
#  STEP 7/8 — Setting Up PM2 Persistence
#-------------------------------------------------------------------------
print_step "7" "Setting Up System Persistence (PM2)"

pm2 delete ajc-pisowifi 2>/dev/null || true
pm2 delete rjd-pisowifi 2>/dev/null || true
pm2 start server.js --name "rjd-pisowifi"
pm2 save

# Set up PM2 to start on boot
PM2_STARTUP=$(pm2 startup systemd -u root --hp /root 2>/dev/null | grep "sudo env" | head -1)
if [ -n "$PM2_STARTUP" ]; then
    eval "$PM2_STARTUP" 2>/dev/null || true
fi
pm2 save 2>/dev/null || true

print_success "PM2 configured — system auto-starts on boot"

#-------------------------------------------------------------------------
#  STEP 8/8 — Final Configuration
#-------------------------------------------------------------------------
print_step "8" "Final Configuration"

# Set kernel capabilities for port 80
if command -v setcap &> /dev/null; then
    NODE_PATH=$(readlink -f $(which node) 2>/dev/null || which node)
    setcap 'cap_net_bind_service,cap_net_admin,cap_net_raw+ep' "$NODE_PATH" 2>/dev/null || true
    print_success "Kernel capabilities set (port 80 access)"
fi

# Install WAN DHCP wait service (fixes boot timing issues)
if [ -f "scripts/rjd-wan-dhcp-wait.sh" ]; then
    chmod +x scripts/rjd-wan-dhcp-wait.sh
    if [ -f "scripts/rjd-wan-dhcp-wait.service" ]; then
        cp scripts/rjd-wan-dhcp-wait.service /etc/systemd/system/rjd-wan-dhcp-wait.service 2>/dev/null || true
        systemctl daemon-reload 2>/dev/null || true
        systemctl enable rjd-wan-dhcp-wait.service 2>/dev/null || true
        print_success "Boot recovery service installed"
    fi
fi

# Create a status check script for customers
cat > /usr/local/bin/pisowifi-status << 'STATUS'
#!/bin/bash
echo "═══════════════════════════════════════"
echo "  RJD PisoWiFi — System Status"
echo "═══════════════════════════════════════"
echo ""
pm2 status rjd-pisowifi 2>/dev/null || echo "❌ System not running"
echo ""
echo "Port 80: $(ss -tlnp | grep -q ':80 ' && echo '✅ Open' || echo '❌ Closed')"
echo "IP: $(hostname -I | awk '{print $1}')"
echo "Uptime: $(uptime -p)"
echo "RAM: $(free -h | awk '/^Mem:/{print $3 "/" $2}')"
echo "Temp: $(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null | awk '{printf "%.1f°C\n", $1/1000}' || echo 'N/A')"
echo ""
echo "Admin: http://$(hostname -I | awk '{print $1}')/admin"
echo "═══════════════════════════════════════"
STATUS
chmod +x /usr/local/bin/pisowifi-status

print_success "Status check command: ${CYAN}pisowifi-status${NC}"

#-------------------------------------------------------------------------
#  WAIT FOR SYSTEM TO START
#-------------------------------------------------------------------------
echo ""
echo -e "  ${YELLOW}Waiting for system to start...${NC}"
sleep 3

# Check if the system is running
if pm2 show rjd-pisowifi 2>/dev/null | grep -q "online"; then
    print_success "System is ${GREEN}RUNNING${NC}"
else
    print_warning "System may still be starting. Run: ${CYAN}pm2 logs rjd-pisowifi${NC}"
fi

#-------------------------------------------------------------------------
#  COMPLETE — Show Summary
#-------------------------------------------------------------------------

# Get IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')
if [ -z "$IP_ADDRESS" ]; then
    IP_ADDRESS="<your-device-ip>"
fi

print_footer "$IP_ADDRESS"

# Write a post-install note
cat > /root/pisowifi-readme.txt << README
═══════════════════════════════════════════════════════════════
  $SYSTEM_NAME — Post-Installation Notes
  Installed: $(date)
═══════════════════════════════════════════════════════════════

ADMIN DASHBOARD:
  http://$IP_ADDRESS/admin
  Username: admin
  Password: admin

LICENSE ACTIVATION:
  1. Open the Admin Dashboard
  2. Go to System Settings → License
  3. Enter your license key
  4. Click Activate

YOUR COIN SLOT:
  If you have a CH-926 coin slot:
  1. Wire: Signal → Pin 3, GND → Pin 6, 5V → Pin 2
  2. Go to Hardware Manager → Board Type → set your model
  3. Set Coin Pin: 3
  4. Click Save and test

MANAGEMENT COMMANDS:
  Status:    pisowifi-status
  Logs:      pm2 logs rjd-pisowifi
  Restart:   pm2 restart rjd-pisowifi
  Backup:    cp /opt/rjd-pisowifi/pisowifi.sqlite ~/backup.sqlite

SUPPORT:
  Email: $COMPANY_SUPPORT_EMAIL
  Phone: $COMPANY_SUPPORT_PHONE

Thank you for choosing $COMPANY_NAME!
═══════════════════════════════════════════════════════════════
README

echo -e "  ${CYAN}ℹ️  Post-install notes saved to: ${WHITE}/root/pisowifi-readme.txt${NC}"
echo ""
echo -e "${GREEN}✅ Installation complete! Thank you for choosing $COMPANY_NAME.${NC}"
echo ""
