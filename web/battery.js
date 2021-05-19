function getBattery() {
navigator.getBattery().then((battery) => {
    battery.ondischargingtimechange = (event) => {
      console.warn(`Discharging : `, event.target.level);
    };

    battery.onchargingtimechange = (event) => {
      console.info(`Charging : `, event.target.level);
    };
  });
}