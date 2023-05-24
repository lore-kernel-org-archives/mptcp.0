Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9569B60870
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 13:21:13 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso8047215e9.3
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684934471; x=1687526471;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A6wujJSWJXmdVQBgywXeqR3vQHbQetxZmwliNGAJMjk=;
        b=JqUdh3SdKWZ/VuACXoURmCJL5TMIdqunzUC7wXmZfUSp9R7CkXhiLOPx7JVmwSvPLT
         h+OlAB6LaTqoi4VdQDVkNXJutTWPMB4nmmW98snJhaB9yLp+ppeGxMysTxTqTELMLZmx
         xy8F9EGKALHIH74omWxhf+y0Sw0NPKGyEdDVBGkWNhh7Ax1MMYuBfjnTTz1rAnhUf0Y8
         VKqFjX6WhV4RwnXbM9RMBYB0r+GAyY5FyUCrgtsrUXfQu5JnciLg90hUaT6rLr1nmh0+
         9UhJqvCvMo4iLh7LmK7XmoKcFHPXaE9Z/Z2TPUPglx2VPVQnhu+iy/uumiw6o4kLsBa6
         Lmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684934471; x=1687526471;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6wujJSWJXmdVQBgywXeqR3vQHbQetxZmwliNGAJMjk=;
        b=RPafHEAiVOJyOg0XDD9/r07DZpONnTFnHfVp1G8pm3SL/s/rB0XP2Cl93KSmf9VAKz
         7YpCsEddlkfxf8NGKtVPSMJT/y3wypiHolYx0pOsuzr6wW3AMRteIdT9ghYfYteWOIgo
         Tl/GLU3l3fkKp0GTLC75r7rCj1icqUxeWCBEbD6Oyg68hwCTJ5KBl8yrXkl5A5iGm6Sv
         MpnMhR5fV94qACvKmWbGhN7Tb8jeJIcxq+isz5RGerE+QUDmONjSCPKZqWiNh/6QaJQd
         2eJYF4GGwRnPXMG4IxEaB8jXimm4ObTeaQTMrIutjAx8XqxNwauixDjnCM4W3yEjQfty
         20Zw==
X-Gm-Message-State: AC+VfDxFHPrClEsz99AfZA7nEOzjj6OdrvZjXkkdewHANjfLu4Tr56ZS
	eRbLZXmPmYEiB9OCpAW2POod1uRbXkwAM+xnYlDIpw==
X-Google-Smtp-Source: ACHHUZ5T32tEZjoOGoq59IE6FVdLJdxm3+Rk3PVIJmaq86UAtAlXND9xUTm28+1wEE4fNWdZ0cLiow==
X-Received: by 2002:a05:600c:294c:b0:3f5:fa8e:aaa3 with SMTP id n12-20020a05600c294c00b003f5fa8eaaa3mr10662419wmd.28.1684934471343;
        Wed, 24 May 2023 06:21:11 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id q13-20020a7bce8d000000b003f43f82001asm2344602wmj.31.2023.05.24.06.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:21:11 -0700 (PDT)
Message-ID: <d0b910d4-8b8b-ae47-c8f7-267c3a1238d2@tessares.net>
Date: Wed, 24 May 2023 15:21:10 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v15 3/5] mptcp: add address into userspace pm
 list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684915182.git.geliang.tang@suse.com>
 <b897ae1cbd3615b1304cac6f3dcefe42854f273b.1684915182.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b897ae1cbd3615b1304cac6f3dcefe42854f273b.1684915182.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/05/2023 10:02, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
> it in the new helper mptcp_userspace_pm_delete_local_addr().
> 
> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> it when connecting fails.
> 
> By doing this, the "REMOVE" command also works with subflows that have
> been created via the "SUB_CREATE" command instead of restricting to
> the addresses that have been announced via the "ANNOUNCE" command.
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..114548b09f47 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c

(...)

> @@ -302,12 +327,24 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	local.addr = addr_l;
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "did not match address and id");
> +		goto create_err;
> +	}
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
>  
>  	release_sock(sk);
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	if (err)
> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +	spin_unlock_bh(&msk->pm.lock);

I was going to ask to move the lock inside the 'if' condition but patch
5/5 introduces a else condition which also needs the lock, all good then.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
