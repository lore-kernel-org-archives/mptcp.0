Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC64689
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 09:30:05 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1192991f8f.0
        for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 02:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692351004; x=1692955804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eeLGq75X9FBlRWVqjsRPQFkHv+uMi/6emkBRHUsGE68=;
        b=zgVgTvIJrsK80UwiKIb+gVWi8lWDMgeRjXks6u5GcIxVEGMzaXXLtgVLkOUgEWo8wc
         d7ms8fr+aZR1YgN3LMrlKPVEebdALfsIPu4mw3gHS+HIRdMr60Laq2V2NE/fnrFw//56
         KNKuhq1WRsRTYS6+T7xH5vsmVWcOOHf2U0CujTalCKWpH/6qaIQMm6U4W6iVjVZ468pp
         xb6LbyaGPMdH0bOBctlNKCMc2beLDDiPtRs9U4CpRHRGrC5R3lDCeZ+SJsXvQ/hDuRi+
         JWJ0/THVzSAhcon7oud0gVpY9epttC0QnHVbmD6Ea/hiyY8OVnR4CkhrqjyYyWRq2q65
         10Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692351004; x=1692955804;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeLGq75X9FBlRWVqjsRPQFkHv+uMi/6emkBRHUsGE68=;
        b=g+xNQEc3lFwCeMrrj5kBph17J3NZjX2VPmfePdygaCedpM1ebVAwebsUyYB1hXRu43
         gywIf4YHeMzWmtT8yvGInLOkZ0bJAgLiEQIcVz6BdxLHSI1gHSaJEoE0fmUezuw8Gbon
         MwKq73FvjaIyiOKURtV8TYWVsuaisSbR6/oaGwyMiNotNjf0I/mi0ZQZcMjtE/Me/tiT
         apjEXF9nc4q3PwOSiBxVT5cD/+vNWyUsQVGoQUpVehA/HNLs+NL7NpUQt5JSK7ERFq2x
         6+uW3YRQ1tOPlDWJO0XVPqfDl0tsZrsXURb/3qkyGqGmxyXgUu/UtusgTalnWMwJGmXH
         1A1w==
X-Gm-Message-State: AOJu0Yx5uaeB1st/fW6GGod4slmE0nUra8sw0+P8SbwCKY/Sn9Pd0cdL
	cQiuC3ACsnS/bQqLVVS3/Z06trUHG9UL9biMEvQ=
X-Google-Smtp-Source: AGHT+IHsN+yzWjdwBW6SK5DZYfFcw5IpXNuYYTvJslONwZbPpwm7xv6iyCoycoFjGZhE9MYbhMEYBA==
X-Received: by 2002:a05:6000:682:b0:319:7abb:4112 with SMTP id bo2-20020a056000068200b003197abb4112mr5315552wrb.21.1692351004241;
        Fri, 18 Aug 2023 02:30:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm2152763wrm.81.2023.08.18.02.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 02:30:03 -0700 (PDT)
Message-ID: <fc630d2b-b6c4-48fa-a175-cfadb1dff604@tessares.net>
Date: Fri, 18 Aug 2023 11:30:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v4 5/6] mptcp: userspace pm remove id 0 address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1692342519.git.geliang.tang@suse.com>
 <3c3c0bdd3e0d8fe5be8701e38f39ce1fd3e20d3c.1692342519.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <3c3c0bdd3e0d8fe5be8701e38f39ce1fd3e20d3c.1692342519.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang

On 18/08/2023 09:12, Geliang Tang wrote:
> This patch adds the ability to send RM_ADDR for local ID 0. Put id 0
> into a removing list, pass it to mptcp_pm_remove_addr() to remove id
> 0 address.
> 
> There is no reason not to allow the userspace to remove the initial
> address (ID 0). This special case was not taken into account not
> letting the userspace to delete all addresses as announced.

Thank you for the new version!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 42 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index d042d32beb4d..059b672b55f7 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -236,7 +236,43 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  
>  	if (!mptcp_pm_is_userspace(msk)) {
>  		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> -		goto remove_err;
> +		goto out;
> +	}
> +
> +	if (id_val == 0) {
> +		struct mptcp_rm_list list = { .nr = 0 };
> +		struct mptcp_subflow_context *subflow;
> +		bool has_id_0 = false;
> +
> +		if (!READ_ONCE(msk->first)) {
> +			GENL_SET_ERR_MSG(info, "no subflow in conn_list");
> +			goto out;
> +		}

Sorry, my previous message was probably not clear: if (msk->first !=
NULL), it means the initial subflow is still there and ID 0 is still
being used. If it is no longer there, ID 0 might still be used by
another subflow and it is required to iterate over the subflow list.

But maybe easier here to skip this "optimisation" (remove this block
above) and simply iterate over the subflow list like we would do for the
other IDs.

EDIT: mmh, if there is another subflow created with ID 0, will it be in
msk->pm.userspace_pm_local_addr_list list? (I didn't check) If yes, it
should also be handled the same way we do for the other subflows. In
this case, maybe it is not needed to iterate over the different subflows
but only the local addr list and if not found (!match), just for ID==0
case, we check if (msk->first != NULL) and create a fake entry? Or we
always create an entry in local_addr_list for ID == 0? (I didn't check
what would be best)

> +
> +		spin_lock_bh(&msk->pm.lock);

Is it enough? To iterate over the subflow list, you don't need the msk
lock? (lock_sock(sk))

> +		mptcp_for_each_subflow(msk, subflow) {
> +			if (subflow->remote_id == 0) {
> +				has_id_0 = true;
> +				break;
> +			}
> +		}
> +		spin_unlock_bh(&msk->pm.lock);
> +
> +		if (!has_id_0) {
> +			GENL_SET_ERR_MSG(info, "address with id 0 not found");
> +			goto out;
> +		}
> +
> +		list.ids[list.nr++] = 0;
> +
> +		lock_sock((struct sock *)msk);
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_pm_remove_addr(msk, &list);
> +		spin_unlock_bh(&msk->pm.lock);
> +		release_sock((struct sock *)msk);
> +
> +		err = 0;
> +		goto out;
>  	}
>  
>  	lock_sock((struct sock *)msk);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
