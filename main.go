package main

import (
	"log"
	"net/http"
	"os"
	"os/signal"
)

func main() {

	http.HandleFunc("/", Home)
	go http.ListenAndServe("localhost:8080", nil)
	log.Println("Listening on:", "localhost:8080")

	ch := make(chan os.Signal)
	signal.Notify(ch, os.Interrupt)

	<-ch
}

func Home(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("I'm working Mahdi..."))
}
