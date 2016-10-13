/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.lj.jfxe.chapter1;

import javax.swing.JFrame;
import javax.swing.UIManager;

/**
 *
 * @author lucasjordan
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try{
            //UIManager.setLookAndFeel("com.sun.java.swing.plaf.motif.MotifLookAndFeel");
            //UIManager.setLookAndFeel("com.sun.java.swing.plaf.gtk.GTKLookAndFeel");
            UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());

            ExampleFrame frame = new ExampleFrame();
            frame.setTitle("CrossPlatformLookAndFeel");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.setVisible(true);
        }catch(Exception e){
            e.printStackTrace();
            System.exit(1);
        }
    }

}
