#!/usr/bin/env bash

xorriso -osirrox on -indev "$1" -extract / ${2:-isofiles}
