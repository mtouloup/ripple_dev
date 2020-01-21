ARG DIST_TAG=16.04
FROM ubuntu:$DIST_TAG
ARG GIT_COMMIT=unknown
ARG CI_USE=false
LABEL git-commit=$GIT_COMMIT

#Set env Var for Boost
ENV BOOST_ROOT=/boost_1_71_0

#Install/setup prerequisites:
ADD ./shared/build_deps.sh /tmp/
ADD ./shared/install_boost.sh /tmp/
ADD ./scripts/ubuntu_setup.sh /tmp/
ADD ./scripts/build_rippled.sh /tmp/
ADD ./cfg/rippled-example.cfg /tmp/
ADD ./scripts/run_ripple_server.sh /tmp/

#Give privileges to script files 
RUN chmod +x /tmp/ubuntu_setup.sh && \
    chmod +x /tmp/build_deps.sh && \
	chmod +x /tmp/build_rippled.sh && \
	chmod +x /tmp/install_boost.sh && \
	chmod +x /tmp/run_ripple_server.sh
	
#Run Scripts
RUN /tmp/ubuntu_setup.sh
RUN /tmp/build_deps.sh
RUN /tmp/build_rippled.sh
RUN /tmp/run_ripple_server.sh

#Expose rippled port
EXPOSE 51235

CMD ./rippled/my_build/rippled