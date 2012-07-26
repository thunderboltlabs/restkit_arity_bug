class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    RKLogInitialize()
    lcl_configure_by_name("RestKit/Network", RKLogLevelTrace);
    lcl_configure_by_name("RestKit/ObjectMapping", RKLogLevelTrace);

    @mapping = RKObjectMapping.mappingForClass(CoffeeShop)
    @mapping.mapKeyPath("id",         toAttribute: "id")
    @mapping.mapKeyPath("latitude",   toAttribute: "latitude")
    @mapping.mapKeyPath("longitude",  toAttribute: "longitude")
    @mapping.mapKeyPath("name",       toAttribute: "name")
    @mapping.mapKeyPath("shot_count", toAttribute: "shot_count")

    @manager = RKObjectManager.objectManagerWithBaseURLString("http://localhost:4567")
    @manager.mappingProvider.setMapping(@mapping, forKeyPath:"coffee_shops")

    log "Loading objects..."
    @manager.loadObjectsAtResourcePath("/coffee_shops", delegate:self)
    log "Objects being loaded..."
    true
  end

  def objectLoader(object_loader, didLoadObject:object)
    log "In objectLoader:didLoadObject"
    log "Loaded: #{object.inspect}"
  end

  def objectLoader(object_loader, didLoadObjects:objects)
    log "In objectLoader:didLoadObjects"
    log "Loaded: #{objects.inspect}"
  end

  def objectLoader(object_loader, didFailWithError:error)
    log "In objectLoader:didFailWithError"
    log "  #{error.localizedDescription}"
  end

  def objectLoaderDidFinishLoading(object_loader)
    log "In objectLoaderDidFinishLoading"
  end

  def objectLoaderDidLoadUnexpectedResponse(object_loader)
    log "In objectLoaderDidLoadUnexpectedResponse"
  end

  def log(s)
    puts "XXX: #{s}"
  end
end
