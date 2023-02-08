require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('aa.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class QuestionLikes

  def self.all
      data = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
      data.map { |datum| QuestionLikes.new(datum) }
  end

end

class Replies

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    data.map { |datum| Replies.new(datum) }
  end

end

class QuestionFollows

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    data.map { |datum| QuestionFollows.new(datum) }
  end

end

class Questions

  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    data.map { |datum| Questions.new(datum) }
  end

end

class Users
  
  def self.all
    data = QuestionsDatabase.instance.execute('SELECT * FROM users')
    data.map { |datum| Users.new(datum) }
  end

end