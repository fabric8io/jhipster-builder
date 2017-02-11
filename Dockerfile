FROM centos:7

RUN yum install wget -y
RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
RUN curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -

RUN yum update -y && \
  yum install -y git gcc-c++ make nodejs yarn docker unzip java-1.8.0-openjdk-devel which bzip2 libfontconfig

RUN curl -L http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz | tar -C /opt -xzv

ENV M2_HOME /opt/apache-maven-3.3.9
ENV maven.home $M2_HOME
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0

RUN npm install -g bower
RUN npm install -g gulp-cli
RUN npm install -g yo
RUN npm set progress=false && \
  echo '{ "allow_root": true }' > /root/.bowerrc

RUN mkdir /tmp/phantomjs && \
  curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
    | tar -xj --strip-components=1 -C /tmp/phantomjs && \
  mv /tmp/phantomjs/bin/phantomjs /usr/local/bin

ENV DOCKER_API_VERSION 1.23

# RUN git clone https://github.com/rawlingsj/shiftwork.git
# WORKDIR ./shiftwork


# RUN curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | tar -C /opt xvfj
# RUN npm install
# RUN bower install
# RUN ./mvnw -Pprod clean package
# CMD java -jar target/*.war --spring.profiles.active=prod
# CMD sleep infinity
