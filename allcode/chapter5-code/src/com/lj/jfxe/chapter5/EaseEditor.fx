/*
 * EaseEditor.fx
 *
 * Created on Sep 10, 2009, 3:50:33 PM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.*;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;

/**
 * @author lucasjordan
 */

public class EaseEditor extends Group{
    public var viewer:InterpolatorViewer;

    init{
        var toggleGroup = ToggleGroup{}

         var radio1 = RadioButton{
            toggleGroup: toggleGroup
            text: "Ease Out";
            onMouseReleased: function(event:MouseEvent):Void{
                viewer.interpolator = Interpolator.EASEOUT;
                viewer.draw();
            }
            selected: true;
        }

        var radio2 = RadioButton{
            toggleGroup: toggleGroup
            text: "Ease In";
            onMouseReleased: function(event:MouseEvent):Void{
                viewer.interpolator = Interpolator.EASEIN;
                viewer.draw();
            }
        }

        var radio3 = RadioButton{
            toggleGroup: toggleGroup
            text: "Ease Both";
            onMouseReleased: function(event:MouseEvent):Void{
                viewer.interpolator = Interpolator.EASEBOTH;
                viewer.draw();
            }
        }
        
        var box = VBox{
            spacing: 4;
            content: [radio1, radio2, radio3]
        }

        insert box into content;
        viewer.interpolator = Interpolator.EASEOUT;
    }
}
