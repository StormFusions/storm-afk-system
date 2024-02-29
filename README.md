# gmod-afk-system

Storm AFK System for Garry's Mod
The AFK (Away From Keyboard) System is a Lua-based solution designed to enhance player engagement on Garry's Mod servers. It prompts players with a question after a period of inactivity. Failing to answer correctly within a given timeframe results in the player being considered AFK and subject to being kicked, thus ensuring active server participation.

Features
Configurable AFK Timer: Customize the duration of inactivity before the AFK check is initiated.
Question-Based AFK Check: Engage players with simple math questions to determine their presence.
Client-Side UI: Presents players with an intuitive interface for answering the AFK question.
Server-Side Validation: Responses are validated server-side to maintain security.
Customizable Messages and UI: Tailor the AFK system's messages and UI colors to fit your server's theme.
Rewards for Response: Incentivize players to respond to the AFK check with customizable rewards.
Installation
Clone the Repository:

sh
Copy code
git clone https://github.com/yourusername/gmod-afk-system.git
Copy Lua Files: Place the Lua scripts into your server's garrysmod/addons/youraddon/lua/autorun/server for server-side scripts, and garrysmod/addons/youraddon/lua/autorun/client for client-side scripts.

Configure the System: Adjust settings in StormAFK.Config.lua to set your AFK timer, questions, UI colors, and messages.

Restart Your Server: Apply the changes by restarting your Garry's Mod server.

Configuration
Edit StormAFK.Config.lua to customize the AFK system:

AFKTimerDisplay: Time in seconds before showing the AFK check.
AFKTimertoKick: Time allowed for the player to answer the AFK question.
questions: List of questions and their answers for the AFK check.
bannerColor, afkTagColor, afkTagName, afkMessageColor: Customize the appearance of the AFK check UI and messages.
kickMessage: The message shown to players who fail the AFK check.
reward: Function defining the reward given to players who successfully respond to the AFK check.
Usage
The system automatically monitors player activity. Once a player's inactivity exceeds the configured threshold, they are prompted with an AFK check question. Responding correctly within the allotted time prevents the player from being kicked. The system supports customization to fit various server settings and preferences.

Contributing
Contributions are welcome! To contribute:

Fork the Repository: Click "Fork" at the top-right.
Make Your Changes: Implement improvements or fixes.
Submit a Pull Request: Open a pull request from your fork back to the original repository with a clear description of your changes.
Please adhere to the project's coding style and contribute to its improvement.

Support
For support, open an issue on GitHub
