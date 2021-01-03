-- UPDATES ALL FILES IN DATA FROM DISK
---------------------------------------------------

shell.run("cd /")
shell.run("delete data/")
shell.run("mkdir data")
shell.run("copy /disk/data/* /data/")