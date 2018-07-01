package com.yangzi.fullR.util;

import java.io.File;
import java.io.IOException;

import javax.sound.sampled.AudioFileFormat;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.UnsupportedAudioFileException;

public class SoundUtil {
  
	
	
	public static void wavToPcm(String wavFilePath){
		
			 try  
		        {  
		            File wavFile=new File(wavFilePath);  
		            AudioInputStream sourceAudioInputStream=AudioSystem.getAudioInputStream(wavFile);  
		            // 此处的转换必需是16bit的音频文件  
		            AudioInputStream targetAudioInputStream=AudioSystem.getAudioInputStream(AudioFormat.Encoding.ULAW,  
		                    sourceAudioInputStream);  
		            String newFilePath=wavFilePath.substring(0,wavFilePath.lastIndexOf(".")+1)+"pcm";  
		            AudioSystem.write(targetAudioInputStream,AudioFileFormat.Type.WAVE,new File(newFilePath));  
		        }  
		        catch(UnsupportedAudioFileException e)  
		        {  
		            System.out.println(e.getMessage());  
		            e.printStackTrace();  
		        }  
		        catch(IOException e)  
		        {  
		            System.out.println(e.getMessage());  
		            e.printStackTrace();  
		        }  
         	}
	
	public static synchronized void wavToPcm2(String wavFilePath){
		
		try  
		{  
			File wavFile=new File(wavFilePath);  
			AudioInputStream sourceAudioInputStream=AudioSystem.getAudioInputStream(wavFile);  
			// 此处的转换必需是16bit的音频文件  
			AudioInputStream targetAudioInputStream=AudioSystem.getAudioInputStream(AudioFormat.Encoding.ULAW,  
					sourceAudioInputStream);  
			String newFilePath=wavFilePath.substring(0,wavFilePath.lastIndexOf(".")+1)+"pcm";  
			AudioSystem.write(targetAudioInputStream,AudioFileFormat.Type.WAVE,new File(newFilePath));  
		}  
		catch(UnsupportedAudioFileException e)  
		{  
			System.out.println(e.getMessage());  
			e.printStackTrace();  
		}  
		catch(IOException e)  
		{  
			System.out.println(e.getMessage());  
			e.printStackTrace();  
		}  
	}
	
	/** 
     * 获取音频文件的编码格式  
     * @param wavFilePath 音频文件格式 
     * @return String 
     */  
    public static String getWavFormat(String wavFilePath)  
    {  
        File wavFile=new File(wavFilePath);  
        AudioInputStream ais;  
        String result="";  
        try  
        {  
            ais=AudioSystem.getAudioInputStream(wavFile);  
            AudioFormat af=ais.getFormat();  
            result=af.toString();  
        }  
        catch(UnsupportedAudioFileException e)  
        {  
            System.out.println(e.getMessage());  
            e.printStackTrace();  
        }  
        catch(IOException e)  
        {  
            System.out.println(e.getMessage());  
            e.printStackTrace();  
        }  
        return result;  
    }  
    public static void main(String[] args)  
    {  
//        System.out.println(SoundUtil.getWavFormat("E://syl//C//test.wav"));  
        SoundUtil.wavToPcm("E://syl//C//test.wav");  
    }  
	
	
	
}
