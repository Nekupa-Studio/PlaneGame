## GameConfig is an autoload which stores all important config constants.
## You can modify both in-game parameters and debug parameters there.
## When you add something, be sure to documentate it, and if it's a 
## debug option, ensure your implementation will never ship it in prod builds.
extends Node

# --- GROUPS ---

const TARGETABLE_GROUP = "targetable"

# --- TOOL SPECIFIC ---

## Length of the direction indicator for FiringPoints
const FP_TOOL_RANGE = 20

## Should directions of FiringPoints show up in game ?
const FP_DEBUG_DIRECTION = false

# --- BULLETS --- 

## Z-index of bullets.
const BULLET_LAYER = -1

## Path to bullet scene
const BULLET_SCENE = preload("res://assets/scenes/bullet.tscn")

## Minimum damage a bullet should deal regardless of armor.
const MIN_DAMAGE = 1
