/*
 * CubicEditor.fx
 *
 * Created on Sep 8, 2009, 2:06:37 PM
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

public class CubicEditor extends Group{
    public var interpolator:CubicInterpolator = CubicInterpolator{a: 5.18797, b: -7.894737}
    public var viewer:InterpolatorViewer;

    var aSlider = Slider{
        min: 0.0
        max: 20.0
        value: 5.18797 + 10.0;
    }
    var aValue = bind aSlider.value - 10.0 on replace{
        interpolator.a = aValue;
        viewer.draw();
    }

    var bSlider = Slider{
        min: 0.0
        max: 20.0
        value: -7.894737 + 10.0;
    }
    var bValue = bind bSlider.value - 10.0 on replace{
        interpolator.b = bValue;
        viewer.draw();
    }


    init{
        var box1 = HBox{
            content:[Text{
                        content: "Adjust 'a' Value: "
                    },
                    aSlider]
        }
        var box2 = HBox{
            content:[Text{
                        content: "Adjust 'b' Value: "
                    },
                    bSlider]
        }
        var box3 = VBox{
            content:[
                Text{
                   content: bind "a =  {aValue}"
                },
                Text{
                   content: bind "b =  {bValue}"
                },
                Text{
                   content: bind "c =  { 1.0 - aValue - bValue}"
                }]
        }

        var vbox = VBox{
            content: [box1, box2, box3]
        }

        insert vbox into content;
        viewer.interpolator = interpolator;
    }

}