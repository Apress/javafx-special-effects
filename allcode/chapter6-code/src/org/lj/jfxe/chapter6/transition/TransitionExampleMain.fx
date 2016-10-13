/*
 * Main.fx
 *
 * Created on Sep 20, 2009, 4:21:16 PM
 */

package org.lj.jfxe.chapter6.transition;

import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.*;
import javafx.animation.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.util.*;
import javafx.geometry.*;
import javafx.fxd.Duplicator;
import net.phys2d.raw.Body;
import net.phys2d.raw.World;
import net.phys2d.math.Vector2f;
import net.phys2d.raw.StaticBody;

/**
 * @author lucasjordan
 */
var nodeA = ExampleNodeA{
    translateX: 320 - 160
    translateY: 240 - 120
}
var nodeB = ExampleNodeB{
    translateX: 320 - 160
    translateY: 240 - 120
}

var displayed:Group = nodeA;
var notDisplayed:Group = nodeB;

var disabled = false;


var transitionButton = Button{
    text: "Gravity Transition"
    action: function(){
        disabled = true;
        doReplace(displayed, notDisplayed, doAfter);
    }
    disable: bind disabled;
}
function doAfter():Void{
    var temp = notDisplayed;
    notDisplayed = displayed;
    displayed = temp;
    disabled = false;
}
function run():Void{
    Stage {
        title: "Chapter 6 - Transition"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.BLACK
            content: [
                VBox{
                    spacing: 10
                    translateX: 25
                    translateY: 30
                    content: [transitionButton]
                },
                nodeA
            ]
        }
    }
}

public function doReplace(nodeToReplace:Group,replacementNode:Group,doAfter:function()):Void{
    var handlers:ControlHandler[];
    var inactives:ControlHandler[];

    var initHeight = nodeToReplace.boundsInLocal.height;

    var world = new World(new Vector2f(0,1200), 1);

    for (node in nodeToReplace.content){
        if (node instanceof Control){
            var control:Control = node as Control;
            var handler = ControlHandler{
                control: control
            }
            insert handler into inactives;
            insert handler into handlers;
            world.add(handler.staticBody);
        }
    }

    inactives = Sequences.shuffle(inactives) as ControlHandler[];


    var addBodies = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: .5s
            action: function(){
                if (sizeof inactives > 0){
                    var handler = inactives[0];
                    delete inactives[0];
                    handler.isStatic = false;
                    world.remove(handler.staticBody);
                    world.add(handler.body);
                }
            }
        }
    }

    addBodies.play();

    var worldUpdater = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 1.0/30.0*1s
            action: function(){
                world.<<step>>();
                for (handler in handlers){
                    handler.update();
                }

            }

        }
    }
    
    worldUpdater.play();

    var cleanup = Timeline{
            keyFrames: KeyFrame{
                time: 1s
                action: function(){
                    addBodies.stop();
                    worldUpdater.stop();
                    for (handler in handlers){
                        handler.control.translateX = handler.startingX;
                        handler.control.translateY = handler.startingY;
                        handler.control.rotate = handler.startingRot
                    }
                }

            }

        }

    var checkCleanup:Timeline = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: [
                KeyFrame{
                    time: 1s
                    action: function(){
                        var stop = true;
                        for (handler in handlers){
                            if (handler.body.getPosition().getY() < initHeight){
                                stop = false;
                                break;
                            }
                        }
                        if (stop){
                            FadeReplace.doReplace(nodeToReplace, replacementNode, doAfter);
                            cleanup.playFromStart();
                            checkCleanup.stop();
                        }
                    }
               }
        ]
    }
    checkCleanup.play();
}

class ControlHandler{
    var control:Control;
    var body:Body;
    var staticBody:StaticBody;

    var startingX:Number;
    var startingY:Number;
    var startingRot:Number;

    var isStatic = true;

    init{

        startingX = control.translateX;
        startingY = control.translateY;
        startingRot = control.rotate;

        var box = new net.phys2d.raw.shapes.Box(control.width, control.height);
        body = new Body(box, 10);
        body.setRestitution(.9);
        staticBody = new StaticBody(box);

        staticBody.setPosition(control.translateX + control.width/2.0, control.translateY + control.height/2.0);
        body.setPosition(control.translateX + control.width/2.0, control.translateY + control.height/2.0);
    }
    function update(){
        if (not isStatic){
            control.translateX = body.getPosition().getX() - control.width/2.0;
            control.translateY = body.getPosition().getY() - control.height/2.0;
            control.rotate = Math.toDegrees(body.getRotation());
        }
    }
}

