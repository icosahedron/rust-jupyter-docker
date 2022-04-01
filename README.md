This repo contains a Dockerfile which will build an image that contains Jupyter
kernels for notebooks running Rust 1.59 (as of this writing).

To build the image, simply use `docker build . -t rust-deeplearning`.

To run the image, use 

```
docker run -d --name rust-deeplearning -p 8888:8888 -v $PWD:/home/user/local --restart unless-stopped rust-deeplearning
```

This will start the image make it available via http.  (You should definitely 
be on a secure network to run this.)

If you need to debug a bit in the image, run the image with the 
`-e GRANT_SUDO=yes` option

```
docker run -d -e GRANT_SUDO=yes --name rust-deeplearning -p 8888:8888 -v $PWD:/home/user/local --restart unless-stopped rust-deeplearning
```

and attach to the image with

```
docker exec -it rust-deeplearning /bin/bash
```

The password for the site is by default "Deep Learning From Scratch" contained in the `jupyter_notebook_config.json` file.  
You can set a new password using these [instructions](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html).  
(I set up a password because I didn't want to have to know the token to be able to use my notebooks.)

A sample notebook is available in the examples subdirectory.  More will be added later.
