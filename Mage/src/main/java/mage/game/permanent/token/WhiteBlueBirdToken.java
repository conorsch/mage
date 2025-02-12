package mage.game.permanent.token;

import mage.MageInt;
import mage.abilities.keyword.FlyingAbility;
import mage.constants.CardType;
import mage.constants.SubType;

/**
 * @author spjspj
 */
public final class WhiteBlueBirdToken extends TokenImpl {

    public WhiteBlueBirdToken() {
        super("Bird Token", "1/1 white and blue Bird creature token with flying");
        cardType.add(CardType.CREATURE);
        color.setWhite(true);
        color.setBlue(true);
        subtype.add(SubType.BIRD);
        power = new MageInt(1);
        toughness = new MageInt(1);
        this.addAbility(FlyingAbility.getInstance());
    }

    protected WhiteBlueBirdToken(final WhiteBlueBirdToken token) {
        super(token);
    }

    public WhiteBlueBirdToken copy() {
        return new WhiteBlueBirdToken(this);
    }
}
