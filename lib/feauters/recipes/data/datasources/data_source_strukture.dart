import '../../domain/entities/recipe.dart';

class DataSourceStrukture {
  List images = [
    'assets/images/recipe_losos.png',
    'assets/images/recipe_poke.png',
    'assets/images/recipe_steik.png',
    'assets/images/recipe_tost.png',
    'assets/images/recipe_pasta.png',
    'assets/images/recipe_burger.png',
    'assets/images/recipe_pizza.png'
  ];
  List name = [
    'Лосось в соусе терияки',
    "Поке боул с сыром тофу",
    'Стейк из говядины по-грузински',
    'Тосты с голубикой и бананом',
    'Паста с морепродуктами',
    'Бургер с двумя котлетами',
    'Пицца Маргарита домашняя'
  ];
  List time = [
    '45 минут',
    '30 минут',
    '1 час 15 минут',
    '45 минут',
    '25 минут',
    '1 час',
    '25 минут'
  ];
  List<String> ingredientsLosos = [
    'Соевый соус',
    'Вода',
    'Мёд',
    'Коричневый сахар',
    'Чеснок',
    'Тёртый свежий имбирь',
    'Лимонный сок',
    'Кукурузный крахмал',
    'Растительное масло',
    'Филе лосося или сёмги',
    'Кунжут'
  ];
  List ingrVolumeLosos = [
    '8 ст. ложек',
    '8 ст. ложек',
    '3 ст. ложки',
    '2 ст. ложки',
    '3 зубчика',
    '1 ст. ложка',
    '1¹⁄₂ ст. ложки',
    '1 ст. ложка',
    '1 ч. ложка',
    '680 г',
    'по вкусу'
  ];
  List cookStepsLosos = [
    'В маленькой кастрюле соедините соевый соус, 6 столовых ложек воды, мёд, сахар, измельчённый чеснок, имбирь и лимонный сок.',
    'Поставьте на средний огонь и, помешивая, доведите до лёгкого кипения.',
    'Смешайте оставшуюся воду с крахмалом. Добавьте в кастрюлю и перемешайте',
    'Готовьте, непрерывно помешивая венчиком, 1 минуту. Снимите с огня и немного остудите.',
    'Смажьте форму маслом и выложите туда рыбу. Полейте её соусом.',
    'Поставьте в разогретую до 200 °C духовку примерно на 15 минут.',
    'Перед подачей полейте соусом из формы и посыпьте кунжутом.'
  ];
  List cookStepTimeLosos = [
    '05:30',
    '07:00',
    '06:00',
    '01:30',
    '06:00',
    '15:00',
    '04:00'
  ];

  List ingrPoke = ['inr1'];
  List ingrVolPoke = ['1 gr'];
  List cookStepsPoke = ['step'];
  List cookStepTimePoke = ['1min'];

  List ingrSteik = ['inr1'];
  List ingrVolSteik = ['1 gr'];
  List cookStepsSteik = ['step'];
  List cookStepTimeSteik = ['1min'];

  List ingrTost = ['inr1'];
  List ingrVolTost = ['1 gr'];
  List cookStepsTost = ['step'];
  List cookStepTimeTost = ['1min'];

  List ingrPasta = ['inr1'];
  List ingrVolPasta = ['1 gr'];
  List cookStepsPasta = ['step'];
  List cookStepTimePasta = ['1min'];

  List ingrBurger = ['inr1'];
  List ingrVolBurger = ['1 gr'];
  List cookStepsBurger = ['step'];
  List cookStepTimeBurger = ['1min'];

  List ingredientsPizza = [
    'Тесто для пиццы',
    'Соус томатный',
    'Сыр Моцарелла',
    'Помидор',
    'Базилик зеленый',
    'Масло оливковое'
  ];
  List ingrVolumePizza = [
    '300 грам',
    '130 грам,',
    '180 грам',
    '1 шт.',
    '1 шт.',
    '1 ч. ложка'
  ];
  List cookStepsPizza = [
    'В Тесто для пиццы раскатываем толщиной 2-3 мм, диаметром 32-35 см.  Для того, чтобы получить красивые бортики на пицце, загибаем края по 2-3 см внутрь и хорошо залепляем, чтобы при выпекании они не отклеились. ',
    'Кладём на раскатанную основу томатный соус, пусть его будет побольше, особенное если вы используете не кетчуп или томатную пасту, а соус из помидоров.',
    'Равномерно распределяем соус по тесту, поливаем сверху оливковым маслом.',
    'Духовку разогреваем до максимальной температуры (250-270°С), ставим перевёрнутый противень с тестом на нижний уровень и выпекаем в течении 5-10 минут',
    'Пока запекается корж, нарезаем моцареллу пластинами 5-10 мм толщиной.',
    'Нарезаем помидор ломтиками 3-5 мм.',
    'Кладем сыр, помидоры и базилик на основу, ставим в духовку еще на 10 минут. Пицца готова, когда сыр расплавится. '
  ];
  List cookStepTimePizza = [
    '01:00',
    '01:00',
    '01:00',
    '10:00',
    '01:00',
    '01:00',
    '10:00'
  ];

  Future<List<Recipe>> getRecipe() async {
    List<Recipe> recipes = [];

    List ingr = [
      ingredientsLosos,
      ingrPoke,
      ingrSteik,
      ingrTost,
      ingrPasta,
      ingrBurger,
      ingredientsPizza
    ];
    List ingrVol = [
      ingrVolumeLosos,
      ingrVolPoke,
      ingrVolSteik,
      ingrVolTost,
      ingrVolPasta,
      ingrVolBurger,
      ingrVolumePizza
    ];
    List cookStep = [
      cookStepsLosos,
      cookStepsPoke,
      cookStepsSteik,
      cookStepsTost,
      cookStepsPasta,
      cookStepsBurger,
      cookStepsPizza
    ];
    List cookStepTime = [
      cookStepTimeLosos,
      cookStepTimePoke,
      cookStepTimeSteik,
      cookStepTimeTost,
      cookStepTimePasta,
      cookStepTimeBurger,
      cookStepTimePizza
    ];

    for (int i = 0; i < name.length; i++) {
      List<Ingredient> ingredients = [];
      for (int j = 0; j < ingr[i].length; j++) {
        Ingredient ingredient =
            Ingredient(ingredient: ingr[i][j], volume: ingrVol[i][j]);
        ingredients.add(ingredient);
      }

      List<Cook> cooks = [];

      for (int k = 0; k < cookStep[i].length; k++) {
        Cook cook = Cook(
            step: cookStep[i][k], timeStep: cookStepTime[i][k], timeStepSec: 0);
        cooks.add(cook);
      }

      recipes.add(Recipe(
        name: name[i],
        img: images[i],
        time: time[i],
        ingredients: ingredients,
        cook: cooks,
        aggregateLikes: 0,
        comments: [],
        id: '',
        likeUsersId: [],
      ));
    }
    // return await Future.delayed(Duration(microseconds: 1), (() => recipes));
    return recipes;
  }
}
