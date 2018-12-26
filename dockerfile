# 编译阶段 命名为 builder
FROM golang:1.10.3 as builder
COPY ./gushici  /gushici/
WORKDIR /gushici
#RUN echo $GOPATH > /gushici/build.file
RUN go get github.com/astaxie/beego \
    && go get github.com/go-sql-driver/mysql
RUN GOPATH="$GOPATH;/tmp" CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOARM=6 go build  -o gushici
#RUN echo $GOARCH >> /gushici/build.file

RUN mkdir -p /tmp/gushici \
    && cp /gushici/gushici /tmp/gushici/gushici \
    && cp -r /gushici/conf  /tmp/gushici/conf \
    && cp -r /gushici/static /tmp/gushici/static \
    && cp -r /gushici/views /tmp/gushici/views 
#   && cp -r /gushici/build.file /tmp/gushici/build.file 


FROM ubuntu
COPY --from=builder /tmp/gushici/ /data/gushici
ENTRYPOINT ["/data/gushici/gushici"]
EXPOSE 8081