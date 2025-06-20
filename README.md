# Train Communication Protocol

The Stormworks Rail Committee’s Train Communication Protocol (TCP) is a modular system that enables seamless communication between multiple train cars. It allows functions such as brakes, lighting, decoupling, and more to be centrally controlled from a single master car. Each car is equipped with a Main Controller, and additional modules can be added to support specific features. This architecture ensures reliable, synchronized behavior across the entire train consist, even in complex multiplayer scenarios.


## Releases
The TCP microcontrollers are primarily distributed on the steam workshop:
[TCP Collection](https://steamcommunity.com/sharedfiles/filedetails/?id=2126765606)


## Getting Started

To work on TCP, you need [Node.js](https://nodejs.org/) and npm (included with node).

To set up the repository locally run:

```bash
git clone https://github.com/src-org/tcp.git --recurse-submodules
cd tcp
npm run setup
```


## Configuration

A `.env` file is needed for steam interaction, see `.env.example` for an example.

You will also need to manually provide the required font files. These are not included in the repository due to licensing constraints.


## Legal

This project is **not licensed for redistribution**.  
All rights are reserved by the Stormworks Rail Committee.


## Contact

For support, questions, or community engagement, please join us on 
[Discord](https://discord.gg/3Swuqkb8d2).