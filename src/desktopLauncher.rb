java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration

config = LwjglApplicationConfiguration.new()
config.width = 480
config.height = 800
config.title = "FlappyDemoJruby"
LwjglApplication.new(FlappyDemo.new(), config)
