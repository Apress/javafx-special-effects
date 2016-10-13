/*
 * StepEditor.fx
 *
 * Created on Sep 9, 2009, 5:15:53 PM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.*;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import com.lj.jfxe.chapter5.WindupOvershootInterpolator;

/**
 * @author lucasjordan
 */

public class StepEditor extends Group{
    public var interpolator:StepInterpolator;
    public var viewer:InterpolatorViewer;

    var slider = Slider{
        min: 2
        max: 20
        value: interpolator.steps
    }

    var onchange = bind slider.value on replace{
        interpolator.steps = slider.value as Integer;
        viewer.draw();
    }


    init{
        var toggleGroup = ToggleGroup{}

        var label = Label{
            text: bind "Steps: {interpolator.steps}"
        }


        var hbox = HBox{
            spacing: 3;
            content: [slider, label]
        }

        var radio1 = RadioButton{
            toggleGroup: toggleGroup
            text: "Linear";
            onMouseReleased: function(event:MouseEvent):Void{
                interpolator.interpolator = Interpolator.LINEAR;
                viewer.draw();
            }
            selected: true;
        }

        

        var radio2 = RadioButton{
            toggleGroup: toggleGroup
            text: "Ease Both";
            onMouseReleased: function(event:MouseEvent):Void{
                interpolator.interpolator = Interpolator.EASEBOTH;
                viewer.draw();
            }
        }

        var radio3 = RadioButton{
            toggleGroup: toggleGroup
            text: "Spline";
            onMouseReleased: function(event:MouseEvent):Void{
                interpolator.interpolator = Interpolator.SPLINE(0.8, 0.2, 0.2, 0.8);
                viewer.draw();
            }
        }

        var radio4 = RadioButton{
            toggleGroup: toggleGroup
            text: "Quadratic";
            onMouseReleased: function(event:MouseEvent):Void{
                interpolator.interpolator = QuadraticInterpolator{a: -1.09};
                viewer.draw();
            }
        }

        var radio5 = RadioButton{
            toggleGroup: toggleGroup
            text: "Cibic";
            onMouseReleased: function(event:MouseEvent):Void{
                interpolator.interpolator = CubicInterpolator{a: 5.18797, b: -7.894737};
                viewer.draw();
            }
        }

        var radio6 = RadioButton{
            toggleGroup: toggleGroup
            text: "Polynomial";
            onMouseReleased: function(event:MouseEvent):Void{
                interpolator.interpolator = PolynomialInterpolator{
                            coefficients: [5.06, -16.99, 20.0, -14.28, 20.0, -12.78]
                        }
                viewer.draw();
            }
        }

        var radio7 = RadioButton{
            toggleGroup: toggleGroup
            text: "Windup/Overshoot";
            onMouseReleased: function(event:MouseEvent):Void{
                interpolator.interpolator = WindupOvershootInterpolator.WINDUP_OVERSHOOT;
                viewer.draw();
            }
        }

        var box = VBox{
            spacing: 2;
            content: [hbox, radio1, radio2, radio3, radio4, radio5, radio6, radio7]
        }

        insert box into content;


    }

}
