FROM ubuntu:20.04 AS build

RUN apt update
RUN apt install git curl unzip --yes
RUN mkdir ~/fluter
RUN git clone https://github.com/flutter/flutter.git -b stable ~/flutter
RUN export PATH="$PATH:~flutter/bin"
RUN ~/flutter/bin/flutter doctor

WORKDIR /app
COPY . .
RUN ~/flutter/bin/flutter pub get
RUN ~/flutter/bin/flutter build web --release

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
FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /build/web/ /
# COPY --from=build /server/server.sh /server/

EXPOSE 8000

USER nonroot:nonroot

RUN ["chmod", "+x", "./server/server.sh"]

ENTRYPOINT [ "./server/server.sh" ]





#########################
############
# FROM gcr.io/distroless/base-debian10

# WORKDIR /

# COPY --from=build /build/web/. /build/web/.

# EXPOSE 8080

# WORKDIR /build/web

# RUN python -m http.server 8000