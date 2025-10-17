# Level UP Real Life

<img width="1914" height="896" alt="Captura de ecrã 2025-09-23, às 20 03 51" src="https://github.com/user-attachments/assets/285e4a12-ec0e-433c-81f8-9a4b5d4c9ce0" />

**Play the game:** [https://www.levelup-rl.games/](https://www.levelup-rl.games/)

---

## 🚀 Project Overview

**Level UP Real Life** is an innovative full-stack, multiplayer strategy web application, inspired by classic empire-building and army management games. Developed as a final project for the Le Wagon bootcamp, this project showcases a wide range of modern web development techniques, from a complex real-time backend architecture to a dynamic, interactive frontend.

The game allows players to build and manage their base, train troops, gather resources, join guilds, and engage in battles with other players and monsters. It features two main interfaces: a detailed isometric base view for management and a vast, pannable world map for exploration and interaction.

---

## 🛠️ Tech Stack

* **Backend:** Ruby on Rails (MVC)
* **Frontend:** JavaScript (ES6), StimulusJS, Hotwire (Turbo Streams)
* **Database:** PostgreSQL
* **Styling:** SCSS, Bootstrap
* **Authentication:** Devise
* **Authorization:** Pundit
* **Testing:** RSpec
* **Deployment:** Heroku

---

## ✨ Key Features

### 🗺️ Interactive World Map

* A vast (5000x5000 pixels) **pannable map** where players can click and drag to explore.
* Players, castles, and monsters are positioned at specific coordinates, loaded efficiently from the database.
* **Dynamic Pop-ups:** Clicking on a castle or monster opens a contextual pop-up with relevant actions ("Attack", "Send Help", "Go to Base"), managed by a StimulusJS controller.
* **Real-time Updates:** Attacking a monster updates its HP on the map for all players instantly, without a page reload, using Turbo Streams.

### 🏰 Personal Base Management

* A fully responsive, isometric base view where players can construct and upgrade buildings on specific plots.
* **Dynamic UI:** Clicking a building opens a pop-up with options to upgrade or view details, powered by StimulusJS.
* **Resource Management:** Passive generation of resources (wood, stone, metal) based on building levels.

### ⚔️ Troop & Battle System

* **Troop Training:** Players can train three different types of troops (Swordsman, Archer, Cavalry) across 5 different levels. The training UI includes an interactive slider to select the quantity.
* **Battle Simulation:** A complex, turn-based battle logic encapsulated in a **Service Object** (`BattleSimulatorService`). The simulation calculates total power, troop losses, and determines a winner based on who has troops left.
* **Battle Reports:** The outcome of each battle is saved and can be viewed on a dedicated battle report page.

### 💬 Real-Time Social Features

* **Live Global Chat:** A global chat box, built with Hotwire/Turbo Streams, allows all online players to communicate in real-time.
* **Guild System:** Players can create and join guilds. A guild-specific chat provides a private communication channel for its members.

---

## 🚀 Local Installation & Setup

To run Level UP Real Life on your local machine, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone git@github.com:PizarroCris/Level-Up-Real-Life.git
    cd Level-Up-Real-Life
    ```

2.  **Install dependencies:**
    ```bash
    bundle install
    ```

3.  **Set up the database:**
    ```bash
    rails db:create db:migrate db:seed
    ```

4.  **Start the server:**
    ```bash
    bin/rails server
    ```

5.  **Access the application:** Open your browser and navigate to `http://localhost:3000`.

---

## 🧪 Automated Tests (RSpec)

This project includes an automated test suite with RSpec to ensure the reliability and expected behavior of key functionalities.

To run the tests:

```bash
bundle exec rspec
```

## 📝 License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🧑‍💻 Contribution
Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/PizarroCris/Level-Up-Real-Life/issues) or submit a pull request.

## 🤝 Credits
* **Cristiano Pizarro** - Lead Developer ([GitHub](https://github.com/PizarroCris))

* **Yan Buxes** - Contributing Developer ([GitHub](https://github.com/ynbxs))

* **Caio Figueiredo** - Contributing Developer ([GitHub](https://github.com/CAiAuM))
