/*
 * Main.fx
 *
 * Created on Sep 1, 2009, 10:38:43 PM
 */

package com.lj.jfxe.chapter4;

import javafx.stage.Stage;
import javafx.scene.*;
import javafx.scene.shape.*;
import javafx.scene.paint.Color;
import javafx.animation.*;
import javafx.scene.text.*;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.effect.*;
import javafx.scene.effect.light.*;
import javafx.util.Math;

/**
 * @author lucasjordan
 */

var exampleGroup = Group{};

public function run():Void{

    var sampleButton = Button{
        text: "Sample Lights";
        action: sampleLights;
    }
    var distantButton = Button{
        text: "Distant Light";
        action: distantLight;
    }
    var pointButton = Button{
        text: "Point Light";
        action: pointLight;
    }
    var spotButton = Button{
        text: "Spot Light";
        action: spotLight;
    }
    var withButton = Button{
        text: "Shadow";
        action: withShadow;
    }
    var topBox = HBox{
        translateX: 64
        translateY: 16
        spacing: 16
        content: [sampleButton, distantButton, pointButton, spotButton, withButton]
    }

    Stage {
        title: "Chapter 4"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.BLACK
            content: [topBox,exampleGroup]
        }
    }
}

function reset(){
    delete exampleGroup.content;
    exampleGroup.scene.fill = Color.BLACK;
}

function sampleLights():Void{
    reset();

    var rect1 = Rectangle{
        width: 100
        height: 100
        fill: Color.WHITE
        effect: Lighting{
            light: DistantLight{azimuth: 180.0, elevation: 45.0, color: Color.RED}
            surfaceScale: 4;
        }
    }

    var rect2 = Rectangle{
        width: 100
        height: 100
        fill: Color.WHITE
        effect: Lighting{
            light: PointLight{x: 50.0, y: 50.0, z: 20.0, color: Color.GREEN}
            surfaceScale: 4;
        }
    }

    var rect3 = Rectangle{
        width: 100
        height: 100
        fill: Color.WHITE
        effect: Lighting{
            light: SpotLight{x: 50.0, y: 30.0, z: 20.0, pointsAtX: 50.0, pointsAtY: 100.0, color: Color.BLUE}
            surfaceScale: 4;
        }
    }


    var box = HBox{
        translateX: 96
        translateY: 190
        spacing: 64
        content:[rect1, rect2, rect3]
    }

    insert box into exampleGroup.content;
}

function distantLight():Void{
    reset();

    var elev = 0.0;
    var azim = 0.0;

    var lighting = Lighting {
        light: DistantLight { azimuth: bind azim, elevation: bind elev  }
        surfaceScale: 3
    }

    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE
        autoReverse: true
        keyFrames: [
            KeyFrame{time: 0s, values: elev=>0.0},
            KeyFrame{time: 5s, values: elev=>180.0},
            KeyFrame{time: 7.5s, values: elev=>160.0},
            KeyFrame{time: 7.5s, values: azim=>0.0},
            KeyFrame{time: 12.5s, values: azim=>360.0}
          ]
    }


    var text = Text{
        content: "Example Text"
        font: Font{
            size: 78
        }
        fill: Color.GRAY
    }

    var group = Group{
            content:text
            effect:lighting
            translateX: 640/2.0 - text.boundsInParent.width/2.0
            translateY: 480/2.0
    }

    anim.play();
    insert group into exampleGroup.content;
}

function spotLight():Void{
    reset();

    var rectSize = 300;
    var half = rectSize/2.0;

    var x = 30.0;
    var y = 60.0;
    var z = 10.0;
    var atX = half;
    var atY = half;

    var rect1 = Rectangle{
        width: rectSize
        height: rectSize
        fill: Color.GRAY
        effect: Lighting {
            light: SpotLight{
                    x: bind x,
                    //y: bind rectSize - y + 20, <-- in case of bug. see side bar
                    y: bind y,
                    z: bind z
                    pointsAtX: bind atX;
                    pointsAtY: bind rectSize - atY + 20
            }
            specularConstant: 0.0
            specularExponent: 1.0
            surfaceScale: 0
        }
    }

    var dot1 = Circle{
        radius: 2;
        translateX: bind x
        translateY: bind y;
        scaleX: bind 1.0 + (z/50.0);
        scaleY: bind 1.0 + (z/50.0);
        fill: Color.BLUE;
    }
    var dot2 = Rectangle{
        width: 4;
        height: 4;
        translateX: bind atX - 2
        translateY: bind atY - 2;
        fill: Color.RED;
    }

    var animation = Timeline{
        repeatCount: Timeline.INDEFINITE
        autoReverse: true;
        keyFrames: [
            KeyFrame{time:0s,values:[x=>half,y=>half,z=>20.0,atX=>half,atY=>half]},
            KeyFrame{time:2s,values:[atX=>half/2.0,atY=>half]},
            KeyFrame{time:8s,values:[atX=>half/2.0*3]},
            KeyFrame{time:5s,values:[atY=>half/2.0]},
            KeyFrame{time:8s,values:[x=>half,y=>half,z=>20.0,atY=>half/2.0*3]},
            KeyFrame{time:10s,values:[x=>half,y=>half,z=>20.0,atX=>half,atY=>half]},
            KeyFrame{time:12s,values:[x=>half,y=>half,z=>50.0]},
            KeyFrame{time:14s,values:[x=>half/2.0,y=>half,z=>50.0]},
            KeyFrame{time:16s,values:[x=>half/2.0,y=>half/2.0,z=>50.0]},
            KeyFrame{time:18s,values:[x=>half/2.0*3,y=>half/2.0*3,z=>50.0]}
        ]
    }

    var group = Group{
            translateX: 640/2.0 - rectSize/2.0
            translateY: 480/2.0 - rectSize/2.0
            content:[rect1,dot2,dot1]
    }

    insert group into exampleGroup.content;
    animation.play();
}

