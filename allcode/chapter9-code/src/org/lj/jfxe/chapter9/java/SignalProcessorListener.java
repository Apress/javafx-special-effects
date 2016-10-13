/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lj.jfxe.chapter9.java;

/**
 *
 * @author lucasjordan
 */
public interface SignalProcessorListener {
    void process( float[] leftChannel, float[] rightChannel, float frameRateRatioHint );
}
