package me.bex.paynon.uitls.reader;

import org.springframework.stereotype.Component;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URL;

@Component
public class ImageReader {

    public byte[] readImage(String imageURL) throws IOException {
        URL url = new URL(imageURL);

        BufferedImage bufferedImage = ImageIO.read(url);

        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            ImageIO.write(bufferedImage, "png", baos);
            return baos.toByteArray();
        }
    }

}
