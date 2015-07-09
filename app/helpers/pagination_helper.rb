module PaginationHelper

  def will_paginate_wrapper(collection, options = nil)

    options = options || { renderer: BootstrapPagination::Rails }
    will_paginate_content = will_paginate collection, options

    total = collection.total_entries
    from = 1 + (collection.current_page - 1) * collection.per_page
    to = [collection.current_page * collection.per_page , total].min

    pagination_content = content_tag :span, class: 'pagination-info' do
      if total != 0
        "#{from} - #{to} de #{total}"
      else
        '0 de 0'
      end
    end

    content_tag :div, class: 'pagination-container clearfix' do
      will_paginate_content.present? ? will_paginate_content + pagination_content : pagination_content
    end
  end
end
