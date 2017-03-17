class GameStateManager
    def initialize
        @states = Stack.new()
    end
    def push state
        @states.push state
    end
    def pop
        @states.pop.dispose()
    end
    def set state
        @states.pop.dispose()
        @states.push(state)
    end
    def update dt
        @states.peek().update(dt)
    end
    def render sprite_batch
        @states.peek().render sprite_batch
    end
end
