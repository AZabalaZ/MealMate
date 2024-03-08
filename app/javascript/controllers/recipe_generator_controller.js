import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-generator"
export default class extends Controller {
  static targets = ["ingredient", "meal"]
  ingredients = []
  connect() {
    console.log(this.ingredientTargets)
  }

  select(event){
    event.currentTarget.classList.toggle('border')
    event.currentTarget.classList.toggle('border-3')
    event.currentTarget.classList.toggle('border-primary')
    this.ingredients.push(event.currentTarget.innerText)
    if(this.ingredients.length>2){
      this.createMeal(this.ingredients)
    }
  }
  createMeal(ingredients){
    fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer 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"
      },
      body: JSON.stringify({model: "gpt-3.5-turbo", "messages": [{"role": "user", "content": `Give me a recipe name and calories for the following ingredients:${this.ingredients.join(", ")}`}],

      "temperature": 0.7})
      })
      .then(response => response.json())
      .then((data) => {
        const recipename = data["choices"][0]["message"]["content"]
        this.mealTarget.innerHTML = `<h3>${recipename}</h3>`
      })
    }
    saveMeal(){
      const meal = this.mealTarget.innerText

      fetch("/meals", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({meal: meal})
      })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
    }
  }
