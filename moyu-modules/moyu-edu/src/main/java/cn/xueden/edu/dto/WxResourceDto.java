package cn.xueden.edu.dto;

import lombok.Data;

/**功能描述： 微信通知数据
 * @Auther:梁志杰
 * @Date:2021/5/21
 * @Description:cn.xueden.edu.dto
 * @version:1.0
 */
@Data
public class WxResourceDto {

    // 加密算法类型 对开启结果数据进行加密的加密算法，目前只支持AEAD_AES_256_GCM
    private String algorithm;

    // 数据密文 Base64编码后的开启/停用结果数据密文
    private String ciphertext;

    // 附加数据
    private String associated_data;

    // 原始类型 原始回调类型，为transaction
    private String original_type;

    // 随机串 加密使用的随机串
    private String nonce;
}
