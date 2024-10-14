package foodiepass.server.exception.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SuccessMessage {

    TEST_SUCCESS_MESSAGE(200, "테스트 성공 메시지입니다");

    private final int status;
    private final String message;
}
