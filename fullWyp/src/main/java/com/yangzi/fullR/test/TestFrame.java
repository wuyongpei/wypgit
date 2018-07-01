package com.yangzi.fullR.test;

import java.awt.Graphics;
import java.awt.GridLayout;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class TestFrame extends JFrame{

	 private JPanel[] panels = new JPanel[4];
     
	    public TestFrame()
	    {
	        this.setLayout(new GridLayout(2, 2, 0, 0));
	        initPanels();
	        for (int i = 0; i < panels.length; i++)
	        {
	            add(panels[i]);
	        }           
	    }
	     
	    private void initPanels()
	    {
	        for (int i = 0; i < panels.length; i++)
	        {
	            panels[i] = new TestPanel(i + ".jpg");
	        }
	    }
	     
	    public static void main(String[] args)
	    {
	        JFrame frame = new TestFrame();
	        frame.setSize(400, 300);
	        frame.setVisible(true);
	        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	    }	
	
}
class TestPanel extends JPanel
{
    private String fileName;
     
    public TestPanel(String fileName)
    {
        this.fileName = fileName;
    }
     
    public void paintComponent(Graphics g)
    {
        ImageIcon icon = new ImageIcon(fileName);
        g.drawImage(icon.getImage(), 0, 0, getWidth(), getHeight(), null);
    }
}