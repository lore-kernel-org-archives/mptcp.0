Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF93C05
	for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 14:17:39 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5083bd8e226so2533279a12.3
        for <mptcp@lists.linux.dev>; Fri, 21 Apr 2023 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682086658; x=1684678658;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6y59sYOYYnwa3KiWH/QrE3GeQHygSAdJHo4/GJAA7wE=;
        b=Xu0xPXbekdvoC18uD/KBo5ndTadAUtuL5M0j/JyJkCDwnSt2cqvu3/7yb5IgYwWZt5
         jt6XD+J9qSKFfs3dp774YKc74jSK2GIUaURzsxia0hIhB1dBi4D12oLQTAOr6+aI8wfO
         SqFpNlo0fAB9E4gOF1CuSoWR/EfHl7MtNS2vGcRkZLp+aqrdZNo851rKdf/tTXs+6cxL
         +j+7LNKhzq/SzLj8fBJymTlBiHrgRq+iSqQaT8wKdTyNLYF5GROlUOKRYMAYM5hx5hTG
         aeHmLYgg2NMp3gT1UcapTrZjysY4hrhqkmxUQo33a/oOJSN8q4QcBbsk6a54MbZWqDHz
         P1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682086658; x=1684678658;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y59sYOYYnwa3KiWH/QrE3GeQHygSAdJHo4/GJAA7wE=;
        b=ZA8idxXUr8HnEoRz1Pvdfxc28s3/1AGksKlSG+AuhZMaVo7FevWCVetjwKZd1KURQB
         YGWZh+zwr2EIEJ4D5/4hRolmRUEhyYGiAx2gbaqq5RuaQ6Hg0iVI35bAeJ1VnNO4+3MF
         2yZ4+2xw6s0oHwavsWRmpKmq1b3oJEf0PzfhMKUgGwd6EV6dHUw9GwenNra0F3hPmCli
         0EAiopkvS2PfOAc6vIdPd06mL6v4Pgz59/gfyeTJoqCd0uvwiMeqHdCS4xr2KlWfL2WM
         gXtFEN28FaG2R9J8YcEJtECkTQZVKo3XTFw+yMOfZokmnSofcqAuhjBPixtNxfz04Fb+
         e33g==
X-Gm-Message-State: AAQBX9cmq0ehQQKmlDtyeYn1Vf0UthTchbgFj6jvbRTkhOgvs2t9En6B
	6gvqStknC2qy01HOk/hl35nKcZEXNfqHGQjOYSWMWQ==
X-Google-Smtp-Source: AKy350bj5PdY4ogVh0NRM7zHOYjIyOV6y9oplNWeucTy30PoDkm4DSm8aIBagM4xlgyETC8fTJ0eKw==
X-Received: by 2002:a05:6402:1395:b0:508:39e3:58b with SMTP id b21-20020a056402139500b0050839e3058bmr4852176edv.35.1682086657975;
        Fri, 21 Apr 2023 07:17:37 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id y6-20020aa7c246000000b005068eefc59dsm1898152edo.42.2023.04.21.07.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 07:17:37 -0700 (PDT)
Message-ID: <812a0ac7-5a13-bf1d-762e-3946b4532ea9@tessares.net>
Date: Fri, 21 Apr 2023 16:17:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v8 4/5] mptcp: add addr into pm anno_list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681960259.git.geliang.tang@suse.com>
 <15a683ff3b3bd04870b0739854ffdd8c01067a76.1681960259.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <15a683ff3b3bd04870b0739854ffdd8c01067a76.1681960259.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2023 05:11, Geliang Tang wrote:
> Pass addr parameter to mptcp_pm_alloc_anno_list() instead of entry.
> 
> Export remove_anno_list_by_saddr().
> 
> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> it when connecting fails.

I'm sorry to insist but here you only described what the new code is
doing but you didn't explain why you did that: is it to fix an issue?

Please add a "Fixes" and a "Link" like in the previous patch.

