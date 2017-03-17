

class Bird
    attr_reader :position, :bounds
    GRAVITY = -15
    MOVEMENT = 100
    def initialize x, y
        @position = Vector3.new x, y, 0
        @velocity = Vector3.new 0, 0, 0
        @texture = Texture.new("birdanimation.png")
        @birdAnimation = Animation.new(TextureRegion.new(@texture), 3, 0.5)
        @bounds = Rectangle.new(x, y, @texture.getWidth()/3, @texture.getHeight())
        @flap = Gdx.audio.newSound(Gdx.files.internal("sfx_wing.ogg"))
        @hit = Gdx.audio.newSound(Gdx.files.internal("sfx_hit.ogg"))
    end

    def update dt
        @birdAnimation.update dt
        if @position.y > 0
            @velocity.add(0, GRAVITY, 0)
        end

        @velocity.scl dt
        @position.add(MOVEMENT*dt, @velocity.y, 0)

        if(@position.y<0)
            @position.y = 0
        end

        @velocity.scl 1/dt
        @bounds.setPosition @position.x, @position.y
    end

    def texture
        @birdAnimation.getFrame()
    end

    def jump
        @velocity.y = 325
        @flap.play 0.5
    end

    def hit
        @hit.setVolume(@hit.play(), 0.5)
    end

    def dispose
        @texture.dispose()
        @flap.dispose()
    end
end
