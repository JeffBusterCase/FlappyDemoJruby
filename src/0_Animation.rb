

class Animation
    def initialize texReg, frameCount, cycleTime
        @frames = []# Array of TextureRegion
        frameWidth = texReg.getRegionWidth()/frameCount

        frameCount.times do |i|
            @frames << TextureRegion.new(texReg, i*frameWidth, 0, frameWidth, texReg.getRegionHeight())
        end

        @frameCount = frameCount
        @maxFrameTime = cycleTime/frameCount
        @frame = 0
        @currentFrameTime = 0.0
    end
    def update dt
        @currentFrameTime += dt
        if @currentFrameTime>@maxFrameTime
            @frame += 1
            @currentFrameTime = 0
        end
        if @frame >= @frameCount
            @frame = 0
        end
    end
    def getFrame
        @frames[@frame]
    end
end
