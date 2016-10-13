/*
 * WindupOvershootEditor.fx
 *
 * Created on Sep 10, 2009, 9:16:56 AM
 */

package com.lj.jfxe.chapter5;

import javafx.scene.Group;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import com.lj.jfxe.chapter5.WindupOvershootInterpolator;
import javafx.scene.input.MouseEvent;

/**
 * @author lucasjordan
 */

public class WindupOvershootEditor extends Group{
    public var viewer:InterpolatorViewer;

    init{
        var toggleGroup = ToggleGroup{}
        var radio1 = RadioButton{
            toggleGroup: toggleGroup
            text: "Overshoot";
            onMouseReleased: function(event:MouseEvent):Void{
                viewer.interpolator = WindupOvershootInterpolator.OVERSHOOT;
                viewer.draw();
            }
            selected: true;
        }
        var radio2 = RadioButton{
            toggleGroup: toggleGroup
            text: "Windup";
            onMouseReleased: function(event:MouseEvent):Void{
                viewer.interpolator = WindupOvershootInterpolator.WINDUP;
                viewer.draw();
            }
        }
        var radio3 = RadioButton{
            toggleGroup: toggleGroup
            text: "Windup & Overshoot";
            onMouseReleased: function(event:MouseEvent):Void{
                viewer.interpolator = WindupOvershootInterpolator.WINDUP_OVERSHOOT;
                viewer.draw();
            }
        }

        var box = VBox{
            spacing: 3
            content: [radio1, radio2, radio3]
        }
        insert box into content;
        viewer.interpolator = WindupOvershootInterpolator.OVERSHOOT;
    }

}
