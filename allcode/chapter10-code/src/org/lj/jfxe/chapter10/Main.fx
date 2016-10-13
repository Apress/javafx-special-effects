/*
 * Main.fx
 *
 * Created on Sep 23, 2009, 5:10:48 PM
 */

package org.lj.jfxe.chapter10;

import javafx.stage.Stage;
import javafx.scene.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.scene.paint.*;
import javafx.animation.*;
import javafx.scene.image.*;
import net.phys2d.raw.World;
import net.phys2d.math.Vector2f;
import javafx.scene.effect.BlendMode;
import net.phys2d.raw.StaticBody;
import net.phys2d.raw.shapes.Box;
import java.util.Random;
import javafx.scene.effect.Reflection;

/**
 * @author lucasjordan
 */

public var cloud = Image{
    url: "{__DIR__}cloud.png"
}
public var spark = Image{
    url: "{__DIR__}spark.png"
}
public var random = new Random();

var worldNodes:WorldNode[];
var emitters:Emitter[];

var particles = Group{
        blendMode: BlendMode.ADD
        }
var obstacles = Group{}

var world = new World(new Vector2f(0,600), 1);
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
public function addWoldNode(worldNode:WorldNode):Void{
    if (worldNode instanceof Particle){
        insert (worldNode as Node) into particles.content;
    } else {
        insert (worldNode as Node) into obstacles.content;
    }
    insert worldNode into worldNodes;
    for (body in worldNode.bodies){
        world.add(body);
    }
    for (joint in worldNode.joints){
        world.add(joint);
    }
}
public function removeWoldNode(worldNode:WorldNode):Void{
    if (worldNode instanceof Particle){
        delete (worldNode as Node) from particles.content;
    } else {
        delete (worldNode as Node) from obstacles.content;
    }
    delete worldNode from worldNodes;
    for (body in worldNode.bodies){
        world.remove(body);
    }
    for (joint in worldNode.joints){
        world.remove(joint);
    }
}
public function addEmitter(emitter:Emitter):Void{
    insert emitter into emitters;
    emitter.play();
}
public function removeEmitter(emitter:Emitter):Void{
    emitter.stop();
    delete emitter from emitters;
}

public function clear(){
    var wn = worldNodes;
    for (node in wn){
        removeWoldNode(node);
    }
    var em = emitters;
    for (emitter in emitters){
        removeEmitter(emitter);
    }
}
function run():Void{
    worldUpdater.play();

    var sparksButton = Button{
        text: "Sparks"
        action: sparks
    }
    var fireballsButton = Button{
        text: "Fireballs"
        action: fireballs
    }
    var buttons = VBox{
        translateX: 32
        translateY: 32
        spacing: 12
        content: [sparksButton, fireballsButton]
    }
    Stage {
        title: "Chapter 10"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.BLACK;
            content: [buttons, obstacles, particles]
        }
    }
}

function sparks():Void{
    clear();
    for (x in [1..64]){
        addWoldNode(Peg{
            radius: 4
            translateX: x*10
            translateY: 400
        });
    }
    var emitter = SparkEmitter{
        x: 640/2
        y: 130
    }
    addEmitter(emitter);
}

function fireballs():Void{
    clear();
    for (y in [1..4],i in [1..2],x in [1..24]){
        addWoldNode(Peg{
            radius: 4
            translateX: x*24+i*12
            translateY: 100+y*48+i*24
        });
    }
    addEmitter(FireballEmitter{});
}

public function randomFromNegToPos(max:Number):Number{
    if (max == 0.0){
        return 0.0;
    }
    var result = max - random.nextFloat()*max*2;
    return result;
}

