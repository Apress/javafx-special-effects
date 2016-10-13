/*
 * QuadraticEditor.fx
 *
 * Created on Sep 8, 2009, 1:31:32 PM
 */

package com.lj.jfxe.chapter5;

import javafx.scene.Group;
import javafx.scene.control.Slider;
import javafx.scene.layout.*;
import javafx.scene.text.Text;
import javafx.scene.paint.Color;

/**
 * @author lucasjordan
 */

public class QuadraticEditor extends Group{
    public var interpolator:QuadraticInterpolator = QuadraticInterpolator{a: -1.09};
    public var viewer:InterpolatorViewer;

    var aSlider = Slider{
        min: 0.0
        max: 10.0
        value: -1.09 + 5;
    }
    var aValue = bind aSlider.value - 5.0 on replace{
        interpolator.a = aValue;
        viewer.draw();
    }


    init{
        var box1 = HBox{
            content:[Text{
                        content: "Adjust 'a' Value: "
                    },
                    aSlider]
        }
        var box2 = VBox{
            content:[
                Text{
                   content: bind "a =  {aValue}"
                },
                Text{
                   content: bind "b =  { 1.0 - aValue}"
                }]
        }

        var vbox = VBox{
            content: [box1, box2]
        }

        insert vbox into content;
        viewer.interpolator = interpolator;
    }

}
