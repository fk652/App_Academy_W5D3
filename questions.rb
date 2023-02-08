require 'sqlite3'
require 'singleton'

class QuestionDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :id, :title, :body

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id: id)
      SELECT 
        * 
      FROM 
        questions
      WHERE
        id = :id
    SQL
    data.map { |datum| Question.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
  end
end

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id: id)
      SELECT 
        * 
      FROM 
        users
      WHERE
        id = :id
    SQL
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_name(fname, lname)
    data = QuestionDBConnection.instance.execute(<<-SQL, fname: fname, lname: lname)
      SELECT 
        * 
      FROM 
        users
      WHERE
        fname = :fname AND lname = :lname
    SQL
    data.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
end

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id: id)
      SELECT 
        * 
      FROM 
        question_follows
      WHERE
        id = :id
    SQL
    data.map { |datum| QuestionFollow.new(datum) }
  end

  def self.most_followed_questions(n)
    data = QuestionDBConnection.instance.execute(<<-SQL, n: n)
      SELECT
        Q.id, Q.title, Q.body
      FROM
        Questions AS Q 
      JOIN (
        SELECT
          question_id
        FROM 
          question_follows
        GROUP BY
          question_id
        ORDER BY
          COUNT(*) DESC
        LIMIT
          :n
      ) AS QF ON
      Q.id = QF.question_id
    SQL
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id: id)
      SELECT 
        * 
      FROM 
        question_likes
      WHERE
        id = :id
    SQL
    data.map { |datum| QuestionLike.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end

class Reply
  attr_accessor :id, :question_id, :user_id, :parent_id, :body

  def self.find_by_id(id)
    data = QuestionDBConnection.instance.execute(<<-SQL, id: id)
      SELECT 
        * 
      FROM 
        replies
      WHERE
        id = :id
    SQL
    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @body = options['body']
  end
end