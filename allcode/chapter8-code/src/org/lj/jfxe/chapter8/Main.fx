/*
 * Main.fx
 *
 * Created on Sep 18, 2009, 7:55:37 PM
 */

package org.lj.jfxe.chapter8;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.*;
import javafx.animation.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.util.Sequences;
import java.util.Comparator;
import javafx.util.Math;
import javafx.geometry.HPos;
/**
 * @author lucasjordan
 */
var group = Group{}

function run():Void{
    var exampleButton = Button{
        text: "Example Gradients"
        action: example;
    }
    var simpleColorButton = Button{
        text: "Simple Color"
        action: simpleColor;
    }
    var simpleLinearButton = Button{
        text: "Simple Linear"
        action: simpleLinear;
    }
    var simpleRadialButton = Button{
        text: "Simple Radial"
        action: simpleRadial;
    }
    var mutlipleColorsLinearButton = Button{
        text: "Multi Color Linear"
        action: mutlipleColorsLinear;
    }
    var animatedStopLinearButton = Button{
        text: "Animated Stop"
        action: animatedStopLinear;
    }
    var opacityButton = Button{
        text: "Opacity"
        action: opacity;
    }
    var progressBarButton = Button{
        text: "Progress Bar"
        action: progressBar;
    }

    var buttons1 = HBox{
        translateX: 32
        translateY: 32
        spacing: 4
        content: [exampleButton, simpleColorButton,simpleLinearButton,simpleRadialButton,
                  mutlipleColorsLinearButton,]
    }
    var buttons2 = HBox{
        translateX: 32
        translateY: 62
        spacing: 4
        content: [animatedStopLinearButton,opacityButton,progressBarButton]
    }

    Stage {
        title: "Chapter 8"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.WHITE
            content: [buttons1,buttons2,group]
        }
    }
}

function example():Void{
    delete group.content;
    var rect1 = Rectangle{
        width: 100
        height: 100
        fill: LinearGradient{
            proportional: true
            stops: [
                   Stop{
                       offset: 0.0
                       color: Color.BLUE
                   },
                   Stop{
                       offset: 1.0
                       color: Color.YELLOW
                   },
            ]
        }
    }
    var v1 = VBox{
        nodeHPos: HPos.CENTER
        content: [rect1, Label{text:"Proportional Linear"}]
    }
    var rect2 = Rectangle{
        width: 100
        height: 100
        fill: LinearGradient{
            proportional: false
            startX: 20
            endX: 80
            startY: 0
            endY: 0
            stops: [
                   Stop{
                       offset: 0.0
                       color: Color.BLUE
                   },
                   Stop{
                       offset: 1.0
                       color: Color.YELLOW
                   },
            ]
        }
    }
    var v2 = VBox{
        nodeHPos: HPos.CENTER
        content: [rect2, Label{text:"Fixed Width Linear"}]
    }
    var rect3 = Rectangle{
        width: 100
        height: 100
        fill: RadialGradient{
            proportional: true
            stops: [
                   Stop{
                       offset: 0.0
                       color: Color.BLUE
                   },
                   Stop{
                       offset: 1.0
                       color: Color.YELLOW
                   },
            ]
        }
    }
    var v3 = VBox{
        content: [rect3, Label{text:"Proportional Radial"}]
    }
    var rect4 = Rectangle{
        width: 100
        height: 100
        fill: RadialGradient{
            proportional: false
            radius: 20
            centerX: 30
            centerY: 30
            stops: [
                   Stop{
                       offset: 0.0
                       color: Color.BLUE
                   },
                   Stop{
                       offset: 1.0
                       color: Color.YELLOW
                   },
            ]
        }
    }
    var v4 = VBox{
        content: [rect4, Label{text:"Fixed Radius Radial"}]
    }
    var hbox = HBox{
            spacing: 20
        translateX: 80
        translateY: 200
        content: [v1,v2,v3,v4]
    }
    insert hbox into group.content;
}

