const latitude = '55.7558'; // Широта для Москвы
const longitude = '37.6176'; // Долгота для Москвы
const apiUrl = `https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true`;



async function getWeather() {
    try {
        const response = await fetch(apiUrl);
        const data = await response.json();

        if (data && data.current_weather) {
            const weather = data.current_weather;

            document.getElementById('city').textContent = `Moscow`;
            document.getElementById('temp').textContent = weather.temperature;
            document.getElementById('description').textContent = weather.weathercode + " - это код описания погоды"; 
        } else {
            console.error('Некорректные данные');
        }
    } catch (error) {
        console.error('Ошибка получения данных о погоде:', error);
    }
}

getWeather();