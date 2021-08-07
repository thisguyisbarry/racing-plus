// TODO:
// - add feature where you can press escape to exit, and the text will remain

import g from "../../../globals";
import { config } from "../../../modConfigMenu";
import { consoleCommand } from "../../../util";

let isConsoleOpen = false;
let consoleText = "";
let consoleTextIndex = 0;
const keysPressed = new Map<Keyboard, boolean>();

export function postRender(): void {
  if (!config.customConsole) {
    return;
  }

  checkKeyboardInput();
}

function checkKeyboardInput() {
  const player = Isaac.GetPlayer();

  if (g.g.IsPaused()) {
    return;
  }

  // Record the pressed state of every possible key
  for (const keyboardValue of Object.values(Keyboard)) {
    if (
      Input.IsButtonPressed(keyboardValue as Keyboard, player.ControllerIndex)
    ) {
      keysPressed.set(keyboardValue as Keyboard, true);
    } else {
      keysPressed.delete(keyboardValue as Keyboard);
    }
  }

  if (isConsoleOpen) {
    handleInput();
  } else if (keysPressed.has(Keyboard.KEY_ENTER)) {
    open();
  }
}

function handleInput() {
  if (keysPressed.has(Keyboard.KEY_ENTER)) {
    close();
  }
}

function open() {
  isConsoleOpen = true;
  consoleText = "";
  consoleTextIndex = 0;
  // log("Console opened.");
}

function close() {
  isConsoleOpen = false;

  if (consoleText !== "") {
    consoleCommand(consoleText);
  }
  if (consoleTextIndex === 0) {
    // TODO
  }

  // log("Console closed.");
}
