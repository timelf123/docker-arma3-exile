# docker-arma3-exile

## Requirements

### Windows Users

- install docker toolbox: https://www.docker.com/products/docker-toolbox
- install it with all the features.
    + windows 10 users, make sure the ndis option is unticked.

- launch the docker command line

### Linux Users

- install docker-engine with this guide:
    + https://docs.docker.com/engine/installation/
- install docker-compose with this guide:
    + https://docs.docker.com/compose/install/

## Usage

1. Grab this repo

```bash
    $ git clone this repo; cd to this repo;
```

2. Run `./build.sh` to download Exile client/server and set up the shared volumes for MySQL/arma server files

3. Customise the config files:
```bash
    $ nano|vi|subl|gedit|notepad ./docker-compose.yml

    arma3/server/*.cfg
    params
```

4. build and run the images:

```bash
    $ docker-compose up
```

## Upgrading

see [#infrastructure] for info about how this project works

- Check and ensure both EXILE_SERVER_URL and EXILE_CLIENT_URL are valid
- change version numbers and/or urls
- docker-compose rm server && docker-compose build server && docker-compose up server


## Infrastructure

uses docker to automate the creation of required infrastructure and software for an Arma3 Exile Server.

- Server Container:
    + the game server process.
    + linked to the database container.
    + ephemeral, destroy this at will.

- Database Container
    + database server process.
    + mounts volumes created by build.sh script.
    + ephemeral, destroy this at will.
