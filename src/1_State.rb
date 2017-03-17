

class State
    def initialize gsm
        @gsm = gsm
        @cam = OrthographicCamera.new
        @mouse = Vector3.new
    end
    def handleInput
        raise NotImplementedError, "You must implement `#{__method__}` from State class"
    end
    def update
        raise NotImplementedError, "You must implement `#{__method__}` from State class"
    end
    def render sprite_batch
        raise NotImplementedError, "You must implement `#{__method__}` from State class"
    end
    def dispose
        raise NotImplementedError, "You must implement `#{__method__}` from State class"
    end
end
