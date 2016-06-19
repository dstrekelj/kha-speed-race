package game;

import game.groups.*;
import game.sprites.*;
import game.tools.ui.*;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Key;
import kha.Scaler;
import kha.System;
import kha.input.Keyboard;

class SpeedRace {
	public static inline var WIDTH : Int = 240;
	public static inline var HEIGHT : Int = 320;
	
	static inline var velocityMax : Float = 6;
	static inline var velocityStep : Float = 3;
	
	var velocity : Float;
	
	var backbuffer : Image;
	
	var player : PlayerCar;
	var road : Road;
	
	var scoreText : Text;
	var score : Float;
	
	public function new() {
		if (Keyboard.get() != null) Keyboard.get().notify(onKeyDown, onKeyUp);
		
		velocity = 0;
		
		backbuffer = Image.createRenderTarget(WIDTH, HEIGHT);
		
		player = new PlayerCar(Assets.images.car_big);
		player.setCenterPosition(WIDTH / 2, HEIGHT * 2 / 3);
		
		road = new Road(20, Assets.images.road_segment);
		
		Car.X_MIN = 20;
		Car.X_MAX = SpeedRace.WIDTH - 20;
		
		score = 0;
		scoreText = new Text(Assets.fonts.slkscr, 64);
	}

	public function update() : Void {
		player.update();
		road.update();
		
		score += velocity / velocityMax / 10;
		
		scoreText.value = Std.string(Math.floor(score));
		scoreText.setCenterPosition(System.windowWidth() / 2, System.windowHeight() - scoreText.height);
	}

	public function render(framebuffer: Framebuffer) : Void {
		var g = backbuffer.g2;
		g.begin(Color.fromValue(0xff00cc99));
		
		road.draw(g);
		player.draw(g);
		
		g.end();
		
		framebuffer.g2.begin(Color.Blue);
		
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		
		framebuffer.g2.transformation = kha.math.FastMatrix3.identity();
		scoreText.draw(framebuffer.g2);
		
		framebuffer.g2.end();	
	}
	
	private function updateVelocity(step : Float) : Void {
		velocity += step;
		velocity = (velocity < 0) ? 0 : ((velocity > velocityMax) ? velocityMax : velocity);
		road.updateVelocity(velocity);
	}
	
	private function onKeyDown(key : Key, char : String) : Void {
		switch (char) {
			case "w": updateVelocity(velocityStep);
			case "s": updateVelocity(-velocityStep);
			case "a": player.updateMovement(velocity, -1);
			case "d": player.updateMovement(velocity, 1);
		}
	}
	
	private function onKeyUp(key : Key, char : String) : Void {
		switch (char) {
			case "a": player.updateMovement(0, -1);
			case "d": player.updateMovement(0, 1);
		}
	}
}
