

class Tube
    FLUCTUATION = 130
    TUBE_GAP = 100
    LOWEST_OPENING = 120

    attr_accessor :bottomTube, :topTube, :posTopTube, :posBotTube, :passed

    def initialize x
        @topTube = Texture.new("toptube.png")
        @bottomTube = Texture.new("bottomtube.png")

        @posTopTube = Vector2.new(x, rand(FLUCTUATION)+TUBE_GAP+LOWEST_OPENING)
        @posBotTube = Vector2.new(x, posTopTube.y-TUBE_GAP-bottomTube.getHeight())

        @boundsTop = Rectangle.new(posTopTube.x, posTopTube.y, topTube.getWidth(), topTube.getHeight())
        @boundsBot = Rectangle.new(posBotTube.x, posBotTube.y, bottomTube.getWidth(), bottomTube.getHeight())

        @passed = false
    end

    def reposition x
        @posTopTube.set(x, rand(FLUCTUATION)+TUBE_GAP+LOWEST_OPENING)
        @posBotTube.set(x, posTopTube.y-TUBE_GAP-bottomTube.getHeight())
        @boundsTop.setPosition(@posTopTube.x, @posTopTube.y)
        @boundsBot.setPosition(@posBotTube.x, @posBotTube.y)
    end

    def collides(player)
        player.overlaps(@boundsTop) || player.overlaps(@boundsBot)
    end

    def dispose
        topTube.dispose()
        bottomTube.dispose()
    end
end
