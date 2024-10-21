package foodiepass.server.exception.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorMessage {

    //Currency
    CURRENCY_RATE_SCRAPING_FAILED(500, "Google Finance 페이지 크롤링에 실패했습니다."),
    CURRENCY_RATE_ELEMENT_NOT_FOUND(404, "Google Finance 페이지에서 환율 요소를 찾을 수 없습니다."),
    ;

    private final int status;
    private final String message;
}
