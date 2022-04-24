FROM cirrusci/flutter:2.10.5 AS build

# ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
# ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

WORKDIR /app
COPY . .
RUN flutter build web --release


FROM nginx:stable
EXPOSE 80
COPY --from=build app/build/web/ /usr/share/nginx/html/