// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Prompt = Class.create({
	// Called for all .prompted elements on dom:loaded
	initialize: function(el) {
		this._parent = $(el);
		this._input = this._parent.down("input");
		this._label = this._parent.down("label");

		// Add Event Listeners 
		this._input.observe("focus", this.focus.bind(this));
		this._input.observe("blur", this.blur.bind(this));
		this._label.observe("click", this.focus.bind(this));
	},
	focus: function() {
		this._parent.addClassName("focused");
	},
	blur: function() {
		if($F(this._input).empty()) {
			this._parent.removeClassName("focused");
		}
	}
});

document.observe("dom:loaded", function() {
	$$(".prompted").each(function(el) { new Prompt(el); });
});
