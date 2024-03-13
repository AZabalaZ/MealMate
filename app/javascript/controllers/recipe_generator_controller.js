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
      body: JSON.stringify({model: "gpt-3.5-turbo", "messages": [{"role": "user", "content": `Give me a 5 recipes name and calories for the following ingredients:${this.ingredients.join(", ")}. Specify the portion size in grams. Add the recipe and let the recipe start with the word preparation. I need the name separated by a dash`}],

      "temperature": 0.7,
      // "max_tokens": 150,
      // "stop": ["Preparation:"]
    })
      })
      .then(response => response.json())
      .then((data) => {

        const recipename = data["choices"][0]["message"]["content"]
        const recipes = recipename.split(/\n\n(?=\d+\. )/)

        recipes.forEach((meal) => {

          const mealcard = `<div class="m-4 p-4 shadow bg-white" data-recipe-generator-target="meal" data-action="click->recipe-generator#saveMeal">
          ${meal}</div>`
          this.mealsTarget.insertAdjacentHTML('beforeend', mealcard)
        })

        console.log(recipes)

      })
    }



    saveMeal(event){
      const meal = event.currentTarget.innerText
      const name = meal.match(/^\d+\. (.*?) -/)[1]
      const calories = parseInt(meal.match(/(\d{1,}) calories/)[1], 10)
      const grams = parseInt(meal.match(/(\d+)g/)[1], 10)
      const steps = meal.match(/Preparation:(.*)/)[1].trim()

      fetch("/meals", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
        },
        body: JSON.stringify({meal: {name: name, calories: calories, portion: grams, description: steps}})
      })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
    }

  }
