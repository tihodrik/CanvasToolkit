class Mmis::Gateway
  attr_accessor :client

  def connect
    @client = initialize_connection
  end

  def get_enrolled_students(year, cipher, acad_prog, course_num)
    query("
      SELECT [Логин] AS login
      FROM [Все_Студенты] as stud
      WHERE
        [Логин] <> 'NULL' AND
        [Код_Группы] in (
          SELECT [Код]
          FROM [Все_Группы]
          WHERE
            [УчебныйГод] = '#{year}' AND
            [Курс] = '#{course_num}' AND
            [Код_Профиль] in (
              SELECT [Код]
              FROM [Специальности]
              WHERE
                [Специальность] = '#{cipher}' AND
                [Название_Спец] = '#{acad_prog}' AND
                [Профиль] = 1
            )
        )
    ")
  end


  protected
  def initialize_connection
    TinyTds::Client.new username: Settings.mmis.db_user,
                        password: Settings.mmis.db_password,
                        host: Settings.mmis.db_host,
                        database: Settings.mmis.db_name,
                        timeout: 10000
  end

  def query(query)
    @client.execute(query).to_a.each { |i| i.symbolize_keys! }
  end

end
