LiveTogether.Views.ChoresIndex = Backbone.View.extend({

  template: JST['chores/index'],

  className: 'large-12 columns',

  initialize: function(){
    console.log('chores index view initialized');
    this.$el.html(this.template());
    this.listenTo(this.collection, 'add', this.addOne);
    this.listenTo(this.collection, 'reset', this.addAll);
    if (this.collection.length === 0){
      this.collection.fetch();
    } else {
      this.addAll();
    }
  },

  events: {
    "click .new-chore": "newChoreForm"
  },

  render: function(){
    this.delegateEvents(this.events);
    return this;
  },

  addAll: function(){
    this.collection.each(this.addOne, this);
  },

  addOne: function(model){
    var view = new LiveTogether.Views.Chore({model: model});
    this.$el.find('tbody').append(view.render().el);
  },

  newChoreForm: function(){
    var view = new LiveTogether.Views.ChoreForm({collection: this.collection});
    this.$el.append(view.render().$el.hide().fadeIn());
  }

});
