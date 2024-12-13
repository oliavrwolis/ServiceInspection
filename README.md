
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

# Update log

1. Add two inspection items



2. Add a configuration page to set the threshold for inspection items and whether to push alarm information to the email image configuration;

   

3. Add a detail page that displays detailed information about component queues and inactive duration

4. Add email alerts (requiring self configured email addresses), and send an alert email to the designated email address when the value exceeds the threshold
