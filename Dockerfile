FROM nginx:1.7

#Copy nginx config files
ADD Docker/nginx-conf /etc/nginx

# Copy nanoc data
ADD output /srv/www/ecarmi.org/prd
