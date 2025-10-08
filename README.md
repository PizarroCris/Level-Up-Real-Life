<img width="1914" height="896" alt="Captura de ecrã 2025-09-23, às 20 03 51" src="https://github.com/user-attachments/assets/285e4a12-ec0e-433c-81f8-9a4b5d4c9ce0" />


**Level Up Real Life** is a full-stack multiplayer strategy web application, inspired by classic empire-building and strategy games. This project was developed as a Le Wagon final project, showcasing a wide range of modern web development techniques, from a complex back-end architecture to a dynamic, real-time front-end.

---

## 🚀 Core Concept

The game allows players to build and manage their own base, train troops, gather resources, join guilds, and engage in battles with other players and world monsters. It features two main interfaces: a detailed **isometric base view** for management and a vast, **pannable world map** for exploration and interaction.

---

## 🛠️ Tech Stack

* **Back-End:** Ruby on Rails
* **Front-End:** JavaScript (ES6), StimulusJS, Hotwire (Turbo Streams)
* **Database:** PostgreSQL
* **Styling:** SCSS, Bootstrap
* **Authentication:** Devise
* **Authorization:** Pundit
* **Deployment:** Heroku 

---

## ✨ Key Features

### Interactive World Map
* A large-scale (5000x5000 pixels) **pannable world map** that users can click and drag to explore.
* Player castles and world monsters are positioned at specific coordinates, loaded efficiently from the database.
* **Dynamic Pop-ups:** Clicking on a castle or monster opens a contextual pop-up with relevant actions ("Attack", "Send Help", "Go to Base"), managed by a StimulusJS controller.
* **Real-time Updates:** Attacking a monster updates its HP on the map for all players instantly, without a page reload, using Turbo Streams.

### Personal Base Management
* A fully responsive, **isometric base view** where players can construct and upgrade buildings on specific plots.
* **Dynamic UI:** Clicking a building opens a pop-up with options to upgrade or view details, powered by StimulusJS.
* **Resource Management:** Passive generation of resources (wood, stone, metal) based on building levels.

### Troop & Battle System
* **Troop Training:** Players can train three different types of troops (Swordsman, Archer, Cavalry) across 5 different levels. The training UI includes an interactive slider to select the quantity.
* **Battle Simulation:** A complex, turn-based battle logic encapsulated in a **Service Object** (`BattleSimulatorService`). The simulation calculates total power, troop losses, and determines a winner based on who has troops left.
* **Battle Reports:** The outcome of each battle is saved and can be viewed on a dedicated battle report page.

### Real-Time Social Features
* **Live Global Chat:** A global chat box, built with Hotwire/Turbo Streams, allows all online players to communicate in real-time.
* **Guild System:** Players can create and join guilds. A guild-specific chat provides a private communication channel for members.

---

## 🔧 Installation & Setup

1.  Clone the repository: `git clone ...`
2.  Install dependencies: `bundle install` and `bundle install`
3.  Set up the database: `rails db:create db:migrate db:seed`
4.  Start the server: `bin/rails server`

---
