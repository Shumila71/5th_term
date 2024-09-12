const city = 'Moscow';  // Здесь можно указать любой город
const apiUrl = `https://wttr.in/${city}?format=j1`;

async function getWeather() {
    try {
        const response = await fetch(apiUrl);
        const data = await response.json();

        const weather = data.current_condition[0];

        document.getElementById('city').textContent = city;
        document.getElementById('temp').textContent = weather.temp_C;
        document.getElementById('feels_like').textContent = weather.FeelsLikeC;
        document.getElementById('description').textContent = weather.weatherDesc[0].value;
    } catch (error) {
        console.error('Ошибка получения данных о погоде:', error);
    }
}

getWeather();