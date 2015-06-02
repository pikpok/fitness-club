module ScheduleHelper

  # Return table of weekdays and numbers corresponding to it,
  # It helps to make view for new schedule cleaner.
  def weekdays
    [
      ['Monday', 1],
      ['Tuesday', 2],
      ['Wednesday', 3],
      ['Thursday', 4],
      ['Friday', 5],
      ['Saturday', 6],
      ['Sunday', 7]
    ]
  end

end
