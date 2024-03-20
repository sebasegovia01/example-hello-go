# Usar la imagen oficial de Go como imagen base
FROM golang:1.22 as builder

# Establecer el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar los archivos del módulo Go y descargar las dependencias
# Asume que tu aplicación ya está utilizando módulos Go
COPY go.mod ./
#COPY go.sum ./
RUN go mod download

# Copiar el código fuente del proyecto al directorio de trabajo actual dentro del contenedor
COPY *.go ./

# Compilar la aplicación para Linux
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o main .

# Iniciar una nueva etapa de construcción para crear una imagen pequeña
FROM alpine:latest  

# Agregar ca-certificates en caso de que tu aplicación realice llamadas HTTPS
RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copiar el binario precompilado desde la etapa de construcción anterior
COPY --from=builder /app/main .

# Exponer el puerto 8000 para que la aplicación sea accesible fuera del contenedor
EXPOSE 8000

# Comando para ejecutar la aplicación
CMD ["./main"]
