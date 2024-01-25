package faas

import (
	"net/http"

	"github.com/untaldouglas/goship/handlers/rest"
)

// Unfortunately, there is no universal way to create FaaS applications across different platforms.
// You define a package and function to run a command from, and that is what is built and deployed on GCP.
// Go uses a standard http.Handler, so there will be little to change for our api

func Translate(w http.ResponseWriter, r *http.Request) {
	rest.TranslateHandler(w, r)
}
