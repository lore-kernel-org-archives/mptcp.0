Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD119BDF
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:01:07 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f6dfc4dffaso4453245e9.0
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685030466; x=1687622466;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BEblj6zojzmVHrJEyW0wwQRTo/s/K9LTXiWs3peQt6Y=;
        b=gAtTR/FLpW24IeLfO9DD5pNtN3g+x3eH/MOsq3mCwtpa4yKs+ckgmP4EEby9HGLdMP
         v3xKYURlJUzOveBP7A8XmuEYaBk0FlSNae5q6/67v8Lye+P4RqYPadbgkN4KtzEUuEzl
         Qwibx1Z1bWfNMxhcHR4da9R7/tB2idyNcdNE23ARVnUWwC3R3rksWcgA3nRdEOvxgq1X
         7PLuNNHEWXr39oAs1qd+nnp77FAGXeDY5a+U2o4pDmp6P4T+uJytiGDfFqHqKLESJHVK
         mMHzlcCdZTKje48CaDW/kg5s8MKWMhZxe0R7yPteomfLwMgXvccftMhyaj2/GOy0MYLY
         EJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030466; x=1687622466;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEblj6zojzmVHrJEyW0wwQRTo/s/K9LTXiWs3peQt6Y=;
        b=JR1xyT00yBpy5Np64d76FTQRMZZPRVhGeUsZzZVeVC8OoiMe9Y2+wi8lhobfdsl8zw
         t5BoEjrNeJAWh1MfS9uEIdWdGlmSOBVX1ETer5ClTxAQdb3eGlehXbUGh6QG1amptvuM
         ieYKYi9ltsDiLe/KqUcoLZHYL/3JSte1F2n7aZwMP+Z37uc5uyyQjP9b3ids5jml7xWf
         g1f9EtGoispWJQSMx/oE4bJCV+lgszevkeNDDyLAYVW/tOrurk8JsO2PoC+QA5ROSvlZ
         FfEHkAW66Bjuf7+TIMJuTh4Cb2+eNVsA6/55I/g+1D5VNun8GAg7XUqvwnyzi8toC3Y+
         Rw5g==
X-Gm-Message-State: AC+VfDzNEJE08kXMdHOtbhWUWIflWH95T+pIfMmdU98KQiA1GY4QyMUB
	8xY5Zfw4zTaPY0pgKoqOhgu+yNL6do3xALZcm7g=
X-Google-Smtp-Source: ACHHUZ6KIxAwTTXaf4N9Buxm6HyyUjf2PnzWkNN3/gUeQSt3iCp+bCPnJPaSwmo1jDZ5fAZiGO+Lvw==
X-Received: by 2002:a05:600c:2255:b0:3f6:1e6:d5a2 with SMTP id a21-20020a05600c225500b003f601e6d5a2mr2987029wmm.4.1685030465965;
        Thu, 25 May 2023 09:01:05 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b002f7780eee10sm2218056wrx.59.2023.05.25.09.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:01:05 -0700 (PDT)
Message-ID: <8b8edc82-1f11-612e-79f0-92dbfa46b364@tessares.net>
Date: Thu, 25 May 2023 18:01:05 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 2/4] mptcp: unify pm get_local_id interfaces
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685001897.git.geliang.tang@suse.com>
 <b757cd4da3d5519524b2d83fda4d0d7ded3c6798.1685001897.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b757cd4da3d5519524b2d83fda4d0d7ded3c6798.1685001897.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/05/2023 10:07, Geliang Tang wrote:
> This patch unifies the three PM get_local_id() interfaces:
> 
> mptcp_pm_nl_get_local_id() in mptcp/pm_netlink.c for the in-kernel PM and
> mptcp_userspace_pm_get_local_id() in mptcp/pm_userspace.c for the
> userspace PM.
> 
> They'll be switched in the common PM infterface mptcp_pm_get_local_id()
> in mptcp/pm.c.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm.c         | 13 +++++++++++++
>  net/mptcp/pm_netlink.c | 10 ----------
>  net/mptcp/protocol.h   |  2 +-
>  3 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e7f944d09fcd..e37df2f45c70 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -408,6 +408,19 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  {
> +	struct mptcp_addr_info skc_local;
> +	struct mptcp_addr_info msk_local;
> +
> +	/* The 0 ID mapping is defined by the first subflow, copied into the msk
> +	 * addr
> +	 */
> +	mptcp_local_address((struct sock_common *)msk, &msk_local);
> +	mptcp_local_address((struct sock_common *)skc, &skc_local);
> +	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
> +		return 0;
> +
> +	if (mptcp_pm_is_userspace(msk))
> +		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
>  	return mptcp_pm_nl_get_local_id(msk, skc);
>  }
>  
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2f58ab49512a..deb097f16abc 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1056,23 +1056,13 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>  {
>  	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_addr_info skc_local;
> -	struct mptcp_addr_info msk_local;
>  	struct pm_nl_pernet *pernet;
>  	int ret = -1;
>  
>  	if (WARN_ON_ONCE(!msk))
>  		return -1;
>  
> -	/* The 0 ID mapping is defined by the first subflow, copied into the msk
> -	 * addr
> -	 */
> -	mptcp_local_address((struct sock_common *)msk, &msk_local);
>  	mptcp_local_address((struct sock_common *)skc, &skc_local);

If you still need skc_local for the in-kernel PM, why not passing it as
a new argument to this function like what we do for the userspace PM?

Then we would have:

  int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk,
                               struct sock_common *skc
                               struct mptcp_addr_info *skc_local)

An no need to init it twice.

> -	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
> -		return 0;
> -
> -	if (mptcp_pm_is_userspace(msk))
> -		return mptcp_userspace_pm_get_local_id(msk, &skc_local);
>  
>  	pernet = pm_nl_get_pernet_from_msk(msk);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d8c9035c44fb..58989303470f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -933,13 +933,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
>  bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
>  			     struct mptcp_rm_list *rm_list);
>  int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> +int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

Mmm, usually, I think it is better to keep functions from the same .c
file together but I see the one for the userspace is here below. I guess
that's why you moved the pm_nl one here, right? If yes, I'm OK with your
modification.

(I think we should not have mixed everything in protocol.h but create a
pm_netlink.h, etc. anyway, not related to your modification :) )

>  int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
