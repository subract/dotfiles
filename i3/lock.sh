#!/bin/sh

# Using some catppuccin colors again!

BLANK='#24273a'
CLEAR='#ffffff22'
DEFAULT='#b7bdf8'
TEXT='#cad3f5'
SUBTEXT='#b8c0e0'
KEYS='#a6da95'
WRONG='#ee99a0'
VERIFYING='#c6a0f6'

i3lock-fancy-rapid 150 20 \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$SUBTEXT           \
--layout-color=$TEXT         \
--keyhl-color=$KEYS         \
--bshl-color=$KEYS          \
\
--screen 1                   \
--clock                      \
--indicator                  \
--time-str="%H:%M"           \
--date-str="%A %y%m%d"     \
