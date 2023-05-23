Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FCA4C7B
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 14:45:16 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-30a4ebbda56so3441436f8f.1
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684853114; x=1687445114;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyZo7Pl3MD6rFOaDHzIyLbwKGkpZnnIo4NVGHUATVKM=;
        b=hTPfo5toQPdtqa4qBPUVFJqwr1jOtqHroZEnRbNjxQHwLJF5luIY+4tT5VG6QBkGdp
         RWwhVvlKth99VTHF5gbbmW8G+L2KCYI8EZevQeTCGMcL/HTnRiY6NJcw2+9oDBM55K8E
         N6FxKcAjlQljAPw5J8pCZynyEo6nUt+mhb2eq/vci+c2+Gq0HLqicGD21pBoJSDchHBn
         Q0LwJzF96qqiVbacnSZmiY7UKoWizmgrK+2KLTfy/rBOj47DSFGaMuYVFKL1DZX8SK9z
         sl1v0Q5MVIOp3+gASDLGlSwnFXh5hlaU7fczTPBVqtxfB1wmpBTBwXYw4oGy+731xeK7
         A+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853114; x=1687445114;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyZo7Pl3MD6rFOaDHzIyLbwKGkpZnnIo4NVGHUATVKM=;
        b=XkGQpQMZX0z+PBfcQveKvpv8K2iW+Jh4vp8pQPxq9i1tU41NdLSDbJIC69j17puGsO
         5QqwZrr9TIuqWkoz8/eObrAx6BEpShs3Iq8rqHLYRPjD4S8Z8dwN8K/lkLAlfq6BWjej
         tzPBa/q1JWXrX7jISgEYzAd2pFKjx0F8mmrARkV7BXYzMya5qksNjVYJ3AoLu4pnRO0/
         fl7tMmARGjTjz5I8r3VbE+4qnStT++4jfXf6KWFRVTkj8TeJMHC903HpNyAin1WvY8vz
         lrZ/clzty1kEDFOIV9/C/a//dvky5xgTBoxiZBAQ7Um+OY63T5zTBKZzR7PZaG9TahSR
         lZrQ==
X-Gm-Message-State: AC+VfDxpQNff0RHcKcOiDRhn+TthVO0ntLK3pZseoIjYiZsLErt8ExIh
	zgToS2XljnsgmWZXkXFj2w0t4dH8hQueLJcmhjIkJbNr
X-Google-Smtp-Source: ACHHUZ7aB282nJvIHEQBEXohQ9E9ezG0qEDo0MpjR2I3cX16mAx5ouxLr08MaH++JckhwdKTn2yrlQ==
X-Received: by 2002:a5d:4f8e:0:b0:307:cb94:85de with SMTP id d14-20020a5d4f8e000000b00307cb9485demr11348823wru.11.1684853114389;
        Tue, 23 May 2023 07:45:14 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id f18-20020adfdb52000000b002f7780eee10sm11500470wrj.59.2023.05.23.07.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:45:14 -0700 (PDT)
Message-ID: <cb2eca2b-73c4-f6ac-bf7f-1acd0e9b5691@tessares.net>
Date: Tue, 23 May 2023 16:45:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v14 1/5] mptcp: only send RM_ADDR in
 nl_cmd_remove
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684760588.git.geliang.tang@suse.com>
 <8fef539019c6a13f5bf689e8d05486d09e813648.1684760588.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8fef539019c6a13f5bf689e8d05486d09e813648.1684760588.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/05/2023 15:11, Geliang Tang wrote:
> The specifications from [1] about the "REMOVE" command say:
> 
>     Announce that an address has been lost to the peer
> 
> It was then only supposed to send a RM_ADDR and not trying to delete
> associated subflows.
> 
> mptcp_pm_remove_addr() is invoked to do just that, compared to
> mptcp_pm_remove_addrs_and_subflows() also removing subflows.
> 
> To delete a subflow, the userspace daemon can use the "SUB_DESTROY"
> command, see mptcp_nl_cmd_sf_destroy().
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp/blob/mptcp_v0.96/include/uapi/linux/mptcp.h [1]
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 27a275805c06..622698fa36f7 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -188,6 +188,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
> +	struct mptcp_rm_list rm_list = { .nr = 0 };
>  	struct mptcp_pm_addr_entry *match = NULL;
>  	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_sock *msk;
> @@ -230,12 +231,14 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  		goto remove_err;
>  	}
>  
> -	list_move(&match->list, &free_list);
> -
> -	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
> +	rm_list.ids[rm_list.nr++] = match->addr.id;

Why do you no longer need to call remove_anno_list_by_saddr()?

Should you not call it to remove timers associated to an address that
has been previously announced and not 'echoed' yet?

(if you need to do that, it looks better to keep the helper -- you can
also modify the helper to take a pointer to address instead of a list of
addresses)

> +	spin_lock_bh(&msk->pm.lock);
> +	mptcp_pm_remove_addr(msk, &rm_list);
> +	spin_unlock_bh(&msk->pm.lock);
>  
>  	release_sock((struct sock *)msk);
>  
> +	list_move(&match->list, &free_list);

Is it OK to do this operation after "release_sock(msk)"? This will
modify "msk->pm.userspace_pm_local_addr_list" list and it should be done
under the lock, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
