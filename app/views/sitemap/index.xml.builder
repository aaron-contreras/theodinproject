xml.instruct!
xml.urlset(
  'xmlns'.to_sym => "http://www.sitemaps.org/schemas/sitemap/0.9",
  'xmlns:image'.to_sym => "http://www.google.com/schemas/sitemap-image/1.1"
) do

  # Root
  xml.url do
    xml.loc "#{root_url}"
    xml.changefreq("daily")
    xml.priority(1.00)
  end

  @static_pages.each do |page|
    xml.url do
      xml.loc "#{page}"
      xml.changefreq("monthly")
      # Use weekly refresh period for XML requests
      # Perhaps change to using JSON instead of XML so an api is easier to
      # implement further on.
      xml.priority(0.80)
      # Priority should be 0.85
      # Don't believe 80% will cut it
    end
  end

  # Main courses index
  xml.url do
    xml.loc "#{courses_url}"
    xml.changefreq("monthly")
    xml.priority(1.00)
  end
  xml.url do
    xml.loc "#{curriculum_url}"
    xml.changefreq("monthly")
    xml.priority(0.80)
  end

  # Individual courses and lessons
  @courses.each do |course|
    xml.url do
      xml.loc "#{course_url(course.title_url)}"
      xml.changefreq("weekly")
      xml.priority(0.80)
    end

    course.lessons.each do |lesson|
      xml.url do
        xml.loc "#{lesson_url(course.title_url, lesson.title_url)}"
        xml.lastmod lesson.updated_at.strftime("%F")
        xml.changefreq("daily")
        xml.priority(1.00)
      end
    end
  end
end
