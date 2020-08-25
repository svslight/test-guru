# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TestPassage.delete_all
Answer.delete_all
Question.delete_all
Test.delete_all
Category.delete_all
User.delete_all

users = User.create!([{ first_name: 'Lana', last_name: 'Svetlana', email: 'svslight@gmail.com', password: 'password', type: "Admin" }])

categories = Category.create([
  { title: 'Frontend' },
  { title: 'Backend' }
])

tests = Test.create([
  { title: 'Ruby', level: 1, author_id: users[0].id, category_id: categories[0].id }, 
  { title: 'CSS/HTML', level: 0, author_id: users[0].id, category_id: categories[0].id },
  { title: 'JavaScript', level: 1, author_id: users[0].id, category_id: categories[1].id },
  { title: 'PHP', level: 1, author_id: users[0].id, category_id: categories[1].id },
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

test_passages = TestPassage.create([
  # { user_id: users[0].id, test_id: tests[0].id, current_question_id: questions[0].id},
])

answers = Answer.create([
  { body: 'Объект', correct: true, question_id: questions[0].id },
  { body: 'Скалярное значение', correct: false, question_id: questions[0].id },
  { body: 'Целое число', correct: false, question_id: questions[0].id },
  { body: 'Это замыкание', correct: false, question_id: questions[0].id },
  
  { body: 'Блок', correct: true, question_id: questions[1].id },
  { body: 'Связь', correct: false, question_id: questions[1].id },
  
  { body: 'Для создания Web-страниц', correct: true, question_id: questions[2].id },
  { body: 'Для создания программ', correct: false, question_id: questions[2].id },
  
  { body: 'Предпочтительно UTF8', correct: true, question_id: questions[3].id },
  { body: 'Любую', correct: false, question_id: questions[3].id },
 
  { body: 'Всеми', correct: true, question_id: questions[4].id },
  { body: 'Только Chrome', correct: false, question_id: questions[4].id },
 
  { body: 'Не имеет прямой доступ к ОС', correct: true, question_id: questions[5].id },
  { body: 'Да, имеет прямой доступ к ОС', correct: false, question_id: questions[5].id }
])
