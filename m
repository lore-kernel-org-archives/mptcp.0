Received: from fallback16.mail.ru (fallback16.mail.ru [94.100.177.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2D70
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail3;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=svhgGIOS2/hW6FytAUokF0fNUfLr8KqMEDC5pHKE3zg=;
	b=JAhhbnBKR5XXNC2EWp9ND3b6oglORvYGfzgtifDecOEoObhuv6lwfWWv/FKEDD9nS6HMdUcxO06tMYEsR5td74QEDPPcH3RGA7RFcJ/lAPxckAR/h4bETQoMROTfOifizZgwkNuf/4/166s/uGSTc2ih4/4SljLtKn6OuQvuymc=;
Received: from [10.161.22.25] (port=58774 helo=smtp55.i.mail.ru)
	by fallback16.i with esmtp (envelope-from <max@internet.ru>)
	id 1looMR-0003dt-Mh
	for mptcp@lists.linux.dev; Thu, 03 Jun 2021 17:30:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=internet.ru; s=mail3;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=svhgGIOS2/hW6FytAUokF0fNUfLr8KqMEDC5pHKE3zg=;
	b=j47x+eaokvG9EZzOgxBjdA3NeChp5vA7XZ1PpTzEDxFChrYPwn90raD19kpTlO/Jjn6iAWK6wcXMAFac7NrwWWubTpcRpwQ7xuXURe0Dn5eF+X4TNacoNnRrmFM0OpGoZNELTUQd6002zr4/KxEdC5X+j/g0wifsTjU8eyX2u/E=;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <max@internet.ru>)
	id 1looMJ-0008Bm-QV; Thu, 03 Jun 2021 17:30:08 +0300
Subject: Re: [PATCH mptcp-next] mptcp: add MIB counter for invalid mapping
To: Paolo Abeni <pabeni@redhat.com>
References: <89666f3fb8f14bbe545f2079794ab78ba24fbbc4.1622720045.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
From: Maxim Galaganov <max@internet.ru>
Message-ID: <ae6bfc3a-e6e2-f9aa-ed9f-e5aca04ed65b@internet.ru>
Date: Thu, 3 Jun 2021 17:30:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <89666f3fb8f14bbe545f2079794ab78ba24fbbc4.1622720045.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D5B0DA836B685C54907A7AE9C1BA82BC67C1327DFB87C6A6182A05F53808504066A8E1CB8FD362B31375CD0203F2E6B28564B51B19AE44ADED0591FD5EB1BEB2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75037DDE13FB75316EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637E8F1A1743CF948808638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82B3A4A9A6050771ABE8A23EB2AAA3A1C6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7E4CD18687D5AE3809FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FBDFBBEFFF4125B51D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BC493A577044FAF45A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A3920E30A4C9C8E338DA71F0BD0CACA6A43743847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5065EE57DEA1D3075DF557300F34E640F06D49525AEC5470CD59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA7569C34DB4251AA965410CA545F18667F91A7EA1CDA0B5A7A0
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3442AF01057B6BF997C7EA41B63CD61343E99FFE9FDAD647442D5CB2B4CC014C2C0DF1C1D3BABC527A1D7E09C32AA3244C3398CAD41BF04556175818FC743B8EF6F2F5F14F68F1805B729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojNbQUdF9mq4EID/9zRCyWOA==
X-Mailru-Sender: 3B9A0136629DC91243040E847DF3D73A9FC0192A7C9D15771375CD0203F2E6B2EC9A243AB1C8B1BC84390AFDD794B14678274A4A9E9E44FD5B858845640BC0C1AB428D199E4977E267EA787935ED9F1B
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4F6336583864642B6E715ED18CC527C3ACB4D7179280743A868F3CF0E9FE49B6918222AAF5A16A518C1EED05BBF74227D6CAFEF612B5A46D54B1D86DC3FE940C5
X-7FA49CB5: 0D63561A33F958A59B20AD5835CB85B01C67CA3C0F2103A4FC2E3665FAE4B632CACD7DF95DA8FC8BD5E8D9A59859A8B6A096F61ED9298604
X-C1DE0DAB: 0D63561A33F958A59B20AD5835CB85B01C67CA3C0F2103A40B795B5A80738124D59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdg+c3AsmhJFRPModc3OGvrg==
X-Mailru-MI: 800
X-Mras: Ok

03.06.2021 16:25, Paolo Abeni пишет:
> Account this exceptional events for better introspection.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>   net/mptcp/mib.h     | 1 +
>   net/mptcp/subflow.c | 4 +++-
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 92e56c0cfbdd..193466c9b549 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
>   	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
>   	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
>   	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
> +	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */

Shouldn't there also be a related change to mptcp_snmp_list in mib.c ?

>   	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
>   	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
>   	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 259f99b61c35..ccc07cbab867 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1046,8 +1046,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>   	/* we revalidate valid mapping on new skb, because we must ensure
>   	 * the current skb is completely covered by the available mapping
>   	 */
> -	if (!validate_mapping(ssk, skb))
> +	if (!validate_mapping(ssk, skb)) {
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
>   		return MAPPING_INVALID;
> +	}
>   
>   	skb_ext_del(skb, SKB_EXT_MPTCP);
>   
> 

