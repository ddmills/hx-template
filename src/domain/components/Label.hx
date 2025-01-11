package domain.components;

import ecs.Component;

class Label extends Component
{
	@save public var name:String;

	public function new(name:String)
	{
		this.name = name;
	}
}
