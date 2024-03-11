import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recipe-generator"
export default class extends Controller {
  static targets = ["ingredient", "meal", "key", "meals"]
  ingredients = []
  apyKey = this.keyTarget.innerText
  connect() {
    // console.log(this.keyTarget.innerText)
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
    this.mealsTarget.innerHTML = ""
    fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${this.apyKey}`
      },
      body: JSON.stringify({model: "gpt-3.5-turbo", "messages": [{"role": "user", "content": `Give me a 5 recipes name and calories for the following ingredients:${this.ingredients.join(", ")}`}],

      "temperature": 0.7})
      })
      .then(response => response.json())
      .then((data) => {
        const recipename = data["choices"][0]["message"]["content"]
        const recipes = recipename.match(/1\. (.+)\n2\. (.+)\n3\. (.+)\n4\. (.+)\n5\. (.+)/).slice(1,6)
        recipes.forEach((meal) => {
          const mealcard = `<div class="m-4 p-4 shadow bg-white" data-recipe-generator-target="meal" data-action="click->recipe-generator#saveMeal">
          ${meal}</div>`
          this.mealsTarget.insertAdjacentHTML('beforeend', mealcard)
        })
        // console.log(recipes)
        // this.mealTarget.innerHTML = `<h3>${recipes}</h3>`
      })
    }

    addToMeals(event) {
      const mealContent = event.target.dataset.mealContent;

      // Aquí puedes enviar mealContent al backend para guardarlo en tu base de datos
      // o hacer lo que sea necesario para agregar la receta a la vista de Meals.
      console.log("Receta seleccionada:", mealContent);
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
