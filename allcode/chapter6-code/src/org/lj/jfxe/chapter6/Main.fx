/*
 * Main.fx
 *
 * Created on Aug 26, 2009, 3:53:24 PM
 */

package org.lj.jfxe.chapter6;

import javafx.stage.Stage;
import javafx.scene.*;
import javafx.scene.paint.Color;
import javafx.animation.*;
import net.phys2d.raw.World;
import net.phys2d.math.Vector2f;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import java.util.Random;


var random = new Random();
var worldNodes:WorldNode[];
var group = Group{}

var world = new World(new Vector2f(0,1200), 1);
var worldUpdater = Timeline{
    repeatCount: Timeline.INDEFINITE
    keyFrames: KeyFrame{
        time: 1.0/30.0*1s
        action: update;
    }

}
public function update():Void{
    world.<<step>>();
    for (worldNode in worldNodes){
        worldNode.update();
    }
    
}
public function addWorldNode(worldNode:WorldNode):Void{
    insert (worldNode as Node) into group.content;
    insert worldNode into worldNodes;
    for (body in worldNode.bodies){
        world.add(body);
    }
    for (joint in worldNode.joints){
        world.add(joint);
    }

}
public function reset():Void{
    world.clear();
    delete worldNodes;
    delete group.content;
}
public function run():Void{
    var button0 = Button{
        text: "Simple";
        action: simpleBalls;
    }
    var button1 = Button{
        text: "Falling Balls";
        action: fallingBalls;
    }
    var button2 = Button{
        text: "Pendulum";
        action: pendulum;
    }
    var button3 = Button{
        text: "Teeter Totter";
        action: teetertotter;
    }

    var vbox = VBox{
        translateX: 32;
        translateY: 64;
        spacing: 16
        content: [button0,button1,button2,button3]
    }

    Stage {
        title: "Chapter 6"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.BLACK
            content: [group, vbox]
        }
    }

    worldUpdater.play();
}
function simpleBalls():Void{
    reset();

    addWorldNode(Ball{translateX: 320, translateY: 10});

    addWorldNode(Wall{width: 100, height: 16, translateY: 200, translateX: 320, rotate: 30});
    addWorldNode(Wall{width: 100, height: 16, translateY: 370, translateX: 430, rotate: -30});
}
function fallingBalls():Void{
    reset();

    addWorldNode(Ball{translateX: 128, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*1, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*2, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*3, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*4, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*5, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*6, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*7, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*8, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*9, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*10, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*11, translateY: 50});
    addWorldNode(Ball{translateX: 128+32*12, translateY: 50});
    
    addWorldNode(Wall{width: 100, height: 16, translateY: 200, translateX: 128, rotate: 45});
    addWorldNode(Wall{width: 100, height: 16, translateY: 200, translateX: 128*2, rotate: -45});
    addWorldNode(Wall{width: 100, height: 16, translateY: 220, translateX: 128*3, rotate: 45});
    addWorldNode(Wall{width: 100, height: 16, translateY: 180, translateX: 128*4, rotate: -45});

    addWorldNode(Wall{width: 500, height: 16, translateY: 350, translateX: 350, rotate: -20});
}
function pendulum():Void{
    reset();

    var x = 250;
    var y = 140;
    var seperation = 32;

    addWorldNode(Pendulum{translateX: x, translateY: y, angle: -70});
    addWorldNode(Pendulum{translateX: x+seperation*1, translateY: y});
    addWorldNode(Pendulum{translateX: x+seperation*2, translateY: y});
    addWorldNode(Pendulum{translateX: x+seperation*3, translateY: y});
    addWorldNode(Pendulum{translateX: x+seperation*4, translateY: y});
}
function teetertotter():Void{
    reset();

    addWorldNode(Ball{translateX: 320-20-random.nextInt(120), translateY: 10+random.nextInt(300), radius: 10+random.nextInt(10)});
    addWorldNode(Ball{translateX: 320+20+random.nextInt(120), translateY: 10+random.nextInt(300), radius: 10+random.nextInt(10)});

    addWorldNode(Wall{width: 500, height: 16, translateX: 320, translateY: 440});

    addWorldNode(TeeterTotter{translateX: 320, translateY: 400});
}