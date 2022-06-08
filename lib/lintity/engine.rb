module Lintity
  class Engine < ::Rails::Engine
    isolate_namespace Lintity

    initializer 'lintity.importmap', before: 'importmap' do |app|
      app.config.importmap.paths << root.join('config/importmap.rb')
      app.config.importmap.cache_sweepers << root.join('app/assets/javascripts')
    end

    initializer 'lintity.assets' do |app|
      app.config.assets.precompile += %w(lintity_manifest)
    end

  end
end
