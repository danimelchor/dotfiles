import * as Themes from "./themes";
import * as Settings from "../settings";

const settings = Settings.get();
const { themes } = settings;

export const colors = {
  light: Themes.collection[themes.lightTheme],
  dark: Themes.collection[themes.darkTheme],
};
