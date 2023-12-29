Rails.application.config.generators.after_generate do |files|
  parsable_files = files.filter { |file| file.end_with?('.rb') }
  unless parsable_files.empty?
    system("bundle exec rubocop -A --fail-level=E #{parsable_files.shelljoin}", exception: true)
  end
end
