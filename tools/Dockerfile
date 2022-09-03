FROM ironmansoftware/universal:latest
LABEL description="Universal - The ultimate platform for building web-based IT Tools" 

EXPOSE 5000
COPY [ "./Repository", "/root/.PowerShellUniversal/Repository" ]
ENTRYPOINT ["./Universal/Universal.Server"]