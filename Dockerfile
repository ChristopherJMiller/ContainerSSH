FROM golang AS build
RUN mkdir -p /go/src/github.com/janoszen/containerssh
WORKDIR /go/src/github.com/janoszen/containerssh/
COPY . /go/src/github.com/janoszen/containerssh
RUN go build -o build/containerssh cmd/containerssh/main.go
RUN chmod +x /go/src/github.com/janoszen/containerssh/build/containerssh

FROM scratch AS run
COPY --from=build /go/src/github.com/janoszen/containerssh/build/containerssh /containerssh
CMD ["/containerssh", "--config", "/etc/containerssh/config.yaml"]
VOLUME /etc/containerssh
VOLUME /var/secrets
USER 1022:1022
EXPOSE 2222
