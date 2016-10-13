/*
 * GameModel.fx
 *
 * Created on Nov 5, 2009, 4:11:05 PM
 */

package org.lj.jfxe.chapter11;

import javafx.scene.paint.*;
import javafx.scene.*;
import javafx.scene.input.MouseEvent;
import javafx.scene.effect.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.animation.*;
import net.phys2d.raw.World;
import net.phys2d.math.Vector2f;
import javafx.scene.text.Text;
import javafx.util.Math;
import net.phys2d.raw.StaticBody;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.KeyCode;

/**
 * @author lucasjordan
 */
public class GameModel {
    public var screen = GameAssetsUI{}
    var world = new World(new Vector2f(0,1200), 1);
    var worldUpdater:Timeline = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 1.0/30.0*1s
            action: update;
        }
    }
    var clownBody:ClownBody;
    var clownNode:Group;
    var cannonNode:Group;
    var bucketNode:Group;
    var balloonNode:Group;
    var pegs:Group[];
    var fireworks:Group[];
    var net:Group;

    var canFire = false;

    var clownsAvailable = 5 on replace{
        var group = (screen.waitingClownGroup as Group);
        for(i in [0..sizeof(group.content)]){
            var waitingClown = group.content[i];
            waitingClown.visible = clownsAvailable > i;
        }
    }

    var cannonAngle = -45.0 on replace {
        screen.barrel.rotate = cannonAngle;
    }
    var powerFill = bind Main.createLinearGradient([
            Stop{
              offset: 0.0
              color: Color.TRANSPARENT
            },
            Stop{
              offset: 1-cannonPower/1000;
              color: Color.TRANSPARENT
            },
            Stop{
               offset: 1-cannonPower/1000;
               color: Color.RED
            },
            Stop{
               offset: 1.0
               color: Color.RED
            }
            ]);
    var cannonPower = 0.0 on replace {
        (screen.powerLevel as SVGPath).fill = powerFill;
    };
    
    var powerAnim = Timeline{
       repeatCount: Timeline.INDEFINITE;
       autoReverse: true;
       keyFrames: [
               KeyFrame{
                   time: 0s
                   values: cannonPower => 0
               },
               KeyFrame{
                   time: 1s
                   values: cannonPower => 1000;
               }
               ]
    }

    var score:Integer = 0 on replace{
        (screen.score as Text).content = "Score: {pad(score)}";
    }

    function pad(value:Integer):String{
        if (value < 10){
           "000{value}"
        } else if (value < 100){
           "00{value}"
        } else if (value < 1000){
           "0{value}"
        } else {
            "{value}"
        }
    }

    var balloonAnim:Timeline;
    var balloonMulti = 1;
    var lightsAnim:Timeline;

    init{
        initScreen();
    }

    function initScreen():Void{
        Main.simplifyGradients(screen);
        Main.removeFromParent(screen.aboutPanel);
        Main.removeFromParent(screen.aboutButton);
        Main.removeFromParent(screen.startButton);
        Main.removeFromParent(screen.title);

        screen.powerLevel.visible = true;
        screen.backFromPlayButton.visible = false;
        screen.playAgainButton.visible = false;
        screen.gameOverText.visible = false;
        Main.makeButton(screen.backFromPlayButton, goBack);
        Main.makeButton(screen.playAgainButton, playAgain);

        screen.onMouseWheelMoved = mouseWheelMoved;
        screen.onMouseClicked = mouseButtonClicked;

        clownNode = Main.offsetFromZero(screen.flyingClown);
        cannonNode = Main.offsetFromZero(screen.cannon);
        bucketNode = Main.offsetFromZero(screen.waterBucket);
        balloonNode = Main.offsetFromZero(screen.bonusBalloon);
        net = Main.offsetFromZero(screen.net);

        insert Main.offsetFromZero(screen.peg0) into pegs;
        insert Main.offsetFromZero(screen.peg1) into pegs;
        insert Main.offsetFromZero(screen.peg2) into pegs;
        insert Main.offsetFromZero(screen.peg3) into pegs;
        insert Main.offsetFromZero(screen.peg4) into pegs;

        for (firework in (screen.fireworkGroup as Group).content){
            insert Main.offsetFromZero(firework) into fireworks;
        }

        lightsAnim = Main.addLights(screen);
        lightsAnim.play();
    }

    public function startingAnimationOver():Void{
        Main.allowInput();
        var startingAnimation = Timeline{
            keyFrames: [
                    KeyFrame{
                        time: 10s
                        values: screen.startGameInstructions.opacity => 0.0 tween Interpolator.SPLINE(1.00,0.00,1.00,0.00)
                        action: startRound;
                    }
                    ]
        }
        startingAnimation.play();
    }

    function startRound():Void{
         cannonAngle = -45;
         world.clear();
         clownsAvailable = 5;
         for (peg in pegs){
            peg.translateX = 100 + Main.random.nextInt(400);
            peg.translateY = 100 + Main.random.nextInt(200);
            var circleBody = StaticCircleBody{
                node: peg;
            }
            world.add(circleBody.body);
        }
        //adding wall on right edge of screen
        for (i in [0..40]){
            var wall = new StaticBody(new net.phys2d.raw.shapes.Circle(12));
            wall.setPosition(640+6, i*12);
            world.add(wall);
        }

        readyLaunch();
    }

    function mouseButtonClicked(event:MouseEvent):Void{
        fireClown();
    }
    function mouseWheelMoved(event:MouseEvent):Void{
        adjustCannon(event.wheelRotation);
    }
    public function keyReleased(event:KeyEvent):Void{
        if (event.code == KeyCode.VK_SPACE){
            fireClown();
        } else if (event.code == KeyCode.VK_UP){
            adjustCannon(-2);
        } else if (event.code == KeyCode.VK_DOWN){
            adjustCannon(2);
        }
    }

    function adjustCannon(amount:Number):Void{
        cannonAngle += amount;
        if (cannonAngle < -85){
            cannonAngle = -85
        }
        if (cannonAngle > -15){
            cannonAngle = -15;
        }
    }

    function readyLaunch():Void{
        (screen.status as Text).content = "Fire When Ready";
        if (clownBody != null){
            world.remove(clownBody.body);
        }

        balloonAnim.stop();
        balloonAnim = Timeline{
        repeatCount: Timeline.INDEFINITE;
            autoReverse: true;
            keyFrames: [
                    KeyFrame{
                        time: 0s
                        values: balloonNode.translateY => 100.0 tween Interpolator.EASEOUT;
                    },
                   KeyFrame{
                        time: 4s
                        values: balloonNode.translateY => 400.0 tween Interpolator.EASEIN;
                   }
            ]
        }

        clownNode.translateX = cannonNode.translateX;
        clownNode.translateY = cannonNode.translateY;
        clownNode.rotate = cannonAngle;

        balloonNode.translateX = 100 + Main.random.nextInt(400);
        balloonNode.visible = true;
        balloonAnim.playFromStart();
        balloonMulti = 1;

        canFire = true;
        powerAnim.playFromStart();
    }

    function fireClown():Void{
        if (canFire){
            powerAnim.stop();

            canFire = false;
            clownsAvailable--;

            clownNode.translateX = cannonNode.translateX;
            clownNode.translateY = cannonNode.translateY;
            clownNode.rotate = cannonAngle;

            clownBody = ClownBody{
                startingPower: cannonPower;
                clown: clownNode
            }
            world.add(clownBody.body);
            worldUpdater.play();
        }
    }

    function update():Void{
        world.<<step>>();
        clownBody.update();
        
        checkBalloon();

        if (collision(clownNode, bucketNode)){
            worldUpdater.stop();
            score+=100*balloonMulti;
            celebrate();
        } else if (clownNode.translateY > net.boundsInParent.minY){
            worldUpdater.stop();
            nextClown();
        }
    }

    function checkBalloon():Void{
        if (collision(clownNode, balloonNode)){
            balloonNode.visible = false;
            balloonMulti = 2;
        }

    }

    function celebrate():Void{
        (screen.status as Text).content = "Well Done!";
        var timeline = Timeline{}

        var count = (Main.random.nextInt(sizeof(fireworks))+1)*balloonMulti;

        for (i in [0..count]){
            var firework = fireworks[Main.random.nextInt(sizeof(fireworks)-1)];
            insert KeyFrame{
                time: i*.5s;
                action: function(){
                        doFirework(firework);
                        };
            } into timeline.keyFrames;
        }

        insert KeyFrame{
                time: count*.5s + 1s;
                action: function(){
                        nextClown();
                        }
            } into timeline.keyFrames;


        timeline.play();
    }

    function doFirework(firework:Group):Void{
        var shell = Circle{
            radius: 4
            fill: Color.DARKBLUE
        }

        insert shell into firework.content;

        var timeline = Timeline{
            keyFrames: [
                    KeyFrame{
                        time: .5s
                        values: shell.translateY => -250 tween Interpolator.SPLINE(.43, .79, .84, 1.0)
                        action: function(){
                            doExplosion(firework, shell.translateX, shell.translateY);
                            delete shell from firework.content;
                        }
                    }
                    ]
            }
        timeline.play();
    }

    function doExplosion(firework:Group, x:Number, y:Number):Void{
        var explosion = Explosion{
                translateX: x;
                translateY: y;
            }
        insert explosion into firework.content;

        var timeline = Timeline{
            keyFrames: KeyFrame{
                time: 4s
                action:function(){
                    explosion.stop();
                    delete explosion from firework.content;
                }
            }
        }

        timeline.play();
    }

    function nextClown():Void{
        if (clownsAvailable > 0){
            readyLaunch();
        } else {
            endRound();
        }
    }

    function collision(a:Node,b:Node){
        if (Math.abs(a.translateX - b.translateX) < b.boundsInLocal.width/2.0){
            if (Math.abs(a.translateY - b.translateY) < b.boundsInLocal.height/2.0){
                return true;
            }
        }
        return false;
    }

    function endRound():Void{
        screen.gameOverText.visible = true;
        screen.backFromPlayButton.visible = true;
        screen.playAgainButton.visible = true;
    }

    function goBack():Void{
        lightsAnim.stop();
        FlipReplace.doReplace(screen, Main.startScreen, Main.allowInput);
        Main.lightAnim.play();
    }

    function playAgain():Void{
        score = 0;
        screen.gameOverText.visible = false;
        screen.backFromPlayButton.visible = false;
        screen.playAgainButton.visible = false;
        startRound();
    }
}
