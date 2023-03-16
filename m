Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F66FD0
	for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 18:27:48 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id eg48so11108120edb.13
        for <mptcp@lists.linux.dev>; Thu, 16 Mar 2023 11:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678991266;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKxSZXQ3eZVwOIc04ED4zPwxPLQDGJBxBuc5pIqS91U=;
        b=av/ley2OzXpHvEknb17uzBF38Lk7kIsaR3aWac7OiELUKs0v+4xTrF0Lw9RLHl8aQW
         jKVAiZqtyYHeduX9E6Poz9FvKqAOX5uSFFXrHvgLY2NPXNF4VbbaG7fTE+z6RYq0WF2+
         AOz70CGQrx4QmgduX1x79ab57WkEhkme2d/C1jn5vIVdA9NLAIHmZ5cv04fxE0n+1BCm
         7xvojujIzpg/eowCxowkOaoLX6cEQ1dgQMbyXV49tpJNnPPfZKRqHOot7rSprqR+xd2P
         smTZ+UbhIjHVCB8FR/cYLGOvdyqOgkOkkDI0XVgYPhyCmiQpO2yriMQcfmMAcvJQx18h
         JDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678991266;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKxSZXQ3eZVwOIc04ED4zPwxPLQDGJBxBuc5pIqS91U=;
        b=Yc4jTD10WgawljG7IlcEfXSIVnc6AGLg1Jfr2NU6BoPQRyBbSeiTAYs5EhHe/PkSy5
         wg764a3RRLOInrUZIywTAgtxT9MdMw9EmSpzxyRwqqxZecaupwg48XhK763XPRzwTM4H
         DS4871fAhENip51SeydrbjAb/s+GH6r2pfoqJ5bAM7akW/0cyaU7Mf97gx8ZHzS/qtOr
         G6P9D2pI+bOKY5cMeUEbQTSNCtKorni9hFlkffsYbIYoU5uTyc2NDNVpEIHF7AEUHUfN
         +1mNrphOQRTry6UZG+l7B+vmK7cx0CXjqnPB659v6Jx3HSHuLvxnImmO+AfQYk1kUblT
         dMOw==
X-Gm-Message-State: AO0yUKWrD6/mheduv9YyRVw66G+oGVE96BLzt0HtFgjReFVE+Yey6sBx
	f4/sYf4MUbt/apmvRYJXN01VPHSRk7nVF2bZRcvPxb+f
X-Google-Smtp-Source: AK7set/ehTmssf00vQcq24JqeUeHdzn47yOD02AiezJGjsbC3qPLf17F2WUZXHMHJQ0HosNetn0DGQ==
X-Received: by 2002:aa7:dbce:0:b0:4ac:b69a:2f06 with SMTP id v14-20020aa7dbce000000b004acb69a2f06mr747066edt.0.1678991266347;
        Thu, 16 Mar 2023 11:27:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f605:63cd:a743:20d5? ([2a02:578:8593:1200:f605:63cd:a743:20d5])
        by smtp.gmail.com with ESMTPSA id e25-20020a50d4d9000000b004c10b4f9ebesm107810edj.15.2023.03.16.11.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 11:27:46 -0700 (PDT)
Message-ID: <46819c4b-34fb-f28c-fb43-6b5ef58986ee@tessares.net>
Date: Thu, 16 Mar 2023 19:27:45 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next v5 5/7] mptcp: update userspace pm subflows
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1678778977.git.geliang.tang@suse.com>
 <07483b4044333a3d2d6de1e5c06a32672c54a24f.1678778977.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <07483b4044333a3d2d6de1e5c06a32672c54a24f.1678778977.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/03/2023 08:31, Geliang Tang wrote:
> Increase pm subflows counter on both server side and client side when
> userspace pm creates a new subflow, and decrease the counter when it
> closes a subflow.

I guess here as well, we can target -net and add a Fixes tag, no?

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
establishment")
(...)

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 4ed4d29d9c11..bb01f15d8e0a 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -87,8 +87,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
>  	unsigned int subflows_max;
>  	int ret = 0;
>  
> -	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_active(msk);
> +	if (mptcp_pm_is_userspace(msk)) {
> +		if (mptcp_userspace_pm_active(msk)) {
> +			spin_lock_bh(&pm->lock);
> +			pm->subflows++;
> +			spin_unlock_bh(&pm->lock);
> +			return true;
> +		}
> +		return false;
> +	}
>  
>  	subflows_max = mptcp_pm_get_subflows_max(msk);
>  
> @@ -181,8 +188,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>  	struct mptcp_pm_data *pm = &msk->pm;
>  	bool update_subflows;
>  
> -	update_subflows = (subflow->request_join || subflow->mp_join) &&
> -			  mptcp_pm_is_kernel(msk);
> +	if (mptcp_pm_is_userspace(msk)) {
> +		spin_lock_bh(&pm->lock);
> +		pm->subflows--;
> +		spin_unlock_bh(&pm->lock);
> +		return;
> +	}
> +
> +	update_subflows = (subflow->request_join || subflow->mp_join);
>  	if (!READ_ONCE(pm->work_pending) && !update_subflows)
>  		return;

I'm sorry, I'm not sure to understand why you do this here (and above)
and not just in mptcp_nl_cmd_sf_create() and _destroy() like you did in
the v3?

Cheers,
Matt

>  
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 09b4b359d960..465928c59917 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -310,6 +310,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  
>  	spin_lock_bh(&msk->pm.lock);
>  	msk->pm.local_addr_used++;
> +	msk->pm.subflows++;
>  	spin_unlock_bh(&msk->pm.lock);
>  
>  	lock_sock(sk);

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
