import cv2
import numpy as np 
import glob

def blue(img):

	for i in range(0,256):
		for j in range(0,256):
			img[i][j][1]=0
			img[i][j][2]=0

	return img

def green(img):

	for i in range(0,256):
		for j in range(0,256):
			img[i][j][0]=0
			img[i][j][2]=0

	return img

def red(img):

	for i in range(0,256):
		for j in range(0,256):
			img[i][j][0]=0
			img[i][j][1]=0

	return img		

if __name__ == '__main__':		
	
	i=0
	for img in glob.glob("glaucoma/*.png"):
		cv_img = cv2.imread(img)
		cv_img = cv2.resize(cv_img,(256,256))

		print(cv_img.shape)

		img2 = cv_img.copy();
		img3 = cv_img.copy();
		img4 = cv_img.copy();

		img2=red(img2)
		img3=green(img3)
		img4=blue(img4)

		#cv2.imshow("red channel",img2)
		cv2.imwrite("red_channel_"+str(i)+".jpg", img2)

		#cv2.imshow("green channel",img3)
		cv2.imwrite("green_channel_"+str(i)+".jpg", img3)

		#cv2.imshow("blue channel",img4)
		cv2.imwrite("blue_channel_"+str(i)+".jpg", img4)

		i+=1
		cv2.waitKey(0)



