const SETTINGS_STORAGE_KEY = "simple-bar-settings";

export const defaultSettings = {
  global: {
    theme: "auto",
    floatingBar: true,
    noBarBg: true,
    noColorInData: false,
    bottomBar: false,
    disableNotifications: false,
    compactMode: false,
    widgetMaxWidth: "160px",
    spacesBackgroundColorAsForeground: false,
    widgetsBackgroundColorAsForeground: false,
    font: "JetBrains Mono, Monaco, Menlo, monospace",
    fontSize: "11px",
    yabaiPath: "/usr/local/bin/yabai",
    shell: "sh",
    slidingAnimationPace: 4,
    externalConfigFile: false,
  },
  themes: {
    lightTheme: "Custom",
    darkTheme: "Custom",
  },
  process: {
    displayOnlyCurrent: false,
    centered: false,
    showCurrentSpaceMode: false,
    hideWindowTitle: true,
    displayOnlyIcon: false,
  },
  spacesDisplay: {
    exclusions: "",
    titleExclusions: "",
    spacesExclusions: "",
    exclusionsAsRegex: false,
    displayAllSpacesOnAllScreens: false,
    hideDuplicateAppsInSpaces: false,
    displayStickyWindowsSeparately: false,
    hideEmptySpaces: true,
    showOptionsOnHover: false,
    switchSpacesWithoutYabai: false,
  },
  widgets: {
    processWidget: true,
    weatherWidget: true,
    batteryWidget: true,
    wifiWidget: true,
    zoomWidget: true,
    soundWidget: true,
    micWidget: true,
    dateWidget: true,
    timeWidget: true,
    spotifyWidget: true,
    dndWidget: true,
  },
  weatherWidgetOptions: {
    refreshFrequency: 1000 * 60 * 30,
    unit: "C",
    hideLocation: true,
    hideGradient: false,
    customLocation: "",
  },
  batteryWidgetOptions: {
    refreshFrequency: 10000,
    toggleCaffeinateOnClick: false,
    caffeinateOption: "",
  },
  networkWidgetOptions: {
    refreshFrequency: 20000,
    networkDevice: "en0",
    hideWifiIfDisabled: false,
    toggleWifiOnClick: true,
  },
  zoomWidgetOptions: {
    refreshFrequency: 5000,
    showVideo: true,
    showMic: true,
  },
  soundWidgetOptions: {
    refreshFrequency: 20000,
  },
  micWidgetOptions: {
    refreshFrequency: 20000,
  },
  dateWidgetOptions: {
    refreshFrequency: 30000,
    shortDateFormat: true,
    locale: "en-US",
    calendarApp: "Cron",
  },
  timeWidgetOptions: {
    refreshFrequency: 1000,
    hour12: false,
    dayProgress: false,
    showSeconds: false,
  },
  spotifyWidgetOptions: {
    refreshFrequency: 10000,
    showSpecter: false,
  },
  dndWidgetOptions: {
    refreshFrequency: 60000,
    showDndLabel: false,
  },
  customStyles: {
    styles: "/* your custom css styles here */",
  },
};

export const get = () => {
  return defaultSettings;
};

export const set = async (newSettings) =>
  window.localStorage.setItem(
    SETTINGS_STORAGE_KEY,
    JSON.stringify(newSettings)
  );

export const getRefreshFrequency = (value, defaultValue) => {
  const parsedValue = parseInt(value);
  return isNaN(parsedValue) ? defaultValue : parsedValue;
};
