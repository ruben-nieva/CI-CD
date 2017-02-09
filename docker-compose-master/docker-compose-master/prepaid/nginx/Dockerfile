FROM nginx:latest

RUN rm /etc/nginx/conf.d/default.conf
RUN sed -i -e 's/CONSUMERPREPAIDBASEURL/${consumerBaseURL}' prepaid.conf
RUN sed -i -e 's/MERCHANTPREPAIDBASEURL/${merchantBaseURL}' prepaid.conf
RUN sed -i -e 's/INTERNALPREPAIDBASEURL/${internalBaseURL}' prepaid.conf

ADD prepaid.conf /etc/nginx/conf.d/

ADD keys /keys/