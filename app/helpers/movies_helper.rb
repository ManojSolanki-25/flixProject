module MoviesHelper 

    def main_image(movie)
        # return unless movie.main_image.attached? image_tag "placeholder.png"
        if movie.main_image.attached?
            image_tag movie.main_image
        else
            image_tag "placeholder.png"
        end
    end
    
    def total_gross(mv)
        if mv.free?
            " Free !"
        else
            number_to_currency(mv.total_gross,precision:0)
        end
    end

    def year_of(mv)
        mv.released_on.strftime("%B %d %Y  %I:%M %p")
    end

    def average_stars(movie)
        if movie.average_stars.zero?
            content_tag(:strong, "No Review")
        else
            pluralize(movie.average_stars,"star")
        end
    end

    def nav_link_to(text,url)
        if current_page?(url)
            link_to(text,url,class: "active")
        else
            link_to(text,url)
        end
    end
end
