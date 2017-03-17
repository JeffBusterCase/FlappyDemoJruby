

class MenuState < State
    def initialize gsm
        super(gsm)
        @cam.setToOrtho(false, WIDTH/2, HEIGHT/2)
        @background = Texture.new("bg.png")
        @playBtn = Texture.new("playbtn.png")
        @font = BitmapFont.new(Gdx.files.internal("04b_19.fnt"))
        @font.getData().setScale(0.35, 0.35)
    end
    def handleInput()
        if Gdx.input.justTouched
            @gsm.set PlayState.new @gsm
        end
    end
    def update dt
        handleInput()
    end
    def render sprite_batch
        sprite_batch.setProjectionMatrix(@cam.combined)
        sprite_batch.begin()
        sprite_batch.draw(@background, 0, 0)
        high_score_text = "High Score: #{$high_score}"
        @font.draw(
            sprite_batch,
            high_score_text,
            @cam.position.x-(high_score_text.size * @font.getScaleX()*20),
            @cam.viewportHeight*0.84)

        sprite_batch.draw(@playBtn, @cam.position.x - @playBtn.getWidth()/2, @cam.position.y-@playBtn.getWidth()*0.50)
        sprite_batch.end()
    end
    def dispose
        @background.dispose()
        @playBtn.dispose()
        @font.dispose()
        puts "Menu State Disposed"
    end
end
