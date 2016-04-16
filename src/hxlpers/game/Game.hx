package hxlpers.game;
import hxlpers.effects.ScreenPixelEffect;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.Sprite;
import openfl.events.Event;
using hxlpers.display.DisplayObjectSF;
using hxlpers.display.BitmapDataSF;
using hxlpers.effects.BitmapDataPixelEffectSF;
/**
 * ...
 * @author damrem
 */
class Game extends Sprite
{
	var rooms:Map<String, Room>;
	//var rendering:BitmapData;
	var currentRoom:Room;
	
	var isPlaying:Bool;
	var ratio:Float;
	var postRendering:BitmapData;
	var renderingContainer:Sprite;
	var fullWidth:UInt;
	var fullHeight:UInt;
	var pixelEffect:ScreenPixelEffect;
	var renderingLayer:Bitmap;
	
	var cameraList:CameraList;
	var roomHolder:Sprite;
	
	
	
	public function new(fullWidth:UInt, fullHeight:UInt, ratio:UInt) 
	{
		super();
		this.fullHeight = fullHeight;
		this.fullWidth = fullWidth;
		this.ratio = ratio;
		
		cameraList = new CameraList();
		
		rooms = new Map<String, Room>();
		//rendering = new BitmapData(Math.ceil(fullWidth / ratio), Math.ceil(fullHeight / ratio), false, 0xff000000);
		
		
		renderingLayer = new Bitmap();
		//trace(renderLayer.width);
		renderingLayer.scale(ratio);
		//trace(renderLayer.width);
		
		renderingContainer = new Sprite();
		renderingContainer.addChild(renderingLayer);
		
		postRendering = new BitmapData(fullWidth, fullHeight, false, 0xff000000);
		var postRenderingLayer=new Bitmap(postRendering);
		addChild(postRenderingLayer);
		
		
		
		//pixelEffect = new ScreenPixelEffect(fullWidth, fullHeight, Assets.getBitmapData("img/px3.png"));
		
		addEventListener(Event.ADDED_TO_STAGE, onStage);
		
		trace(mouseChildren);
		
		roomHolder = new Sprite();
		addChild(roomHolder);
	}
	
	private function onStage(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onStage);
		trace("onStage");
	}
	
	public function play()
	{
		trace("play");
		isPlaying = true;
		
		addEventListener(Event.ENTER_FRAME, update);
		currentRoom.play();
	}
	
	public function pause()
	{
		trace("pause");
		isPlaying = false;
		currentRoom.pause();
		
		removeEventListener(Event.ENTER_FRAME, update);
	}
	
	public function update(evt:Event=null)
	{
		//trace("update");
		currentRoom.update();
		render();
	}
	
	
	
	public function render()
	{
		
		currentRoom.render();
		//rendering.draw(currentRoom);
		postRendering.draw(renderingContainer);
		//postRendering.draw(pixelEffect, null, null, BlendMode.LIGHTEN);
		//postRendering.pixelEffect(3);
	}
	
	public function addRoom(id:String, room:Room) 
	{
		trace("addRoom", id, room);
		//room.scale(1 / ratio);
		rooms.set(id, room);
		setCurrentRoom(id);
	}
	
	public function setCurrentRoom(id:String)
	{
		trace("setCurrentRoom", id);
		var firstRoom:Bool = true;
		if (currentRoom != null)
		{
			firstRoom = false;
			currentRoom.pause();
		}
		
		currentRoom = rooms.get(id);
		
		if (isPlaying || firstRoom)
		{
			play();
		}
		
		
		
		//renderingLayer.bitmapData = currentRoom.rendering;
		renderingLayer.bitmapData = currentRoom.camera.screen;
		roomHolder.addChild(currentRoom);
	}
	
}