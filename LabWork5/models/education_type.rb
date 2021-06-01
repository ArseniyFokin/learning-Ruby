# frozen_string_literal: true

# The list of possible vacancy age interval types
module EducationType
  TYPE0 = 'Не требуется'
  TYPE1 = 'Основное общее образование'
  TYPE2 = 'Среднее общее образование'
  TYPE3 = 'Среднее профессиональное образование'
  TYPE4 = 'Высшее образование - бакалавриат'
  TYPE5 = 'Высшее образование - специалитет, магистратура'
  TYPE6 = 'Высшее образование - аспирантура'

  def self.all_types
    [
      TYPE0, TYPE1, TYPE2, TYPE3, TYPE4, TYPE5, TYPE6
    ]
  end

  def self.compare(type_first, type_second)
    all_types.index(type_first) <= all_types.index(type_second)
  end
end
