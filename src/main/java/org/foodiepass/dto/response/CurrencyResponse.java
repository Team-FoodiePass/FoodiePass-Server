package org.foodiepass.dto.response;

import lombok.Builder;
import org.foodiepass.server.domain.Currency;

import static lombok.AccessLevel.PRIVATE;

@Builder(access = PRIVATE)
public record CurrencyResponse(
        String currencyName
) {
    public static CurrencyResponse from(final Currency currency) {
        return CurrencyResponse.builder()
                .currencyName(currency.getCurrencyName())
                .build();
    }
}
