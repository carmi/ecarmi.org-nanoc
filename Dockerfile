FROM nginx:1.7

#Copy nginx config files
ADD Docker/nginx-conf /etc/nginx

# Instructions
# BUILD:
#   docker build -t ecarmi_org_nginx github.com/carmi/ecarmi.org-nanoc
# RUN:
#   docker run --name ecarmi_org_nginx -d --restart=always -p $ECARMI_ORG_1_PORT:80 -v /srv/ecarmi_org/output:/srv/www/ecarmi.org/prd ecarmi_org_nginx
