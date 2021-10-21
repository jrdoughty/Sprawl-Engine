package components;

class ButtonComp {


    public function new() {//Do I need this?
        background = backgroundSprite;
		background.x = x;
		background.y = y;
		background.scaleX = width/background.width;
		background.scaleY = height/background.height;
		text = new Text(textString, Math.round(x + background.width/10), Math.round(y + background.height/10),fontSize==null?Math.round(height*.66):fontSize);
		Scene.the.addOther(background);
		this.click = click;
		buttons.push(this);
    }
}