extends TextureRect

export(Texture) var neutral_texture
export(Texture) var destabilized_texture
export(Texture) var stabilized_texture

func display_state(state):
	match state:
		Reactor.StabilizeState.STABILIZED: self.texture = stabilized_texture
		Reactor.StabilizeState.DESTABILIZED: self.texture = destabilized_texture
		Reactor.StabilizeState.NEUTRAL: self.texture = neutral_texture
		_: self.texture = neutral_texture
