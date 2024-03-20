package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Define el objeto de respuesta
		response := map[string]string{"message": "hello world"}

		// Establece el tipo de contenido como JSON
		w.Header().Set("Content-Type", "application/json")

		// Codifica el objeto de respuesta y lo envía
		json.NewEncoder(w).Encode(response)
	})

	port := ":8000"

	log.Printf("Server running on http://localhost%s", port)
	// Inicia el servidor en el puerto 5000
	log.Fatal(http.ListenAndServe(port, nil))

}
