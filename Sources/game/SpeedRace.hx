package game;

import game.groups.*;
import game.sprites.*;
import game.tools.*;
import game.tools.ui.*;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Key;
import kha.Scaler;
import kha.Scheduler;
import kha.System;
import kha.input.Keyboard;
import kha.math.Random;

class SpeedRace {
	public static inline var HEIGHT : Int = 320;
	public static inline var WIDTH : Int = 240;
	
	static inline var maxCars : Int = 3;
	static inline var velocityMax : Float = 6;
	static inline var velocityStep : Float = 2;
	
	var backbuffer : Image;
	var cars : Pool<NpcCar>;
	var instructions : Text;
	var isRunning : Bool;
	var player : PlayerCar;
	var road : Road;
	var score : Float;
	var scoreText : Text;
	var velocity : Float;
	
	public function new() {
		Random.init(160619);
		
		if (Keyboard.get() != null) Keyboard.get().notify(onKeyDown, onKeyUp);
		
		isRunning = false;
		velocity = 0;
		
		backbuffer = Image.createRenderTarget(WIDTH, HEIGHT);
		
		player = new PlayerCar(Assets.images.car_big);
		player.setCenterPosition(WIDTH / 2, HEIGHT * 2 / 3);
		
		cars = new Pool<NpcCar>(10);
		for (i in 0...10) {
			cars.add(new NpcCar(0, 0, Assets.images.car_small)).kill();
		}
		
		road = new Road(20, Assets.images.road_segment);
		
		Car.X_MIN = 20;
		Car.X_MAX = SpeedRace.WIDTH - 20;
		
		score = 0;
		scoreText = new Text(Assets.fonts.slkscr, 64);
		
		instructions = new Text(Assets.fonts.slkscr, 10);
		instructions.value = "W - SPEED UP / RESTART. S - SPEED DOWN. A - LEFT. D - RIGHT.";
		instructions.setCenterPosition(System.windowWidth() / 2, System.windowHeight() - instructions.height);
		
		Scheduler.addTimeTask(spawnCar, 0, 1);
	}

	public function update() : Void {
		cars.update();
		road.update();
			
		if (isRunning) {
			player.update();
			
			score += velocity / velocityMax / 10;
			
			scoreText.value = Std.string(Math.floor(score));
			scoreText.setCenterPosition(System.windowWidth() / 2, System.windowHeight() - scoreText.height);
			
			cars.each(handleCollision);
		}
	}

	public function render(framebuffer: Framebuffer) : Void {
		var g = backbuffer.g2;
		g.begin(Color.fromValue(0xff00cc99));
		
		road.draw(g);
		player.draw(g);
		cars.draw(g);
		
		g.end();
		
		framebuffer.g2.begin(Color.Blue);
		
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		
		framebuffer.g2.transformation = kha.math.FastMatrix3.identity();
		scoreText.draw(framebuffer.g2);
		instructions.draw(framebuffer.g2);
		
		framebuffer.g2.end();	
	}
	
	private function updateVelocity(step : Float) : Void {
		velocity += step;
		
		if (velocity < velocityStep && isRunning) {
			velocity = velocityStep;
		}
		
		if (velocity < 0) {
			velocity = 0;
		}
		
		if (velocity > velocityMax) {
			velocity = velocityMax;
		}
		
		road.updateVelocity(velocity);
		cars.each(function (c : NpcCar) { c.updateVelocity(velocity, velocityMax, velocityStep); });
	}
	
	private function spawnCar() : Void {
		if (isRunning) {
			for (i in 0...(Random.Default.GetIn(1, maxCars))) {
				var c : NpcCar = cars.getFirstDead();
				if (c != null) {
					c.revive();
					c.init(velocity, velocityMax, velocityStep);
				}
			}
		}
	}
	
	private function handleCollision(c : NpcCar) : Void {
		if (c.isActive && c.isVisible) {
			if (c.overlapsEntity(player)) {
				stopGame();
			}
		}
	}
	
	private function startGame() : Void {
		isRunning = true;
		score = 0;
	}
	
	private function stopGame() : Void {
		isRunning = false;
		updateVelocity(-velocityMax);
	}
	
	private function onKeyDown(key : Key, char : String) : Void {
		switch (char) {
			case "w":
				if (!isRunning) startGame();
				updateVelocity(velocityStep);
			case "s": updateVelocity(-velocityStep);
			case "a": player.updateMovement(velocity, -1);
			case "d": player.updateMovement(velocity, 1);
			case "x": isRunning = true;
		}
	}
	
	private function onKeyUp(key : Key, char : String) : Void {
		switch (char) {
			case "a": player.updateMovement(0, -1);
			case "d": player.updateMovement(0, 1);
		}
	}
}
