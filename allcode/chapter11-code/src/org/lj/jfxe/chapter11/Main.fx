/*
 * Main.fx
 *
 * Created on Nov 4, 2009, 6:36:20 PM
 */

package org.lj.jfxe.chapter11;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.*;
import javafx.scene.*;
import javafx.scene.input.MouseEvent;
import javafx.scene.effect.*;
import javafx.scene.shape.*;
import javafx.util.Sequences;
import java.util.*;
import javafx.animation.*;
import javafx.scene.effect.light.SpotLight;
import javafx.scene.effect.light.DistantLight;
import javafx.scene.text.Text;
import javafx.scene.input.KeyEvent;

/**
 * @author lucasjordan
 */

public def random = new Random();

public var startScreen = GameAssetsUI{}
var aboutScreen = GameAssetsUI{}
var gameModel:GameModel;

var rootGroup = Group{
    content: startScreen
    onKeyReleased: keyReleased;
}

var scene = Scene {
        width: 640
        height: 480
        content: [rootGroup]
        fill: Color.BLACK
    }

public var blockInput = false;
public var lightAnim:Timeline;

function run():Void{
    initStartScreen();
    initAboutScreen();
    Stage {
        title: "Clown Cannon"
        resizable: false;
        scene: scene
    }
    rootGroup.requestFocus();
    lightAnim.play();
}

function keyReleased(event:KeyEvent){
    gameModel.keyReleased(event);
}


public function addLights(gameAsset:GameAssetsUI):Timeline{

    var yCenter = gameAsset.backPanelGroup2.boundsInParent.height/2.0;
    var spotLight = SpotLight{
            x: 320
            y: yCenter
            z: 50;
            pointsAtZ: 0
            pointsAtX: 320
            pointsAtY: yCenter
            color: Color.WHITE;
            specularExponent: 2
        }


    gameAsset.backPanelGroup1.effect = Lighting{
        light: spotLight
        diffuseConstant: 2
    }
    

    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE;
        keyFrames: [
                KeyFrame{
                    time: 0s
                    values: [spotLight.pointsAtX => 320 tween Interpolator.EASEBOTH,
                             spotLight.pointsAtY => yCenter tween Interpolator.EASEBOTH]
                },
                KeyFrame{
                    time: 1s
                    values: spotLight.pointsAtY => yCenter+100 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 2s
                    values: spotLight.pointsAtX => 30 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 3s
                    values: spotLight.pointsAtY => yCenter-100 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 4s
                    values: spotLight.pointsAtX => 320 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 5s
                    values: spotLight.pointsAtY => yCenter+100 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 6s
                    values: spotLight.pointsAtX => 610 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 7s
                    values: spotLight.pointsAtY => yCenter-100 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 8s
                    values: [spotLight.pointsAtX => 320 tween Interpolator.EASEBOTH,
                             spotLight.pointsAtY => yCenter tween Interpolator.EASEBOTH]
                }
                ]
    }
    return anim;
}

function initStartScreen():Void{
    simplifyGradients(startScreen);
    lightAnim = addLights(startScreen);
    removeFromParent(startScreen.aboutPanel);
    removeFromParent(startScreen.waitingClownGroup);
    removeFromParent(startScreen.startGameInstructions);
    removeFromParent(startScreen.endButtons);
    removeFromParent(startScreen.gameOverText);
    makeButton(startScreen.startButton, startGame);
    makeButton(startScreen.aboutButton, showAbout);

}

function initAboutScreen():Void{
    simplifyGradients(aboutScreen);
    removeFromParent(aboutScreen.startButton);
    removeFromParent(aboutScreen.aboutButton);
    removeFromParent(aboutScreen.startGameInstructions);
    removeFromParent(aboutScreen.waitingClownGroup);
    removeFromParent(aboutScreen.endButtons);
    removeFromParent(aboutScreen.gameOverText);
    makeButton(aboutScreen.backButton, backToStart);
    aboutScreen.effect = ColorAdjust{
        hue: .2
    }
}

public function removeFromParent(node:Node):Void{
    var parent:Object = node.parent;
    if (parent instanceof Group){
        delete node from (parent as Group).content;
    } else if (parent instanceof Scene){
        delete node from (parent as Scene).content
    }
}

public function makeButton(node:Node,action:function()){
    node.blocksMouse = true;
    node.onMouseClicked = function(event:MouseEvent):Void{
        if (not blockInput){
            action();
        }
    }
    node.onMouseEntered = function(event:MouseEvent):Void{
        node.effect = Glow{}
    }
    node.onMouseExited = function(event:MouseEvent):Void{
        node.effect = null;
    }
}
public function allowInput():Void{
    blockInput = false;
}
function startGame():Void{
    lightAnim.stop();
    gameModel = GameModel{}
    FlipReplace.doReplace(startScreen, gameModel.screen, gameModel.startingAnimationOver);
}
function showAbout():Void{
    lightAnim.stop();
    blockInput = true;
    WipeReplace.doReplace(startScreen, aboutScreen, allowInput);
}
function backToStart():Void{
    lightAnim.play();
    blockInput = true;
    WipeReplace.doReplace(aboutScreen, startScreen, allowInput);
}
public function offsetFromZero(node:Node):Group{
    var xOffset = node.boundsInParent.minX + node.boundsInParent.width/2.0;
    var yOffset = node.boundsInParent.minY + node.boundsInParent.height/2.0;

    var parent = node.parent as Group;
    var index = Sequences.indexOf(parent.content, node);

    delete node from (parent as Group).content;
    
    node.translateX = -xOffset;
    node.translateY = -yOffset;

    var group = Group{
        translateX: xOffset;
        translateY: yOffset;
        content: node;
    }
    insert group before parent.content[index];

    return group;
}

public function createLinearGradient(stops:Stop[]):LinearGradient{
    return LinearGradient{
        startX: 1
        endX: 1
        startY: 0
        endY: 1
        proportional: true
        stops: sortStops(stops);
    }
}
public function sortStops(stops:Stop[]):Stop[]{
    var result:Stop[] = Sequences.sort(stops, Comparator{
        public override function compare(obj1:Object, obj2: Object):Integer{

            var stop1 = (obj1 as Stop);
            var stop2 = (obj2 as Stop);

            if (stop1.offset > stop2.offset){
                return 1;
            } else if (stop1.offset < stop2.offset){
                return -1;
            } else {
                return 0;
            }
        }
    }) as Stop[];

    return result
}

public function randomFromNegToPos(max:Number):Number{
        if (max == 0.0){
            return 0.0;
        }
        var result = max - random.nextFloat()*max*2;
        return result;
}

public function simplifyGradients(node:Node):Void{
    if (node instanceof Shape){
        var shape  = node as Shape;
        if (shape.fill instanceof LinearGradient){
            var linearGradient = (shape.fill as LinearGradient);
            if (sizeof(linearGradient.stops) > 2){
                var newStops:Stop[];

                insert linearGradient.stops[0] into newStops;
                insert linearGradient.stops[sizeof(linearGradient.stops)-1] into newStops;

                var newGradient = LinearGradient{
                    endX: linearGradient.endX
                    endY: linearGradient.endY
                    proportional: linearGradient.proportional;
                    startX: linearGradient.startX
                    startY: linearGradient.startY
                    stops: newStops;
                }
                shape.fill = newGradient;
            }

        }

    }
    if (node instanceof Group){
        for(n in (node as Group).content){
            simplifyGradients(n);
        }

    }
}
