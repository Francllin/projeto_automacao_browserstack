
World(Helper)

After do |cenario|
    ## take screenshot
    cenario_name = cenario.name.gsub(/\s+/, '_').tr('/', '_')
    if cenario.failed?
      take_screenshot(cenario_name.downcase!, 'failed')
    else
      take_screenshot(cenario_name.downcase!, 'passed')
    end
  end