package com.example.demo;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
@Controller
public class SquareController {
    public static final String uploadingDir = System.getProperty("user.dir") + "/uploadingDir/";
    @ResponseBody
    @RequestMapping(value = "/square", method = RequestMethod.POST,produces = MediaType.IMAGE_JPEG_VALUE)
    public byte[] uploadingPost(@RequestParam("uploadingFiles") MultipartFile[] uploadingFiles, @RequestParam("size") String size) throws IOException {
           MultipartFile uploadedFile = uploadingFiles[0];

            File convFile = new File( uploadingDir+uploadedFile.getOriginalFilename());
            uploadedFile.transferTo(convFile);
            int newSize = Integer.valueOf(size);
            BufferedImage originalImage=ImageIO.read(convFile);
            BufferedImage newImage = new BufferedImage(newSize, newSize, BufferedImage.TYPE_INT_RGB);

            Graphics g = newImage.createGraphics();
            g.drawImage(originalImage, 0, 0, newSize,newSize,null);
            g.dispose();
            ByteArrayOutputStream baos=new ByteArrayOutputStream();
            ImageIO.write(newImage, "jpg", baos );
            return baos.toByteArray();





    }
}
