#!/usr/bin/env bash


# Set environment --------------------------------------------------------------

# Define user variables -----

script_title="Fedora Bootstrap"
ansible_repository="https://github.com/mellolucas/bootstrap-fedora"
ansible_playbook="site.yml"

# Aesthetic Functions -----
aes_draw="\e[1;5;24;38;5;212;48;5;60m"
aes_title="\e[1;24;25;38;5;183;48;5;60m"
aes_link="\e[4;38;5;159m"
aes_text="\e[22;24;25;38;5;120;48;5;59m"
aes_strong="\e[1;24;38;5;231m"
aes_reset="\e[0m"
clear_screen="\e[J"
clear_line="\e[K"
print_section() {
  input=${@}
  input_length=${#input}
  let "tput_cols=$(tput cols)-2"
  let "sep_n=${tput_cols}-2-${input_length}"
  let "lsep_n=$sep_n/2"
  let "rsep_n=$sep_n/2+$sep_n%2"
  sep=$(eval printf -- '-%.0s' {1..${tput_cols}})
  lsep=$(eval printf -- '-%.0s' {1..${lsep_n}})
  rsep=$(eval printf -- '-%.0s' {1..${rsep_n}})
  echo -e "${aes_draw}#${sep}#${clear_line}"
  echo -en "${aes_draw}#${lsep} ${aes_title}"
  echo -n "$@"
  echo -e " ${aes_draw}${rsep}#${clear_line}"
  echo -e "${aes_draw}#${sep}#${clear_line}"
}
print_text() {
  echo -e "${aes_text}$1${clear_line}"
  sleep 1
}
print_strong() {
  echo -e "${aes_strong}$1${aes_text}${clear_line}"
  sleep 1
}
print_step() {
  echo -e "${aes_text}$1\e[5m ... ${aes_text}${clear_line}"
  sleep 1
}
print_link() {
  echo -e "  ${aes_link}$1${aes_text}${clear_line}"
  sleep 1
}
color_line() {
  echo -en "${aes_text}${clear_line}"
}
screen_paint() {
  echo -en "${aes_text}${clear_screen}"
}
screen_reset() {
  echo -en "${aes_reset}${clear_line}"
}

# Start ------------------------------------------------------------------------
echo
echo
echo
echo
screen_paint 
print_section "Starting ${script_title} Script"
color_line
echo

# Code -----
print_strong "\e[38;5;103m
 ———————————————————————
|\e[38;5;229m Automate everything! \e[38;5;103m|
|\e[38;5;222m   This is the way    \e[38;5;103m|
 ———————————————————————
 \e[38;5;229m  \
    \     \e[38;5;210m.\e[38;5;229m
     .---.  \e[38;5;210m//\e[38;5;229m
    Y|o o|Y\e[38;5;210m//\e[38;5;229m 
   /_(i=i)K\e[38;5;210m/\e[38;5;229m 
   ~()~*~()~  
    (_)-(_)   
"
echo
print_text "This script will install use a remote ansible playbook to perform a"
print_text "complete post-installation setup on your Fedora operating system."
echo
print_text "You can find more information at:"
print_link "https://lufom.com/ln/fedora"
echo
sleep 4
print_strong "\e[38;5;103m
 ————————————————————————————
|\e[38;5;210m Take your powers, we must! \e[38;5;103m|
 ————————————————————————————
 \e[38;5;183m       \\    ,-^-.
         \\   !\e[38;5;210mo\e[38;5;183mY\e[38;5;210mo\e[38;5;183m!___
            /./=\\.\\  )\\
                ||--|| °
"
echo
print_text "You will soon be asked to enter the password for $USER"
echo
tput bel
read -p "Press [Enter] to continue..."
print_text "Starting full local Fedora setup"
sleep 1
print_step "Installing/Updating Ansible"
echo
sudo dnf install -y ansible 1>/dev/null
echo 
print_step "Pulling ansible script"
echo
ansible-pull ansible-pull -U ${ansible_repository} ${ansible_playbook} --skip-tags "round2"
echo

# End --------------------------------------------------------------------------
echo
print_section "/Finished ${script_title} Script"
screen_reset
echo -e "\e[50B"
echo
echo
