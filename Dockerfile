FROM centos
MAINTAINER Sharath, sharathah@live.com

RUN yum -y update
RUN yum install -y java-1.8.0-openjdk
RUN yum install -y wget
RUN yum install -y unzip

# Create tomcat user and tom group. Add tomcat user to tom group.
RUN groupadd tom
RUN useradd tomcat
RUN usermod -a -G tom tomcat

# Tomcat setup.
RUN cd /home/tomcat/ && wget http://apachemirror.wuchna.com/tomcat/tomcat-8/v8.5.42/bin/apache-tomcat-8.5.42.zip
RUN cd /home/tomcat/ && unzip apache-tomcat-8.5.42.zip && rm -f apache-tomcat-8.5.42.zip
RUN chown -R tomcat:tom /home/tomcat/apache-tomcat-8.5.42 && chmod -R 775 /home/tomcat/apache-tomcat-8.5.42

# Set environment variables
ENV CATALINA_HOME /home/tomcat/apache-tomcat-8.5.42
ENV JAVA_HOME /usr
EXPOSE 9000

USER tomcat
CMD /home/tomcat/apache-tomcat-8.5.42/bin/catalina.sh run