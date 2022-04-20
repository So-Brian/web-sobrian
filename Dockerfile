FROM nginx
EXPOSE 80
COPY build/web/ /usr/share/nginx/html

# RUN apt update

# RUN apt-get install -y wget \
# && mkdir -p /www/DockerData/file \
# && cd /www/DockerData/file \
# && wget https://storage.flutter-io.cn/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.5-stable.tar.xz \
# && tar xf flutter_linux_2.10.5-stable.tar.xz

# # RUN apt install wget -y
# # RUN mkdir -p example
# # WORKDIR example/
# # RUN wget -r https://storage.flutter-io.cn/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.5-stable.tar.xz && tar xf *.xz
# RUN export PATH="$PATH:`pwd`/flutter/bin"
# RUN flutter doctor

# WORKDIR /app
# COPY build/web/ /app/

# RUN apt update
# RUN apt install -y python3


# RUN python3 -m http.server 8000
# EXPOSE 8000
# CMD [ "python3 -m http.server 8000" ]
# RUN flutter pub get
# RUN flutter build web --release

# # WORKDIR /build/web
# RUN apt install python3 --yes
# RUN apt install python3-pip --yes
# # RUN pip install requests
# # RUN pip install http
# EXPOSE 8000

# RUN ["chmod", "+x", "./server/server.sh"]

# ENTRYPOINT [ "./server/server.sh" ]


########################
# Deploy
########################
# FROM gcr.io/distroless/base-debian10

# WORKDIR /

# COPY --from=build /build/web/ ./
# # COPY --from=build /server/server.sh /server/

# EXPOSE 8000

# USER nonroot:nonroot

# RUN ["chmod", "+x", "./server/server.sh"]

# ENTRYPOINT [ "./server/server.sh" ]





#########################
############
# FROM gcr.io/distroless/base-debian10

# WORKDIR /

# COPY --from=build /build/web/. /build/web/.

# EXPOSE 8080

# WORKDIR /build/web

# RUN python -m http.server 8000