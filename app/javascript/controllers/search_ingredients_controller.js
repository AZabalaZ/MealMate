import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-ingredients"
export default class extends Controller {
  static targets = [ "form", "list", "input" ]
  connect() {

  }

    update(){
      this.listTarget.innerHTML = ""
      const ingredient = this.inputTarget.value
      const url = `https://api.edamam.com/api/food-database/v2/parser?app_id=3355767f&app_key=2d3e7448b4e10b30ae472b4ef12dd0c0&ingr=${ingredient}&nutrition-type=cooking`
      fetch(url)
      .then(response => response.json())
      .then(data =>{
      const results = data["hints"].slice(0,5)
      results.forEach(result => {
        const link = `<a href=""><div class="d-flex p-4 bg-white shadow"><img src="${result["food"]["image"]}"><h3>${result["food"]["label"]}</h3><h2>${Math.round(result["food"]["nutrients"]["ENERC_KCAL"],2)}</h2></div></a>`
        this.listTarget.insertAdjacentHTML("beforeend", link)
      })
      const options = document.querySelectorAll("a")
        options.forEach((option)=>{
          option.addEventListener("click", (event) => {
            event.preventDefault()
            const name = event.currentTarget.querySelector("h3").innerText
            const calories = event.currentTarget.querySelector("h2").innerText

            fetch("/ingredients", {
              method: "POST",
              headers: {
                "Content-Type": "application/json",
                'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
              },
              body: JSON.stringify({ingredient: { name: name, calories: calories }})
            })
            .then(response => {
              if (response.ok) {
                return response.json()
              }
            })
          })
        })
    }
    )
    }
  }
