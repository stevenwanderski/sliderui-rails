module ApplicationHelper
  def sort_arrow(current, sort, direction)
    return '' if current != sort

    if direction == 'asc'
      return '&uarr;'.html_safe
    end

    '&darr;'.html_safe
  end

  def sort_new_direction(current, sort, direction)
    if sort != current
      return 'desc'
    end

    direction == 'asc' ? 'desc' : 'asc'
  end
end
