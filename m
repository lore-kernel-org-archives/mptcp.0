Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99842C81
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 14:43:50 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id v18so24230830edc.11
        for <mptcp@lists.linux.dev>; Thu, 07 Oct 2021 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=njjwvtUpFGN1ZWez0w1XlL69EBC7H6gfemr1iexnaDI=;
        b=fwLYnPTpVRraOPEfKPCheC1+wGPDNAy1+kGxRB5wl6e3hIytEJjJnneFlBjC/uQY97
         mUkUJfpnkajUAtKUN8tGRK+Ro1KRWF82zxSVlUQqgQ0cbddDVD3L/G6ByYaVR0qUIWr/
         f7pV0aJ+9xZBB+evAwoztPIoOaMZk3r7siustmEdlY2MbpWMWpiE+xGXhwA0QbJ6O3UV
         JTRTRv4EFreFtlJbsgO5Pq7/FnvYcNtJjTE38eb/YuM5AYI+onXlsVjC+YTeigOt26VT
         W9jNO24RsuPX0z/UVW8IFYtNoClzMKcLYcbs0hHWPHAEkiARYcI5YKDtLjnkl9GvXN+X
         829w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=njjwvtUpFGN1ZWez0w1XlL69EBC7H6gfemr1iexnaDI=;
        b=VN18QlCNJkDP+XgHRaO2eTu7wKaiHa4R4/gjYdfAxkmz3ypwdcRVYQ4bLvi3jfczXy
         0vHEpes+Ui70JD3BnCw+Ue2ofW0KfpndSP6z6pxGbhNjXI/d6SyK3wOws6WP8B7SuDZ4
         E0+23sffH6DdF7R2j1z0Qxd9+p4Qns5y58SLP3P373/kBu0AuiZ3ypSk4WeokKmOutQb
         eBWDXWSqjHpuPkT3xDEqhuIHcXLK8hCT3dil5p8BmpFdq6s+kmHX635INElu90p565Vt
         2DKA0ORa0PFBsIPaeckxXomSy4DV+VY57gNycss7I2nmDMlz3ooVFjeXAUjfx3n8B0VE
         es6Q==
X-Gm-Message-State: AOAM532bmmnM7Yj/dUcAD2mX0HkuHEbAlTjdQUnT+V+6Ej9tIYjnJvij
	d5Kv7/d84yJrHuoyqLPhT0dpbw==
X-Google-Smtp-Source: ABdhPJz4KXJXACRG6yghQRm/NoU+1VxCxpkpROq/tX/kS1x6gXaTK649srppWDfahPWxwOGznR9P5w==
X-Received: by 2002:a17:906:fad4:: with SMTP id lu20mr1802252ejb.316.1633617828410;
        Thu, 07 Oct 2021 07:43:48 -0700 (PDT)
Received: from [192.168.178.46] (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id 10sm10205222eju.12.2021.10.07.07.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 07:43:47 -0700 (PDT)
Message-ID: <0591b474-2432-905a-9bef-d697aa336e0e@tessares.net>
Date: Thu, 7 Oct 2021 16:43:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH 1/4] mptcp: pm_netlink: Add MPTCP_PM_CMD_ANNOUNCE
Content-Language: en-GB
To: Kishen Maloor <kishen.maloor@intel.com>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
 <20211007043656.261552-2-kishen.maloor@intel.com>
Cc: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20211007043656.261552-2-kishen.maloor@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kishen,

On 07/10/2021 06:36, Kishen Maloor wrote:
> This change adds a MPTCP netlink interface command for issuing
> ADD_ADDR advertisements over the chosen MPTCP connection from a
> userspace path manager.
> 
> The command requires the following parameters:
> {token, {loc_id, family, saddr4 | saddr6 [, sport]} }.

Thank you for looking at that!

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2a3589b67768..1b41bbc70529 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c

(...)

> +static int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR],
> +		*token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +	struct mptcp_sock *msk;
> +	struct mptcp_pm_addr_entry _addr;
> +	u32 _token;

Small detail but maybe clearer to avoid using variable with almost the
same name: 'addr' vs '_addr' and 'token', vs '_token'. What about
'addr_attr' and 'token_attr'?

Same in 'mptcp_nl_cmd_remove()'.

> +	int err;
> +
> +	if (!addr || !token) {
> +		GENL_SET_ERR_MSG(info, "missing announce info");
> +		return -EINVAL;
> +	}
> +
> +	err = mptcp_pm_parse_addr(addr, info, true, &_addr);
> +	if (err < 0)
> +		return err;
> +
> +	_token = nla_get_u32(token);
> +
> +	msk = mptcp_token_get_sock(sock_net(skb->sk), _token);
> +	if (!msk) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +		return -EINVAL;

Should we try to return different err code per kind of error? Or the
error message is enough?

For example, we could return -ENOTCONN or -ENOKEY even if the string
linked to it is not 100% accurate? ("Transport endpoint is not
connected" and "Required key not available").

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
