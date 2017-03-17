

class PlayState < State
    TUBE_SPACING = 125
    TUBE_COUNT = 4
    GROUND_Y_OFFSET = -50

    def initialize gsm
        super(gsm)
        @bg = Texture.new("bg.png")
        @ground = Texture.new("ground.png")


        @score_sound = Gdx.audio.newSound(Gdx.files.internal("sfx_point.ogg"))

        @font = BitmapFont.new(Gdx.files.internal("04b_19.fnt"))
        @font.getData().setScale(0.50, 0.50)

        @playBtn = Texture.new("playbtn.png")

        @gameOver = Texture.new("gameover.png")

        start()
    end

    def start
        @bird = Bird.new 50, 300
        @cam.setToOrtho false, WIDTH/2, HEIGHT/2
        @groundPos1 = Vector2.new(@cam.position.x-@cam.viewportWidth/2, GROUND_Y_OFFSET)
        @groundPos2 = Vector2.new((@cam.position.x-@cam.viewportWidth/2)+@ground.getWidth(), GROUND_Y_OFFSET)
        @score = 0

        @tubes = [] # Array of tubes

        TUBE_COUNT.times do |t|
            @tubes << Tube.new(t*(TUBE_SPACING+TUBE_WIDTH))
        end
    end

    def handleInput
        if Gdx.input.justTouched
            @bird.jump()
        end
    end
    def update dt
        (@loose)? lupdate(dt) : nupdate(dt)
    end
    def lupdate dt
        if Gdx.input.justTouched
            mouse = @cam.unproject(Vector3.new(Gdx.input.getX(), Gdx.input.getY(), 0))
            pb_x = @cam.position.x - @playBtn.getWidth()/2
            pb_y = @cam.position.y - @playBtn.getWidth()*0.50

            if mouse.x >= pb_x && mouse.x <= pb_x+@playBtn.getWidth() &&
                mouse.y >= pb_y && mouse.y <= pb_y+@playBtn.getHeight()
                @loose = false
                start()
            end
        end
    end
    def nupdate dt
        handleInput()
        updateGround()
        @bird.update(dt)
        @cam.position.x = @bird.position.x+80

        @tubes.each do |tube|
            if @cam.position.x-(@cam.viewportWidth/2)>tube.posTopTube.x+tube.topTube.getWidth()
                tube.reposition(tube.posTopTube.x+((TUBE_WIDTH + TUBE_SPACING)*TUBE_COUNT))
                tube.passed = false
            end

            if tube.collides(@bird.bounds)
                @bird.hit()
                @loose = true
            end

            if !tube.passed && @bird.position.x>=tube.posTopTube.x+(tube.topTube.getWidth()/2)
                tube.passed = true
                score()
            end
        end

        if @bird.position.y <= @ground.getHeight()+GROUND_Y_OFFSET
            @bird.hit()
            @loose = true
        end

        @cam.update()
    end
    def render sprite_batch
        (@loose)? lrender(sprite_batch) : nrender(sprite_batch)
    end
    def lrender sprite_batch
        # Still need to show last play on background
        nrender(sprite_batch)

        @font.getData().setScale(0.35, 0.35)

        sprite_batch.setProjectionMatrix(@cam.combined)
        sprite_batch.begin()
        high_score_text = "High Score: #{$high_score}"
        @font.draw(
            sprite_batch,
            high_score_text,
            @cam.position.x-(high_score_text.size * @font.getScaleX()*20),
            @cam.viewportHeight*0.84)

        sprite_batch.draw(@gameOver, @cam.position.x-@gameOver.getWidth()/2, @cam.position.y+@gameOver.getHeight()*0.50)

        sprite_batch.draw(@playBtn, @cam.position.x - @playBtn.getWidth()/2, @cam.position.y-@playBtn.getWidth()*0.50)
        sprite_batch.end()

        @font.getData().setScale(0.50, 0.50)
    end
    def nrender sprite_batch
        sprite_batch.setProjectionMatrix(@cam.combined)
        sprite_batch.begin()

        sprite_batch.draw(@bg, @cam.position.x-(@cam.viewportWidth/2), 0)
        sprite_batch.draw(@bird.texture, @bird.position.x, @bird.position.y)

        @tubes.each do |tube|
            sprite_batch.draw(tube.topTube, tube.posTopTube.x, tube.posTopTube.y)
            sprite_batch.draw(tube.bottomTube, tube.posBotTube.x, tube.posBotTube.y)
        end

        @font.draw(
            sprite_batch,
            @score.to_s,
            @cam.position.x-(@font.getScaleX()*@score.size),
            @cam.viewportHeight*0.97)

        sprite_batch.draw(@ground, @groundPos1.x, @groundPos1.y)
        sprite_batch.draw(@ground, @groundPos2.x, @groundPos2.y)
        sprite_batch.end()
    end
    def updateGround
        if @cam.position.x-(@cam.viewportWidth/2)>@groundPos1.x+@ground.getWidth()
            @groundPos1.add(@ground.getWidth()*2, 0)
        end
        if @cam.position.x-(@cam.viewportWidth/2)>@groundPos2.x+@ground.getWidth()
            @groundPos2.add(@ground.getWidth()*2, 0)
        end
    end

    def score
        @score += 1
        @score_sound.play()
        if @score > $high_score
            $high_score=@score
        end
    end

    def dispose
        @bg.dispose()
        @bird.dispose()
        @ground.dispose()
        @font.dispose()
        @playBtn.dispose()
        @gameOver.dispose()
        @score_sound.dispose()
        @tubes.each { |tube| tube.dispose() }

        puts "Play State Disposed"
    end
end
