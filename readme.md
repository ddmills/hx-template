Haxe heaps game template


features

1. ECS
2. Prefab system
3. robust Saving/Loading
4. keybindings, input handling
5. Screen system
6. Rendering Layers
7. Cool data structures - Grid, IntPoint, FloatPoint, Coordinate, WeightedTable, PriorityQueue
8. Cool algorithsm - Astar, Bresenham, Shadowcast, Floodfill
9. Tweening

```haxe
// Define an "Attacked" event
class AttackedEvent extends EntityEvent
{
	public var dmg:Int;

	public function new(dmg:Int)
	{
		this.dmg = dmg;
	}
}

...

// Define a "Health" component
class Health extends Component {
	// We want these two variables to be saved
	@save public var value:Int;
	@save public var max:Int;

	public function new(max:Int) {
		this.max= max;
		this.value = max;

		// register a handler for an event
		addHandler(AttackedEvent, onAttacked);
	}

	private function onAttacked(evt:AttackedEvent)
	{
		value -= evt.dmg;

		if (value <= 0)
		{
			entity.add(new IsDead());
		}
	}
}

...

// Spawn an entity with a Health component
var entity = new Entity();
entity.add(new Health(100));

...

// Query all entities that have a "Health" component, and are not dead or frozen
var query = new Query({
	all: [Health],
	none: [IsDead, IsFrozen],
});

...

// loop over any entities that match the query
for (e in query) {
	// log entity info
	trace(e.id, e.x, e.y);

	// get a component
	var hp = e.get(Health);
	trace(hp.value);

	// maybe fire an event on the entity
	e.fireEvent(new AttackedEvent(5));
}

...

// immediately react to an entity matching a query
query.onEntityAdded(e -> {
	trace('entity matches query!');
});

query.onEntityRemoved(e -> {
	trace('entity no longer matches query!');
});

```

