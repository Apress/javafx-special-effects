/*
 * SplineEditor.fx
 *
 * Created on Sep 9, 2009, 3:52:39 PM
 */

package com.lj.jfxe.chapter5;

import javafx.scene.Group;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.animation.*;

/**
 * @author lucasjordan
 */

public class SplineEditor extends Group{
    public var viewer:InterpolatorViewer;
    var x1Slider = Slider{
        min: 0.0
        max: 1.0
        value: 0.2
    }
    var y1Slider = Slider{
        min: 0.0
        max: 1.0
        value: 0.8
    }
    var x2Slider = Slider{
        min: 0.0
        max: 1.0
        value: 0.8
    }
    var y2Slider = Slider{
        min: 0.0
        max: 1.0
        value: 0.2
    }

    var change = bind x1Slider.value + y1Slider.value + x2Slider.value + y2Slider.value on replace{
        viewer.interpolator = Interpolator.SPLINE(x1Slider.value, y1Slider.value, x2Slider.value, y2Slider.value);
    };

    init{
        var box1 = HBox{
            spacing: 10
            content: [x1Slider, Label{text:bind "x1 = {x1Slider.value}"}]
        }
        var box2 = HBox{
            spacing: 10
            content: [y1Slider, Label{text:bind "y1 = {y1Slider.value}"}]
        }
        var box3 = HBox{
            spacing: 10
            content: [x2Slider, Label{text:bind "x2 = {x2Slider.value}"}]
        }
        var box4 = HBox{
            spacing: 10
            content: [y2Slider, Label{text:bind "y2 = {y2Slider.value}"}]
        }

        var vbox = VBox{
            spacing: 10;
            content: [box1, box2, box3, box4]
        }
        insert vbox into content;
        viewer.interpolator = Interpolator.SPLINE(x1Slider.value, y1Slider.value, x2Slider.value, y2Slider.value);
    }

}