function pointLight():Void{
    reset();

    var rectSize = 300;

    var x = 30.0;
    var y = 60.0;
    var z = 10.0;

    var rect1 = Rectangle{
        width: rectSize
        height: rectSize
        fill: Color.GRAY
        effect: Lighting {
            light: PointLight{
                    x: bind x,
                    //y: bind rectSize - y + 20, <-- in case of bug. see side bar
                    y: bind y,
                    z: bind z
            }
            specularConstant: 0.0
            specularExponent: 1.0
            surfaceScale: 0

        }
    }

    var dot = Circle{
        radius: 2;
        translateX: bind x
        translateY: bind y;
        scaleX: bind 1.0 + (z/50.0);
        scaleY: bind 1.0 + (z/50.0);
        fill: Color.BLUE;
    }

    var half = rectSize/2.0;

    var animation = Timeline{
        repeatCount: Timeline.INDEFINITE
        autoReverse: true;
        keyFrames: [
                KeyFrame{time:0s,values:[x=>0.0,y=>0.0,z=>0.0]},
                KeyFrame{time:2s,values:[x=>0.0,y=>0.0,z=>10.0]},
                KeyFrame{time:4s,values:[x=>half,y=>0.0,z=>10.0]},
                KeyFrame{time:6s,values:[x=>half,y=>half,z=>10.0]},
                KeyFrame{time:7s,values:[x=>half,y=>half,z=>0.0]},
                KeyFrame{time:9s,values:[x=>half,y=>half,z=>100.0]},
                KeyFrame{time:11s,values:[x=>rectSize,y=>half,z=>30.0]},
                KeyFrame{time:13s,values:[x=>rectSize,y=>rectSize,z=>0.0]},
                KeyFrame{time:16s,values:[x=>half,y=>half,z=>100.0]},
                KeyFrame{time:19s,values:[x=>0.0,y=>0.0,z=>0.0]}
            ]
    }

    var group = Group{
            translateX: 640/2.0 - rectSize/2.0
            translateY: 480/2.0 - rectSize/2.0
            content:[rect1,dot]
    }

    insert group into exampleGroup.content;
    animation.play();
}

function withShadow():Void{
    reset();
    exampleGroup.scene.fill = Color.WHITE;

    var size = 140;
    var asim = 0.0;

    var rect = Rectangle{
        translateX: 70;
        translateY: 100;
        width: size;
        height: size;
        fill: Color.DARKCYAN
        effect: Lighting{
            light: DistantLight{elevation: 45.0, azimuth: bind asim}
            surfaceScale: 6
        }
    }

    var circle = Circle{
        translateX:  480;
        translateY:  200;
        radius: size/2.0;
        fill: Color.DARKMAGENTA
        effect: Lighting{
            light: DistantLight{elevation: 45.0, azimuth: bind asim}
            surfaceScale: 6
        }
    }

    var halfCos30 = Math.cos(Math.toRadians(30.0))/2.0;

    var triangle = Polygon{
        translateX:  640/2.0-10;
        translateY:  320/2.0+170;
        points:[0.0, -size*halfCos30, -.5*size, size*halfCos30, .5*size, size*halfCos30]
        fill: Color.GOLD
        effect: Lighting{
            light: DistantLight{elevation: 45.0, azimuth: bind asim}
            surfaceScale: 6
        }
    }

    var group = Group{
            effect: DropShadow{
                offsetX: bind -Math.cos(Math.toRadians(asim)) * 15.0;
                offsetY: bind -Math.sin(Math.toRadians(asim)) * 15.0;
                color: Color.GRAY
                spread: 0.1
            }
            content:[rect,circle,triangle]
    }

    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE;
        autoReverse: true;
        keyFrames: [
                KeyFrame{
                    time: 0s
                    values: asim => 0.0
                },
                KeyFrame{
                    time: 5s
                    values: asim => 360.0
                },
                ]
    }


    insert group into exampleGroup.content;
    anim.play();
    
}




