/*
 * BurnReplace.fx
 *
 * Created on Jul 27, 2009, 3:55:16 PM
 */

package org.lj.jfxe.chapter3.example5;

import javafx.scene.Node;
import javafx.animation.*;
import javafx.scene.Group;
import javafx.util.Sequences;
import javafx.animation.Interpolator;
import javafx.util.*;
import javafx.scene.effect.*;

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

    nodeToReplace.translateX = 0;
    nodeToReplace.translateY = 0;


    var brightness = 0.0;
    var blur = 0.0;

    delete nodeToReplace from parent.content;

    var holder = Group{
        translateX: startingX
        translateY: startingY
        content: [nodeToReplace]
        effect: ColorAdjust{
            brightness: bind brightness;
            input: GaussianBlur{
                radius: bind blur;
            }
        }
    }

    insert holder after parent.content[index];


    var t = Timeline{
        keyFrames: [
            KeyFrame{
                    time: 0s
                    values: [
                        brightness => 0.0 tween Interpolator.EASEBOTH,
                        blur => 0.0 tween Interpolator.EASEBOTH
                        ]
                },
                KeyFrame{
                    time: 1s
                    values: [
                        brightness => 1.0 tween Interpolator.EASEBOTH,
                        blur => 6.0 tween Interpolator.EASEBOTH
                       ]
                    action: function(){
                        delete holder.content;
                        replacementNode.translateX = 0.0;
                        replacementNode.translateY = 0.0;
                        insert replacementNode into holder.content;
                        nodeToReplace.translateX = startingX;
                        nodeToReplace.translateY = startingY;
                    }

                },
                KeyFrame{
                    time: 2s
                    values: [
                        brightness => 0.0 tween Interpolator.EASEBOTH,
                        blur => 0.0 tween Interpolator.EASEBOTH
                        ]
                    action: function(){
                        delete holder.content;
                        replacementNode.translateX = startingX;
                        replacementNode.translateY = startingY;
                        insert replacementNode before parent.content[index];
                    }
                },
                KeyFrame{
                    time: 2s + 1ms
                    action: doAfter
                }

            ]
    }
    t.play();
}