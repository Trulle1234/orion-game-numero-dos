extends Node2D

var player_speed = 200
var strength = 1
var coins = 0
var cannons = 1

var shoot_cooldown = 0.15
var shoot_timer = shoot_cooldown

const damage_cooldown = 0.3
var damage_timer = 0

var enemy_spawn_radius = 1150
var enemy_speed = 120

var game_state = "init_first_wave"
var wave = 0