function simpleLinear():Void{
    delete group.content;

    var red = 0.0;

    var rect = Rectangle{
        translateX: 640/2-350/2;
        translateY: 480/2-50
        width: 350
        height: 50
        fill: bind createLinearGradient([
                Stop{color:Color.BLUE, offset:0.0},
                createStop(createColor(red, 0, 0, 1.0), 1.0)
                ]);
    }
    insert rect into group.content;

    var anim = Timeline{
            repeatCount: Timeline.INDEFINITE;
            autoReverse: true;
            keyFrames: KeyFrame{
            time: 2s
            values: red => 1.0;
        }
    }

    anim.play();
}
function animatedStopLinear():Void{
    delete group.content;

    var stop = 0.0;

    var rect = Rectangle{
        translateX: 640/2-350/2;
        translateY: 480/2-50
        width: 350
        height: 50
        fill: bind createLinearGradient([
                Stop{color:Color.YELLOW, offset:0.0},
                createStop(Color.CYAN, stop),
                Stop{color:Color.YELLOW, offset:1.0},
                ]);
    }
    insert rect into group.content;

    var anim = Timeline{
            repeatCount: Timeline.INDEFINITE;
            autoReverse: true;
            keyFrames: [
                KeyFrame{
                    time: 3s
                    values: [stop => 1.0 tween Interpolator.EASEBOTH]
                }
            ]
        }

    anim.play();
}


function mutlipleColorsLinear():Void{
    delete group.content;

    var red1 = 0.0;
    var green1 = 0.0;
    var blue1 = 0.0;

    var red2 = 0.0;
    var green2 = 0.0;
    var blue2 = 0.0;

    var rect = Rectangle{
        translateX: 640/2-350/2;
        translateY: 480/2-50
        width: 350
        height: 50
        fill: bind createLinearGradient([
                createStop(createColor(red1, green1, blue1, 1.0), 0.0),
                createStop(createColor(red2, green2, blue2, 1.0), 1.0)
                ]);
    }
    insert rect into group.content;

    var anim = Timeline{
            repeatCount: Timeline.INDEFINITE;
            autoReverse: true;
            keyFrames: [
                KeyFrame{
                    time: 1s
                    values: [red1 => 1.0]
                },
                KeyFrame{
                    time: 3s
                    values: [
                            blue1 => 1.0,
                            green2 => 1.0,
                            ]
                },
                KeyFrame{
                    time: 5s
                    values: [
                            red1 => 0.0,
                            red2 => 1.0,
                            ]
                },
                KeyFrame{
                    time: 7s
                    values: [
                            green1 => 1.0,
                            blue2 => 1.0,
                            ]
                },
            ]
        }

    anim.play();
}

function simpleRadial():Void{
    delete group.content;
    var colorValue = 0.0;
    var rect = Rectangle{
        translateX: 640/2-100
        translateY: 480/2-100
        width: 200
        height: 200
        fill: bind createRadialGradient(0.5,0.5,[
                createStop(createColor(colorValue, colorValue, 0, 1.0), 0.0),
                Stop{color:Color.BLUE, offset:1.0}
                ]);
        }
    insert rect into group.content;
    var anim = Timeline{
            repeatCount: Timeline.INDEFINITE;
            autoReverse: true;
            keyFrames: KeyFrame{
            time: 2s
            values: colorValue => 1.0;
        }
    }
    anim.play();
}

function simpleColor():Void{
    delete group.content;
    var red = 0.0;
    var rect = Rectangle{
        translateX: 640/2-100
        translateY: 480/2-100
        width: 200
        height: 200
        fill: bind createColor(red,1.0,0,1.0)
    }
    insert rect into group.content;
    var anim = Timeline{
            repeatCount: Timeline.INDEFINITE;
            autoReverse: true;
            keyFrames: KeyFrame{
            time: 2s
            values: red => 1.0;
        }
    }
    anim.play();
}

function opacity():Void{
    delete group.content;

    var offset = 0.0;
    var opacity = 1.0;

    var rect = Rectangle{
        translateX: 640/2-350/2;
        translateY: 480/2-50
        width: 350
        height: 50
        fill: bind createLinearGradient([
                Stop{color:Color.YELLOW, offset:0.0},
                createStop(createColor(1.0, 1.0, 0.0, opacity), offset),
                Stop{color:Color.YELLOW, offset:1.0},
                ]);
    }
    insert Label{
            translateX: 300
            translateY: 205
            text: "Opacity"
            scaleX: 3
            scaleY: 3
            } into group.content;
    insert rect into group.content;

    var anim = Timeline{
            repeatCount: Timeline.INDEFINITE;
            autoReverse: true;
            keyFrames: [
                KeyFrame{
                    time: 0s
                    values: opacity => 1.0
                },
                KeyFrame{
                    time: 2s
                    values: opacity => 0.3
                },
                KeyFrame{
                    time: 4s
                    values: [
                        offset => 1.0 ,
                        opacity => 1.0 
                        ]
                }
            ]
        }
    anim.play();
}

