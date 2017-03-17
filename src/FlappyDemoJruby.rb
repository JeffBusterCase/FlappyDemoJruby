class FlappyDemo < ApplicationAdapter
    def create
        @batch = SpriteBatch.new()
        @gsm = GameStateManager.new()
        @music = Gdx.audio.newMusic(Gdx.files.internal("music.mp3"))
        @music.setLooping(true)
        @music.setVolume(0.1)
        @music.play()
        Gdx.gl.glClearColor(1, 0, 0, 1)
        @gsm.push(MenuState.new(@gsm))
    end

    def render
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT)
        @gsm.update(Gdx.graphics.getDeltaTime())
        @gsm.render(@batch)
    end

    def dispose
        super()
        @music.dispose()
    end
end
