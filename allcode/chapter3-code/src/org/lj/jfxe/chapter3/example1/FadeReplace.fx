/*
 * FadeTransition.fx
 *
 * Created on Jul 15, 2009, 5:55:07 PM
 */

package org.lj.jfxe.chapter3.example1;

import javafx.scene.Node;
import javafx.animation.*;
import javafx.scene.Group;
import javafx.util.Sequences;

/**
 * @author lucasjordan
 */

public function doReplace(nodeToReplace:Node,replacementNode:Node,doAfter:function()):Void{
    var parent:Group = (nodeToReplace.parent as Group);

    var origNodeToReplaceOpacity = nodeToReplace.opacity;
    var origReplacementNodeOpacity = replacementNode.opacity;


    replacementNode.translateX = nodeToReplace.translateX;
    replacementNode.translateY = nodeToReplace.translateY;

    var index = Sequences.indexOf(parent.content, nodeToReplace);
    insert replacementNode before parent.content[index];

    var t = Timeline{
        keyFrames: [
                KeyFrame{
                    time: 0s
                    values: [
                        replacementNode.opacity => 0.0 tween Interpolator.EASEBOTH
                        ]
                }

                KeyFrame{
                    time: 1s
                    values: [
                        nodeToReplace.opacity => 0.0 tween Interpolator.EASEBOTH,
                        replacementNode.opacity => origReplacementNodeOpacity tween Interpolator.EASEBOTH
                        ]
                    action: function(){
                        delete nodeToReplace from parent.content;
                        nodeToReplace.opacity = origNodeToReplaceOpacity;
                        doAfter();
                    }
                }
            ]
    }
    t.play();
}

