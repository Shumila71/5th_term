import random
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import Updater, CommandHandler, CallbackContext, CallbackQueryHandler




jokes = [
    "— Папа, можно я пойду на улицу?\n— Можно, но через дверь.",
    "— Доктор, а я не умру?\n— Мы сделаем всё возможное, чтобы этого избежать.",
    "— Почему программисты не любят природу?\n— Потому что на природе слишком много багов."
]


def joke(update: Update, context: CallbackContext) -> None:
    joke_text = random.choice(jokes)
    update.message.reply_text(joke_text)

def whoI(update: Update, context: CallbackContext) -> None:
    name="Мой создатель - Шумахер Марк из группы ИКБО-20-22"
    update.message.reply_text(name)

# Функция для кнопок
def start(update: Update, context: CallbackContext) -> None:
    keyboard = [
        [InlineKeyboardButton("Анекдот", callback_data='joke')],
        [InlineKeyboardButton("Создатель", callback_data='creator')]
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)
    update.message.reply_text('Выберите действие:', reply_markup=reply_markup)

# Обработчик нажатий кнопок
def button(update: Update, context: CallbackContext) -> None:
    query = update.callback_query
    query.answer()

    if query.data == "joke":
        joke_text = random.choice(jokes)
        query.edit_message_text(text=joke_text)
    elif query.data == "creator":
        name = "Мой создатель - Шумахер Марк из группы ИКБО-20-22"
        query.edit_message_text(text=name)

def main() -> None:
    token = "7357520029:AAFeV52eBfz4ECLXi41tmgUd1_4OBiyN0pM"


    updater = Updater(token)
    updater.dispatcher.add_handler(CommandHandler("start", start))
    updater.dispatcher.add_handler(CommandHandler("joke", joke))
    updater.dispatcher.add_handler(CommandHandler("creator", whoI))
    
    updater.dispatcher.add_handler(CallbackQueryHandler(button))

    updater.start_polling()
    updater.idle()

if __name__ == '__main__':
    main()
