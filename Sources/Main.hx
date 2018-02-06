package;

import kha.Assets;
import kha.Scheduler;
import kha.System;

class Main {
	public static function main() {
		System.init({title: "KHA SPEED RACE", width: 480, height: 640}, init);
	}
	
	static function init() : Void {
		Assets.loadEverything(postLoadEverything);
	}
	
	static function postLoadEverything() : Void {
		var g = new game.SpeedRace();
		System.notifyOnRender(g.render);
		Scheduler.addTimeTask(g.update, 0, 1 / 60);
	}
}
