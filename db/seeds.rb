# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Answer.delete_all
Question.delete_all
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
  { title: 'Ruby', level: 1, category_id: categories[0].id },
  { title: 'HTML', level: 0, category_id: categories[0].id },
  { title: 'JS', level: 1, category_id: categories[1].id }
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
  { correct: true, question_id: questions[0].id },
  { correct: false, question_id: questions[0].id },
  
  { correct: true, question_id: questions[1].id },
  { correct: false, question_id: questions[1].id },
  
  { correct: true, question_id: questions[2].id },
  { correct: false, question_id: questions[2].id },
  
  { correct: true, question_id: questions[3].id },
  { correct: false, question_id: questions[3].id },
 
  { correct: true, question_id: questions[4].id },
  { correct: false, question_id: questions[4].id },
 
  { correct: false, question_id: questions[5].id },
  { correct: true, question_id: questions[5].id }
])

user_tests = UserTest.create([
  { user_id: users[0].id, test_id: tests[0].id},
  { user_id: users[0].id, test_id: tests[1].id},
  { user_id: users[1].id, test_id: tests[2].id},
  { user_id: users[1].id, test_id: tests[1].id}
])

