package game;

import game.groups.*;
import game.sprites.*;

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
	
	static inline var MAX_V : Float = 6;
	static inline var DV : Float = 3;
	
	var backbuffer : Image;
	
	var player : PlayerCar;
	var road : Road;
	
	var v : Float;
	
	public function new() {
		if (Keyboard.get() != null) Keyboard.get().notify(onKeyDown, onKeyUp);
		
		v = 0;
		
		backbuffer = Image.createRenderTarget(WIDTH, HEIGHT);
		
		player = new PlayerCar(Assets.images.car_big);
		player.setCenterPosition(WIDTH / 2, HEIGHT * 2 / 3);
		
		road = new Road(20, Assets.images.road_segment);
	}

	public function update() : Void {
		player.update();
		road.update();
	}

	public function render(framebuffer: Framebuffer) : Void {
		var g = backbuffer.g2;
		g.begin(Color.fromValue(0xff00cc99));
		
		road.draw(g);
		player.draw(g);
		
		g.end();
		
		framebuffer.g2.begin(Color.Blue);
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();	
	}
	
	private function updateVelocity(dv : Float) : Void {
		v += dv;
		v = (v < 0) ? 0 : ((v > MAX_V) ? MAX_V : v);
		road.updateVelocity(v);
	}
	
	private function onKeyDown(key : Key, char : String) : Void {
		switch (char) {
			case "w": updateVelocity(DV);
			case "s": updateVelocity(-DV);
		}
	}
	
	private function onKeyUp(key : Key, char : String) : Void {
	}
}
