import cv2
import numpy as np
from matplotlib import pyplot as pl

#cap = cv2.VideoCapture(0)
cap = cv2.VideoCapture("wallcrack.mp4")
crack_det = None;


while (cap.isOpened()):
    ret1, frame = cap.read()
    gray = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    blur = cv2.GaussianBlur(gray,(9,9),0)
    ret2,thresh = cv2.threshold(blur,0,255, cv2.THRESH_BINARY+cv2.THRESH_OTSU)
    thresh2 = cv2.adaptiveThreshold(blur, 255, cv2.ADAPTIVE_THRESH_GAUSSIAN_C, cv2.THRESH_BINARY, 11, 2)
    thresh2 = cv2.bitwise_not(thresh2)
    dilated = cv2.dilate(thresh2,None,iterations=3)
    contours ,hier = cv2.findContours(dilated,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
    cv2.drawContours(frame ,contours,-1,(0,255,0),2)

    if (len(contours)) > 250 :
       crack_det = True
       color = (0,0,255)
    else :
       crack_det = False
       color = (0,0,0)



    font = cv2.FONT_HERSHEY_COMPLEX
    frame= cv2.putText(frame ,"crack_detected:"+str(crack_det),(100,100),font,1, color,2,cv2.LINE_AA)

    cv2.imshow('fig',frame)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()