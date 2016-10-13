/*
 * Main.fx
 *
 * Created on Sep 14, 2009, 3:37:25 PM
 */

package org.lj.jfxe.chapter7;

import javafx.stage.Stage;
import javafx.scene.*;
import javafx.scene.layout.*;
import javafx.scene.shape.*;
import javafx.scene.control.*;
import javafx.scene.effect.DropShadow;
import javafx.animation.*;
import javafx.scene.paint.LinearGradient;
import javafx.scene.paint.Stop;
import javafx.scene.paint.Color;
import javafx.async.Task;
import javafx.util.Math;

/**
 * @author lucasjordan
 */

var sequenceView:ImageSequenceView;
var anim = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 1.0/30.0*1s
            action: function(){
                sequenceView.currentImage++;
            }
        }
    }

function run():Void{
    var seq1 = MediaLoader.imageSequence("/org/lj/jfxe/chapter7/images/asteroidA_64_", 31, true);
    var seq2 = MediaLoader.imageSequence("/org/lj/jfxe/chapter7/images/bomb-pur-64-", 61, true);
    var seq3 = MediaLoader.imageSequence("/org/lj/jfxe/chapter7/images/Explosion01_", 35, true);

    var asteroidButton = Button{
        text: "Asteroid"
        action: asteroid
        disable: true
    }
    var jackButton = Button{
        text: "Jack"
        action: jack
        disable: true
    }
    var skullButton = Button{
        text: "Skull"
        action: skull
        disable: true
    }
    var buttons = VBox{
        translateX: 32
        translateY: 32
        spacing: 6
        content: [asteroidButton,jackButton,skullButton]
    }
    var progressText = Label{
        text: "Loading Images..."
        translateX: 320
        translateY: 200
        scaleX: 2.0
        scaleY: 2.0
        width: 300
    }

    var stage = Stage {
        title: "Chapter 7"
        width: 640
        height: 480
        scene: Scene {
            fill: LinearGradient{
                    stops: [
                            Stop{
                                offset:0.0
                                color: Color.WHITESMOKE
                            },
                            Stop{
                                offset:1.0
                                color: Color.CHOCOLATE
                            },
                            ]
                    }
            content: bind [progressText, sequenceView, buttons]
        }
    }

    var checkProgess:Timeline = Timeline{
        repeatCount: Timeline.INDEFINITE;
        keyFrames: KeyFrame{
            time: .7s
            action:function(){
                var totalProgress = seq1.progress() + seq2.progress() + seq3.progress();
                if (totalProgress == 300.0){
                    checkProgess.stop();
                    progressText.text = "";
                    asteroidButton.disable = false;
                    jackButton.disable = false;
                    skullButton.disable = false;
                } else {
                    var progress:Integer = Math.round(totalProgress/300.0*100);
                    progressText.text = "Loading Images...{progress}%";
                }
            }
        }
    }
    checkProgess.play();


}

function asteroid():Void{
    sequenceView = ImageSequenceView{
        translateX: 640/2
        translateY: 480/2
        imageSequence: MediaLoader.imageSequence("/org/lj/jfxe/chapter7/images/astroidA_64_", 31, false)
    }
    anim.play();
}
function jack():Void{
    sequenceView = ImageSequenceView{
        translateX: 640/2
        translateY: 480/2
        imageSequence: MediaLoader.imageSequence("/org/lj/jfxe/chapter7/images/bomb-pur-64-", 63, false)
    }
    anim.play();
}
function skull():Void{
    sequenceView = ImageSequenceView{
        translateX: 640/2
        translateY: 480/2
        imageSequence: MediaLoader.imageSequence("/org/lj/jfxe/chapter7/images/Explosion01_", 35, false)
    }
    anim.play();
}