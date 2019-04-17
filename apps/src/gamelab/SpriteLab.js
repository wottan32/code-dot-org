var SpriteLab = function() {
  console.log('Spritelab');
};

module.exports = SpriteLab;

SpriteLab.prototype.init = function() {
  console.log('Spritelab init');

  window.p5.prototype.setBackground = function(color) {
    this.World.background_color = color;
  };

  window.p5.prototype.showTitleScreen = function(titleArg, subTitleArg) {
    this.World.title = titleArg;
    this.World.subTitle = subTitleArg;
  };

  window.p5.prototype.hideTitleScreen = function() {
    this.World.title = this.World.subTitle = '';
  };

  window.p5.prototype.shouldUpdate = function() {
    return this.World.frameCount > 1;
  };
};
