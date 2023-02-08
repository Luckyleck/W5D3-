require 'sqlite3'
require 'singleton'
# require 'byebug'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('aa.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class QuestionLikes

  attr_accessor :id, :user_id, :og_question

  def self.all
      data = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
      data.map { |datum| QuestionLikes.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @og_question = options['og_question']
  end

  def self.find_by_id(id)
    question_likes = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM question_likes WHERE id = ?
    SQL
    QuestionLikes.new(question_likes.first)
  end

end

class Replies

  attr_accessor :id, :og_question, :user_id, :parent, :body

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    data.map { |datum| Replies.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @og_question = options['og_question']
    @user_id = options['user_id']
    @parent = options['parent']
    @body = options['body']
  end

end

class QuestionFollows

  attr_accessor :id, :user_id, :question_id

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    data.map { |datum| QuestionFollows.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end

end

class Questions

  attr_accessor :id, :title, :body, :associated_author

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    data.map { |datum| Questions.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @associated_author = options['associated_author']
  end

end

class Users

  attr_accessor :id, :fname, :lname
  
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM users')
    data.map { |datum| Users.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

end