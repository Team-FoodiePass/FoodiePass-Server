package foodiepass.server.dto.currnecy.request;

import java.util.List;

public record CalculatePriceRequest(
        String originCurrency,
        String userCurrency,
        List<OrderElementRequest> orders
) {

    public record OrderElementRequest(Double originPrice, Double userPrice, int quantity) {

    }
}
