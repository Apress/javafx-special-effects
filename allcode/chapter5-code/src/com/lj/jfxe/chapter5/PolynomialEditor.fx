/*
 * PolynomialEditor.fx
 *
 * Created on Sep 8, 2009, 3:45:06 PM
 */

package com.lj.jfxe.chapter5;

import javafx.scene.Group;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.input.MouseEvent;

/**
 * @author lucasjordan
 */

public class PolynomialEditor extends Group{
    public var viewer:InterpolatorViewer;
    public var interpolator:PolynomialInterpolator = PolynomialInterpolator{
                            coefficients: [5.06, -16.99, 20.0, -14.28, 20.0, -12.78]
                        }

    var sliders:Slider[];
    var radios:RadioButton[];
    var listeners:SliderListener[];

    var toggleGroup = ToggleGroup{}

    var range = 20.0;


    init{
        var vbox = VBox{
            spacing: 5
        }

        for (index in [0..(sizeof interpolator.coefficients)-1]){
            var radio = RadioButton{
                toggleGroup: toggleGroup;
                onMouseReleased: function(event:MouseEvent):Void{
                    interpolator.solveFor = index;
                    for (slider in sliders){
                        slider.disable = false;
                    }
                    sliders[index].disable = true;
                }

            }
            insert radio into radios;

            var label = Label{
                text: "{index}"
            }

            var slider = Slider{
                min: 0.0
                max: range*2.0
                value: interpolator.coefficients[index]+range;
            }

            var listener = SliderListener{
                index: index;
                value: bind slider.value - range;
            }

            insert listener into listeners;
            
            var valueLabel = Label{
                text: bind "{interpolator.coefficients[index]}"
            }

            var box = HBox{
                    spacing: 5
                content: [radio,label, slider,valueLabel]
            }
            insert box into vbox.content;
        }
        toggleGroup.buttons[0].selected = true;
        insert vbox into content;
        viewer.interpolator = interpolator;
    }

}

class SliderListener {
    public var index:Integer;
    public var value:Number on replace{
        interpolator.coefficients[index] = value;
        sliders[interpolator.solveFor].value = interpolator.coefficients[interpolator.solveFor] + range;
        viewer.draw();
    }
}
