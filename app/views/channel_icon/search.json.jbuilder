json.icons @icons.each do |icon|
    json.iconID icon.iconID
    json.iconName icon.iconName
    json.url icon.fullUrl
end
