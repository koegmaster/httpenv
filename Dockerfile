FROM golang:alpine
COPY httpenv.go /go
RUN go build httpenv.go

FROM alpine
RUN addgroup -g 1000 httpenv \
    && adduser -u 1000 -G httpenv -D httpenv
COPY --from=0 --chown=httpenv:httpenv /go/httpenv /httpenv
EXPOSE 8080
# we're not changing user in this example, but you could:
# USER httpenv
CMD ["/httpenv"]