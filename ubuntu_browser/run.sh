docker build -t ws .
docker run -p 6080:80 -e USER=nwjbrandon -e PASSWORD=password -v /dev/shm:/dev/shm ws