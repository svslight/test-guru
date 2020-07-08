# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Answer.delete_all
Question.delete_all
UserTest.delete_all
Test.delete_all
Category.delete_all
User.delete_all

users = User.create([
  { email: 'admin@yandex.ru', name: 'admin', password: 'admin'},
  { email: 'user@yandex.ru', name: 'user', password: 'user'}
])

categories = Category.create([
  { title: 'Frontend' },
  { title: 'Backend' }
])

tests = Test.create([
  { title: 'CSS/HTML', level: 0, author_id: users[0].id, category_id: categories[0].id },
  { title: 'PHP', level: 1, author_id: users[0].id, category_id: categories[1].id }, 
  { title: 'Ruby', level: 1, author_id: users[0].id, category_id: categories[0].id }, 
  { title: 'JavaScript', level: 1, author_id: users[0].id, category_id: categories[1].id },
  { title: 'Python', level: 1, author_id: users[0].id, category_id: categories[1].id },
  { title: 'Java', level: 2, author_id: users[0].id, category_id: categories[1].id },
  { title: 'R', level: 3, author_id: users[0].id, category_id: categories[1].id },
  { title: 'Swift', level: 4, author_id: users[0].id, category_id: categories[1].id },
  { title: 'Go', level: 5, author_id: users[0].id, category_id: categories[1].id },
  { title: 'C', level: 5, author_id: users[0].id, category_id: categories[1].id },
  { title: 'C++', level: 5, author_id: users[0].id, category_id: categories[1].id }  
])

questions = Question.create([
  { body: 'В Ruby всё – объект?', test_id: tests[0].id },
  { body: 'В Ruby замыкание — это блок?', test_id: tests[0].id },
  { body: 'HTML предназначен для создания Web-страниц?', test_id: tests[1].id },
  { body: 'На сайте можно использовать любую кодировку?', test_id: tests[1].id },
  { body: 'JS поддерживается всеми основными браузерами?', test_id: tests[2].id },
  { body: 'JS имеет прямой доступ к системным функциям ОС?', test_id: tests[2].id }
])

answers = Answer.create([
  { reply: 'Объект', correct: true, question_id: questions[0].id },
  { reply: 'Скалярное значение', correct: false, question_id: questions[0].id },
  { reply: 'Целое число', correct: false, question_id: questions[0].id },
  { reply: 'Это замыкание', correct: false, question_id: questions[0].id },
  
  { reply: 'Блок', correct: true, question_id: questions[1].id },
  { reply: 'Связь', correct: false, question_id: questions[1].id },
  
  { reply: 'Для создания Web-страниц', correct: true, question_id: questions[2].id },
  { reply: 'Для создания программ', correct: false, question_id: questions[2].id },
  
  { reply: 'Предпочтительно UTF8', correct: true, question_id: questions[3].id },
  { reply: 'Любую', correct: false, question_id: questions[3].id },
 
  { reply: 'Всеми', correct: true, question_id: questions[4].id },
  { reply: 'Только Chrome', correct: false, question_id: questions[4].id },
 
  { reply: 'Не имеет прямой доступ к ОС', correct: true, question_id: questions[5].id },
  { reply: 'Да, имеет прямой доступ к ОС', correct: false, question_id: questions[5].id }
])

user_tests = UserTest.create([
  { user_id: users[0].id, test_id: tests[0].id},
  { user_id: users[0].id, test_id: tests[1].id},
  { user_id: users[1].id, test_id: tests[2].id},
  { user_id: users[1].id, test_id: tests[1].id}
])

