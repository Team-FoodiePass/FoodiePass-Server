package foodiepass.server.exception.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorMessage {

    TEST_ERROR_MESSAGE(401, "테스트 에러 메시지입니다.");

    private final int status;
    private final String message;
}
