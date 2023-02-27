import * as Uebersicht from "uebersicht";
import * as Settings from "./settings";

const settings = Settings.get();
const { yabaiPath = "/usr/local/bin/yabai" } = settings.global;

export const goToSpace = (index) =>
  Uebersicht.run(`${yabaiPath} -m space --focus ${index}`);

export const focusWindow = (id) =>
  Uebersicht.run(`${yabaiPath} -m window --focus ${id}`);
