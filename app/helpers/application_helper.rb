module ApplicationHelper

  def available_locales
    {
      en: 'English',
      he: 'עברית',
      ru: 'Русский'
    }
  end

  def right_left
    I18n.locale == :he ? 'left' : 'right'
  end
end
