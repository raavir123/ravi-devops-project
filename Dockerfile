##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/ravi-devops-project
WORKDIR /opt/ravi-devops-project
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/ravi-devops-project/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
