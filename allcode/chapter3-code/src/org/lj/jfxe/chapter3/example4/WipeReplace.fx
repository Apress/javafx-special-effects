/*
 * StarWipeReplace.fx
 *
 * Created on Jul 22, 2009, 6:34:21 PM
 */

package org.lj.jfxe.chapter3.example4;

import javafx.scene.Node;
import javafx.animation.*;
import javafx.scene.Group;
import javafx.util.Sequences;
import javafx.animation.Interpolator;
import javafx.scene.shape.*;
import javafx.util.*;

/**
 * @author lucasjordan
 */

public function doReplace(nodeToReplace:Node,replacementNode:Node,doAfter:function()):Void{
    var parent:Group = (nodeToReplace.parent as Group);

    var index = Sequences.indexOf(parent.content, nodeToReplace);


    var startingX = nodeToReplace.translateX;
    var startingY = nodeToReplace.translateY;
    var minX = nodeToReplace.boundsInLocal.minX;
    var minY = nodeToReplace.boundsInLocal.minY;

    var startWidth = nodeToReplace.boundsInLocal.width;
    var startHeight = nodeToReplace.boundsInLocal.height;

    replacementNode.translateX = 0;
    replacementNode.translateY = 0;

    var radius = 0.0;
    var maxRadius = Math.sqrt(Math.pow(startWidth/2.0, 2) + Math.pow(startHeight/2.0, 2));
    
    var clip = Circle{
        translateX: startWidth/2.0;
        translateY: startHeight/2.0;
        radius: bind radius;
    }

    var holder = Group{
        translateX: startingX
        translateY: startingY
        content: [Circle{
            translateX: startWidth/2.0;
            translateY: startHeight/2.0;
            opacity: 0.0;
            radius: maxRadius;
        },replacementNode]
        clip: clip;
    }

    insert holder after parent.content[index];


    var t = Timeline{
        keyFrames: [
            KeyFrame{
                    time: 0s
                    values: radius => 0.0 tween Interpolator.EASEBOTH
                },
                KeyFrame{
                    time: 1s
                    values: radius => maxRadius tween Interpolator.EASEBOTH
                    action: function(){
                        delete nodeToReplace from parent.content;
                        delete holder.content;
                        replacementNode.translateX = startingX;
                        replacementNode.translateY = startingY;
                        insert replacementNode before parent.content[index];
                        doAfter();
                    }
                }

            ]
    }
    t.play();
}