Also, I think it was fine (and even better) to pass addr parameter to
mptcp_pm_alloc_anno_list() instead of entry in a dedicated commit. What
was missing was the reason, e.g. this is needed for the following commit
to be able to (...)

> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_netlink.c   | 12 ++++++------
>  net/mptcp/pm_userspace.c | 15 ++++++++++++++-
>  net/mptcp/protocol.h     |  4 +++-
>  3 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index bb237abb99bb..d03c60f54085 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -342,7 +342,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  }
>  
>  bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> -			      const struct mptcp_pm_addr_entry *entry)
> +			      const struct mptcp_addr_info *addr)
>  {
>  	struct mptcp_pm_add_entry *add_entry = NULL;
>  	struct sock *sk = (struct sock *)msk;
> @@ -350,7 +350,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  
>  	lockdep_assert_held(&msk->pm.lock);
>  
> -	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
> +	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
>  
>  	if (add_entry) {
>  		if (mptcp_pm_is_kernel(msk))
> @@ -367,7 +367,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  
>  	list_add(&add_entry->list, &msk->pm.anno_list);
>  
> -	add_entry->addr = entry->addr;
> +	add_entry->addr = *addr;
>  	add_entry->sock = msk;
>  	add_entry->retrans_times = 0;
>  
> @@ -574,7 +574,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>  			return;
>  
>  		if (local) {
> -			if (mptcp_pm_alloc_anno_list(msk, local)) {
> +			if (mptcp_pm_alloc_anno_list(msk, &local->addr)) {
>  				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>  				msk->pm.add_addr_signaled++;
>  				mptcp_pm_announce_addr(msk, &local->addr, false);
> @@ -1399,8 +1399,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
>  	return 0;
>  }
>  
> -static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> -				      const struct mptcp_addr_info *addr)
> +bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
> +			       const struct mptcp_addr_info *addr)
>  {
>  	struct mptcp_pm_add_entry *entry;
>  
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index a1f8d2fab08d..8c050c118ba9 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -169,7 +169,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
>  	lock_sock((struct sock *)msk);
>  	spin_lock_bh(&msk->pm.lock);
>  
> -	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
> +	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
>  		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
>  		mptcp_pm_nl_addr_send_ack(msk);
>  	}
> @@ -307,12 +307,25 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	if (!mptcp_pm_alloc_anno_list(msk, &addr_l)) {
> +		spin_unlock_bh(&msk->pm.lock);
> +		goto create_err;
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
>  
>  	release_sock(sk);
>  
> +	if (err) {
> +		spin_lock_bh(&msk->pm.lock);
> +		remove_anno_list_by_saddr(msk, &addr_l);
> +		spin_unlock_bh(&msk->pm.lock);
> +	}
> +
>   create_err:
>  	sock_put((struct sock *)msk);
>  	return err;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1a2772902e9d..b3942d15ade7 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -822,7 +822,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>  				 struct mptcp_addr_info *rem,
>  				 u8 bkup);
>  bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
> -			      const struct mptcp_pm_addr_entry *entry);
> +			      const struct mptcp_addr_info *addr);
>  void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
>  bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
>  struct mptcp_pm_add_entry *
> @@ -837,6 +837,8 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>  int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>  						   unsigned int id,
>  						   u8 *flags, int *ifindex);
> +bool remove_anno_list_by_saddr(struct mptcp_sock *msk,

Please prefix the newly exported function with mptcp_pm_

Also, can you not declare it in the middle of the userspace ones?
Maybe around mptcp_pm_alloc_anno_list() or between
mptcp_pm_get_flags_and_ifindex_by_id() and
mptcp_pm_remove_addrs_and_subflows()?

Cheers,
Matt

> +			       const struct mptcp_addr_info *addr);
>  int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
>  				 struct mptcp_pm_addr_entry *loc,
>  				 struct mptcp_pm_addr_entry *rem, u8 bkup);

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
