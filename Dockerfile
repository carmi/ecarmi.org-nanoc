FROM nginx:1.7

#Copy nginx config files
ADD Docker/nginx-conf /etc/nginx

# Copy nanoc data
ADD output /srv/www/ecarmi.org/prd

# Instructions
# BUILD:
#   docker build -t ecarmi_org_nginx github.com/carmi/ecarmi.org-nanoc
# RUN:
#   docker run --name ecarmi_org_nginx -d ecarmi_org_nginx