function progressBar():Void{
    delete group.content;
    var t = 0.0;
    var w = 1.0;
    var rect = Rectangle{
        width: 350
        height: 50
        arcHeight: 15
        arcWidth: 15
        fill: bind createLinearGradient(30,[
                Stop{color: createColor(w,w, 1,1), offset: 0.0},
                createStop(Color.WHITE, t),
                createStop(Color.BLUE, t+.5),
                Stop{color: createColor(w,w, 1,1), offset: 1.0},
                ]);
        stroke: Color.LIGHTGRAY
        strokeWidth: 2
    }
    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE;
        keyFrames: [
            KeyFrame{
                time: 1s
                values: [
                    w => 0.0
                ]
            },
            KeyFrame{
                time: 2s
                values: [
                    t => 1.0,
                    w => 1.0
                ]
            }
            ]
    }
    anim.play();
    var hgloss = Rectangle{
        width: 350
        height: 50
        arcHeight: 15
        arcWidth: 15
        fill: LinearGradient{
            startX: 0
            endX: 0
            stops: [
                Stop{
                    color: Color.TRANSPARENT
                    offset: 0.0
                },
                Stop{
                    color: Color{red: 1, green: 1, blue: 1, opacity: .4}
                    offset: 0.3
                },
                Stop{
                    color: Color.TRANSPARENT
                    offset: 1.0
                },
            ]
        }
    }
    var vgloss = Rectangle{
        width: 350
        height: 50
        arcHeight: 15
        arcWidth: 15
        fill: LinearGradient{
            startY: 0
            endY: 0
            stops: [
                Stop{
                    color: Color{red: 1, green: 1, blue: 1, opacity: .3}
                    offset: 0.0
                },
                Stop{
                    color: Color.TRANSPARENT
                    offset: 0.1
                },
                Stop{
                    color: Color.TRANSPARENT
                    offset: 0.8
                },
                Stop{
                    color: Color{red: 1, green: 1, blue: 1, opacity: .3}
                    offset: 1.0
                },
            ]
        }
    }
    var holder = Group{
        translateX: 640/2-350/2;
        translateY: 480/2-50
    }
    insert rect into holder.content;
    insert hgloss into holder.content;
    insert vgloss into holder.content;
    insert holder into group.content;
}


//animate functions...
function createColor(red:Number,green:Number,blue:Number,opacity:Number){
    return Color{
        red: zeroToOne(red)
        green: zeroToOne(green)
        blue: zeroToOne(blue)
        opacity: zeroToOne(opacity)
    }
}
public function createStop(color:Color,offset:Number):Stop{
    return Stop{
        color: color;
        offset: zeroToOne(offset)
    }
}
public function createLinearGradient(stops:Stop[]):LinearGradient{
    return LinearGradient{
        startX: 0
        endX: 1
        startY: 0
        endY: 0
        proportional: true
        stops: sortStops(stops);
    }
}
public function createLinearGradient(length:Number,stops:Stop[]):LinearGradient{
    return LinearGradient{
        startX: 0
        endX: length
        startY: 0
        endY: 0
        cycleMethod: CycleMethod.REPEAT
        proportional: false
        stops: sortStops(stops);
    }
}
public function createRadialGradient(centerX:Number, centerY:Number, stops:Stop[]):RadialGradient{
    return RadialGradient{
        centerX: centerX
        centerY: centerY
        stops: sortStops(stops)
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


public function zeroToOne(number:Number):Number{
    if (number > 1.0){
        var whole:Integer = Math.round(Math.floor(number));
        return number - whole;
    } else if (number < 0.0){
        var whole:Integer = Math.round(Math.floor(number));
        return (number - whole) + 1;
    } else {
        return number;
    }
}






