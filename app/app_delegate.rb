class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @mapping = RKObjectMapping.mappingForClass(CoffeeShop)
    @mapping.mapKeyPath("id",         toAttribute: "id")
    @mapping.mapKeyPath("latitude",   toAttribute: "latitude")
    @mapping.mapKeyPath("longitude",  toAttribute: "longitude")
    @mapping.mapKeyPath("name",       toAttribute: "name")
    @mapping.mapKeyPath("shot_count", toAttribute: "shot_count")

    @manager = RKObjectManager.objectManagerWithBaseURLString("http://artinmycoffeeserver.dev")
    @manager.mappingProvider.setMapping(@mapping, forKeyPath:"coffee_shops")

    puts "Loading objects..."
    @manager.loadObjectsAtResourcePath("/coffee_shops", delegate:self)
    puts "Objects being loaded..."
    true
  end

  def objectLoader(object_loader, didLoadObject:object)
    puts "in objectLoader:didLoadObject"
    puts "Loaded: #{object.inspect}"
  end

  def objectLoader(object_loader, didLoadObjects:objects)
    puts "in objectLoader:didLoadObjects"
    puts "Loaded: #{objects.inspect}"
  end

  def objectLoader(object_loader, didFailWithError:error)
    puts "in objectLoader:didFailWithError"
    puts "  #{error.inspect}"
  end

  def objectLoaderDidFinishLoading(object_loader)
    puts "in objectLoaderDidFinishLoading"
  end

  def objectLoaderDidLoadUnexpectedResponse(object_loader)
    puts "in objectLoaderDidLoadUnexpectedResponse"
  end
end
