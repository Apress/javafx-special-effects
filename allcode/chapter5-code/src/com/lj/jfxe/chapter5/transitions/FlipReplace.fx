/*
 * SlideReplace.fx
 *
 * Created on Jul 15, 2009, 6:35:59 PM
 */

package com.lj.jfxe.chapter5.transitions;

import javafx.scene.Node;
import javafx.scene.Group;
import javafx.util.Sequences;
import javafx.scene.effect.*;
import javafx.animation.*;
import javafx.util.Math;

/**
 * @author lucasjordan
 */

public function doReplace(nodeToReplace:Node,replacementNode:Node,interpolator:Interpolator,doAfter:function()):Void{
    var parent:Group = (nodeToReplace.parent as Group);

    var index = Sequences.indexOf(parent.content, nodeToReplace);


    var startingX = nodeToReplace.translateX;
    var startingY = nodeToReplace.translateY;
    var minX = nodeToReplace.boundsInLocal.minX;
    var minY = nodeToReplace.boundsInLocal.minY;

    var startWidth = nodeToReplace.boundsInLocal.width;
    var startHeight = nodeToReplace.boundsInLocal.height;



    delete nodeToReplace from parent.content;

    nodeToReplace.translateX = 0;
    nodeToReplace.translateY = 0;

    var radius = startWidth/2.0;
    var angle = 0.0;
    var back = startHeight/10.0;

    var lx = bind radius - Math.sin(Math.toRadians(angle))*radius;
    var rx = bind radius + Math.sin(Math.toRadians(angle))*radius;
    var uly = bind 0 - Math.cos(Math.toRadians(angle))*back;
    var ury = bind 0 + Math.cos(Math.toRadians(angle))*back;



    var perspective = PerspectiveTransform{
        ulx: bind lx
        uly: bind uly
        urx: bind rx
        ury: bind ury
        lrx: bind rx
        lry: bind startHeight + uly
        llx: bind lx
        lly: bind startHeight + ury
    }

    var holder = Group{
        translateX: startingX + minX
        translateY: startingY + minY
        content: [nodeToReplace]
        effect: perspective

    }

    insert holder before parent.content[index];


    var timeline = Timeline{
        keyFrames: [
            KeyFrame{
                time: 0s;
                values: [
                    angle => 90.0 tween interpolator
                    ]
            },
            KeyFrame{
                time: 0.5s;
                values: [
                    angle => 0.0
                    ]
                    action: function(){
                        delete holder.content;
                        insert replacementNode into holder.content
                    }

            },
            KeyFrame{
                time: 0.5s+1ms;
                values: [
                    angle => 180.0
                    ]

            },
            KeyFrame{
                time: 1s;
                values: [
                    angle => 90.0 tween interpolator
                    ]
                    action: function(){
                        delete holder.content;
                        replacementNode.translateX = startingX;
                        replacementNode.translateY = startingY;
                        insert replacementNode before parent.content[index];
                    }
            }
            KeyFrame{
                time: 1s+1ms;
                action: doAfter
            }
            ]
    }

    timeline.play();
}
