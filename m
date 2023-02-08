Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257F6AAD
	for <mptcp@lists.linux.dev>; Wed,  8 Feb 2023 17:44:01 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id e3so804385wrs.10
        for <mptcp@lists.linux.dev>; Wed, 08 Feb 2023 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPqiWvoHsHyoQCJxTNmh4jpfHI4c5SWbTo8m4PkeQCU=;
        b=1120jktQI5U9oY9Gu6MkUYPVPGcuGUXZQe2BnMDXWT5+Mmgz9UJH2bKzwu3CB2Wk9i
         Y7M60yVUcMvJeJMpD8EaMOkU4j5IIMbgHuSzcXSckv5bk94RYm0h29gHwitNdepomKk8
         SAsYYD2WJXsIy4p/RdAhN7iob6dFwKNwnGnGMHQtSKumfz8m+fFyClUS1RrAtpfCplJA
         5UqBnwxMvgloOaRxJt7BEy44hC6TSD2u8QzQ0kXcsREKIficnW8Uzx/P/ZO0Hg5lkOOq
         89gLwUYivz0ppKV+RkLFdT1ty2+DfPD5YuW5Zg6vZRvHuPFVHN6AXAQa6+a6GBWeQuh9
         1I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPqiWvoHsHyoQCJxTNmh4jpfHI4c5SWbTo8m4PkeQCU=;
        b=dJjMKSHxyBP40IKCWvXjWMMHxWD5IrSrwCVgwgqF1e5Xxkcy0Xpj0fKpch6CZ7Hn88
         kVRURl5vyzAnJ+FFK3/boMHhHFHLUQ8hRdWi3f0DD65eg073wR4zp7xhJJmKdTuprHh2
         n5AUs5ag3FQzT5NbWPM0N58s8ytS5/hJHvWzBv7Ka2kcQeMNQ65HHRO1rQAcerR09qN4
         BFtPMTSAf4MBnkV3tslXG6hf0+tWvVP3dDdUKKSKHulYSg0nZ02AebTTqfl5Xi9bgCVa
         AiE8c6Zo3ud1oAcV6DgVfd5DK4u1Eh5qIp2oNTAurwx6WOrBBYoWt9PL/DQta7B7JQ6+
         1IHQ==
X-Gm-Message-State: AO0yUKWYTARCQnE5MjNjbsyhD9TdXnIavbJX4aKpOO/3til/IW7mdUC1
	Gzz+cJhiVS72+RHHXQCAmXZ3109/mv97v/tA
X-Google-Smtp-Source: AK7set8EVVc+3oEom9cGQKQMqF/M7G7PqxMTvW+re3eKrAQReHbR7QQ2oLVKshcrD5lqTy+oDR1LWw==
X-Received: by 2002:a5d:6b4b:0:b0:2bf:b41c:61dc with SMTP id x11-20020a5d6b4b000000b002bfb41c61dcmr7717609wrw.36.1675878239289;
        Wed, 08 Feb 2023 09:43:59 -0800 (PST)
Received: from [192.168.3.222] ([213.211.148.158])
        by smtp.gmail.com with ESMTPSA id u36-20020a05600c4d2400b003de2fc8214esm2340258wmp.20.2023.02.08.09.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:43:58 -0800 (PST)
Message-ID: <691e7dde-be9d-ee56-73dd-e6e6ede37d06@tessares.net>
Date: Wed, 8 Feb 2023 18:43:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next v3] mptcp: update userspace pm mptcp_info
 fields
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7f695489e0ecba3f0951193be81a1620b1f8e6e7.1675410794.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for this v3.

On 03/02/2023 08:55, Geliang Tang wrote:
> Increase pm subflows counter when userspace pm creates a new subflow,
> and decrease the counter when it closes a subflow.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/330

Sorry, the description of #330 was not clear: pm.subflows is not
incremented for the server side when using the in-kernel PM if I'm not
mistaken. I just updated the ticket to make it clearer. So this patch is
not fixing #330.

(before this patch, it was also not updated with the userspace PM but
that's different: ticket #329)

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Could you also add a Fixes tag please?

> ---
> v3:
>  - update local_addr_used and add_addr_signaled
> 
> v2:
>  - hold pm locks
> ---
>  net/mptcp/pm_userspace.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index a02d3cbf2a1b..ba8ad500993c 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -171,6 +171,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
>  	spin_lock_bh(&msk->pm.lock);
>  
>  	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
> +		msk->pm.add_addr_signaled++;
>  		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
>  		mptcp_pm_nl_addr_send_ack(msk);
>  	}
> @@ -240,6 +241,10 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
>  	}
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	msk->pm.subflows--;
> +	spin_unlock_bh(&msk->pm.lock);

Should you not decrement msk->pm.subflows in the loop just above?
Potentially, there is more than one subflow linked to the given addr ID.

Not directly related but it looks like in mptcp_nl_remove_addrs_list()
-- for MPTCP_PM_CMD_FLUSH_ADDRS command -- we don't decrement
pm.subflows as well. Maybe this 'pm.subflows' should be decremented in
mptcp_pm_remove_addrs_and_subflows() directly to cover both cases?

(if you do the modification in mptcp_pm_remove_addrs_and_subflows(), the
"Fixes" tag might be different, a separated commit will be needed)

> +
>  	err = 0;
>   remove_err:
>  	sock_put((struct sock *)msk);
> @@ -302,6 +307,11 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	msk->pm.local_addr_used++;

Mmh, here the counter is incremented for each new subflow: no matter if
it is a new local address (addr_l.id) or not, right?

If I'm not mistaken, we don't maintain a list of local addresses we use
to create subflows, right? Just addresses we announce I suppose.

I don't know what's best:
- not updating the counter with the userspace PM (current behaviour)
- update it but with a not so correct value
- maintain a list of IDs just to set the proper counter?

Maybe it is enough to keep the current behaviour and mention somewhere
"local_addr_used" counter is not supported with the userspace PM because
this is managed by the userspace?

(Same for "add_addr_accepted" counter I suppose)

> +	msk->pm.subflows++;
> +	spin_unlock_bh(&msk->pm.lock);
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
> @@ -424,6 +434,10 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
> +		spin_lock_bh(&msk->pm.lock);
> +		msk->pm.local_addr_used--;

(same here: remove this line?)

> +		msk->pm.subflows--;
> +		spin_unlock_bh(&msk->pm.lock);
>  		err = 0;
>  	} else {
>  		err = -ESRCH;

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
