module SortableHelper
  # Helper que hace a las cabeceras de las tablas ordenables
  # Si title es nil el nombre de la columna es el nombre del atributo.
  # Se hace un merge entre los parametros new_params y params
  def sortable(column, title = nil, new_params = nil)
    column = column.to_s
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == 'asc') ? 'desc' : 'asc'

    if new_params
      link_to title, params.merge(sort: column, direction: direction, page: nil).merge(new_params), class: css_class
    else
      link_to title, params.merge(sort: column, direction: direction, page: nil), class: css_class
    end
  end
end