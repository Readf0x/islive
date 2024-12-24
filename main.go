package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"strings"
)

func main() {
  if len(os.Args) < 2 {
    fmt.Println("Not enough arguments!")
    os.Exit(2)
  }
  channel := os.Args[1]
  resp, err := http.Get(fmt.Sprintf("https://twitch.tv/%s", channel))
  if err != nil {
    log.Fatal(err)
  }
  defer resp.Body.Close()
  body, err := io.ReadAll(resp.Body)

  if strings.Contains(string(body), "isLiveBroadcast") {
    fmt.Printf("%s is live!\n", channel)
    os.Exit(0)
  } else {
    os.Exit(1)
  }
}
