package foodiepass.server.dto.currnecy.response;

import foodiepass.server.domain.Currency;

public record CurrencyResponse(String currencyName) {

    public static CurrencyResponse from(final Currency currency) {
        return new CurrencyResponse(currency.getCurrencyName());
    }
}

