package game;

import game.sprites.*;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Image;
import kha.Scaler;
import kha.System;
import kha.graphics2.Graphics;

class SpeedRace {
	public static inline var WIDTH : Int = 240;
	public static inline var HEIGHT : Int = 320;
	
	var backbuffer : Image;
	
	var player : PlayerCar;
	
	public function new() {
		backbuffer = Image.createRenderTarget(WIDTH, HEIGHT);
		
		player = new PlayerCar(Assets.images.car_big);
		player.setCenterPosition(WIDTH / 2, HEIGHT * 2 / 3);
	}

	public function update() : Void {
		player.update();
	}

	public function render(framebuffer: Framebuffer) : Void {
		var g = backbuffer.g2;
		g.begin(Color.fromValue(0xff00cc99));
		
		drawRoad(g);
		player.draw(g);
		
		g.end();
		
		framebuffer.g2.begin(Color.Blue);
		Scaler.scale(backbuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();	
	}
	
	private function drawRoad(g : Graphics) : Void {
		g.color = Color.fromValue(0xff888888);
		g.fillRect(WIDTH / 8, 0, WIDTH * 6 / 8, HEIGHT);
		g.color = Color.White;
	} 
}
