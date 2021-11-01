package cn.xueden.gateway.response;

import lombok.Getter;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;

/**
 * @Auther:梁志杰
 * @Date:2021/10/30
 * @Description:cn.xueden.gateway.response
 * @version:1.0
 */
@Getter
public class ErrorResponse {

    private  LocalDateTime timestamp;

    private  int status;

    private  String error;

    private  String message;

    public ErrorResponse(HttpStatus httpStatus, String errCode, String message) {
        this.timestamp = LocalDateTime.now();
        this.status = httpStatus.value();
        this.error = errCode;
        this.message = message;
    }

    public ErrorResponse(String errCode, String message) {
        this.timestamp = LocalDateTime.now();
        this.error = errCode;
        this.message = message;
    }
}
