
# ServiceInspection

A simple application for monitoring Iris service information

# How to install

## IPM
 install ServiceInspection
 Need to download the following Python package
 xlutils
 xlrd
 psutil
 reportlab
## docker 
$ git clone https://github.com/oliavrwolis/ServiceInspection.git
execute docker-compose up
# How To USE

access  http://ip:52773//csp/user/XunJian.Page.MainPage.cls

Can view current service information, including server information, queues, etc
 
Implemented from idea: https://ideas.intersystems.com/ideas/DPI-I-458

# 2024/12/13 Update log

1. Add two inspection items

![image](https://github.com/user-attachments/assets/591ff08a-68c9-404e-b86c-ac5ea24860e3)



2. Add a configuration page to set the threshold for inspection items and whether to push alarm information to the email image configuration;

![dda286e40eed22227d5961bea0d6d07](https://github.com/user-attachments/assets/60f9fcf1-146a-40f3-8b80-0e4d72d360f1)



3. Add a detail page that displays detailed information about component queues and inactive duration

   ![image](https://github.com/user-attachments/assets/f207dc62-1400-4efe-b9ff-e662ffe452e1)


4. Add email alerts (requiring self configured email addresses), and send an alert email to the designated email address when the value exceeds the threshold

   ![7b71037dab9c3fd35fd845b3d60b130](https://github.com/user-attachments/assets/5e153001-0c54-4626-8972-bf3a0dcc0392)

