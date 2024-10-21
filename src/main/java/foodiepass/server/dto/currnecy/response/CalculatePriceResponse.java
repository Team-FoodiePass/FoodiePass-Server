package foodiepass.server.dto.currnecy.response;

public record CalculatePriceResponse(
        String totalPriceWithOriginCurrencyUnit,
        String totalPriceWithUserCurrencyUnit
) {

}
