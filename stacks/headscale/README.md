# Configure Headscale controller
https://headscale.net/stable/usage/getting-started/
```
docker exec -it headscale headscale users create cecper
docker exec -it headscale headscale users list
```
```
docker exec -it headscale headscale preauthkeys create --user 1 --reusable --expiration 24h
```
```
docker exec -it headscale headscale nodes register --user cecper --key zxGSQpwbJA4SdEwazvwjq9cL
```

# on client machine you want to add to tailscale network
https://tailscale.com/kb/1347/installation

## Installs tailscale client
```
curl -fsSL https://tailscale.com/install.sh | sh
```
## Connect to Headscale controller 
```
sudo tailscale up --login-server <headscale-instance-url> --authkey <authkey>
```
## Advertise routes specifies which subnets you will make available to users connecting to your Tailscale network 
```
sudo tailscale up \
  --login-server=<headscale-instance-url>  \
  --authkey <authkey> \
  --advertise-routes=192.168.0.0/24
```

# Approve routes on your Headscale controller
```
docker exec -it headscale headscale nodes list-routes -i 2
```

```
docker exec -it headscale headscale nodes approve-routes --identifier 2 --routes 192.168.0.0/24
```

