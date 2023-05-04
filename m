Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040279D8
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 15:02:02 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f182d745deso6573515e9.0
        for <mptcp@lists.linux.dev>; Thu, 04 May 2023 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683212521; x=1685804521;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yr4VCpXxO+2wIMPJRFMoYhUslJ9pjtoKz4N2w5mYgP8=;
        b=4JCnp/k7v3UTojc1wJPY/Khqwr/ArURIlJHFosYouWUgoduTpkl2zGfWBUpC7mTPub
         P+26DJVYyep1dkyQy6E/4NoKH8QCsRyw627TpngbujnDyXwzx4ZHVg4QoKqQbWY009Dt
         4KQVQpIv9Ydh+IqX6HhsLRDxItg35hyOmmzD/IfqQaZC593UFaRNrh7fruN3bOiFIwmZ
         o+OUkKerYDoSCo0QtmbzUxYcoZl74whUQx+mlegPzhEWPXvj8p0DDbVZ6xeuaSrCi3RZ
         ko4FYH7xu0ktqxDMFoIdMAfDXbMO4QJLm5NK7P+tSFEo2nykbAtl/k15wWqNJci73B2J
         JOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212521; x=1685804521;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yr4VCpXxO+2wIMPJRFMoYhUslJ9pjtoKz4N2w5mYgP8=;
        b=g9ZFvoldGMzaVfo+wTMETV4JpSOpKP1qWstXgFV1NfIFci2nyiW/a11Ekj3Wyj16Sm
         0oCJGh6B1wSVXsM3pGue4ovBIu8yEtf3tyR6MuYGjYkc5jQQbzILGi3vWwUuFUrKisoI
         raJiaQLcIjlgjo0FXrr1kKe+iEpcb+1Ftf3vQ4crtidkld080F+RfXWwmBPdWYYR73Y0
         2LKrZB+Iva3evWRdreNmnane1M0W1k1traP8+/6CPtyVbDo7ebAcUNnY4o8qnT/svOy5
         6O29i+0h7x+6VN1O4LAxTNbhDOVvoWgHNbZUtOuuH/+EIda2mLlG12nGvIdJ0L82NCvj
         5MmA==
X-Gm-Message-State: AC+VfDwhc5KT/zzItTc5tfatVFa/Sy4/SBl8nI4VZ19JI2/6EQDFcuVW
	RbjNZfoGHipReM0k2RqQL+lgDPfMFD6Z5dPiIec=
X-Google-Smtp-Source: ACHHUZ5R0qIn6w4XoxuHgTMJR6wCC78pk5d9XIuDBc8ETiuG+U4azZP6WB7wpVaKwUrO7+fvHO3arQ==
X-Received: by 2002:a7b:cd04:0:b0:3da:1f6a:7b36 with SMTP id f4-20020a7bcd04000000b003da1f6a7b36mr43293wmj.0.1683212521054;
        Thu, 04 May 2023 08:02:01 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6b04:8b76:7dd3:7b25? ([2a02:578:8593:1200:6b04:8b76:7dd3:7b25])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bc5c3000000b003f0b1b8cd9bsm5212484wmk.4.2023.05.04.08.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:02:00 -0700 (PDT)
Message-ID: <0ac8d900-6bf1-5ed6-e379-c3bf0c7fc6cf@tessares.net>
Date: Thu, 4 May 2023 17:02:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v11 06/12] mptcp: update userspace pm infos
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1683195386.git.geliang.tang@suse.com>
 <0356f03ca8d7e6655914e26502308414d27d3ae5.1683195386.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0356f03ca8d7e6655914e26502308414d27d3ae5.1683195386.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 04/05/2023 12:20, Geliang Tang wrote:
> Increase pm subflows counter on both server side and client side when
> userspace pm creates a new subflow, and decrease the counter when it
> closes a subflow.
> 
> Increase add_addr_signaled counter in mptcp_nl_cmd_announce() when the
> address is announced by userspace PM.
> 
> This modification is similar to how the in-kernel PM is updating the
> counter: when additional subflows are created/removed.
> 
> Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm.c           | 21 +++++++++++++++++----
>  net/mptcp/pm_userspace.c |  5 +++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 7539137719ef..9ba671902e69 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -89,8 +89,15 @@ bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
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
> @@ -183,8 +190,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
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

See my question from v7: Should you not decrement the counter only if
one of these conditions is met to keep the same behaviour as what is
done with the in-kernel PM: 'subflows' counter only look at the
additional subflows?

e.g.

  update_subflows = (subflow->request_join || subflow->mp_join);

  if (mptcp_pm_is_userspace(msk)) {
      if (update_subflows) {
          (...) → pm->subflows--;
      }
      return;
  }

  if (!READ_ONCE(pm->work_pending) && !update_subflows)
      return;

I'm not a big fan to count only the additional subflows but I think it
is important to keep the same behaviour with both PMs.

>  	if (!READ_ONCE(pm->work_pending) && !update_subflows)
>  		return;
>  
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index c50e1507ae35..98a5c81083be 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -189,6 +189,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
>  	spin_lock_bh(&msk->pm.lock);
>  
>  	if (mptcp_pm_alloc_anno_list(msk, &addr_val)) {
> +		msk->pm.add_addr_signaled++;
>  		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
>  		mptcp_pm_nl_addr_send_ack(msk);
>  	}
> @@ -334,6 +335,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		spin_unlock_bh(&msk->pm.lock);
>  		goto create_err;
>  	}
> +	msk->pm.local_addr_used++;

Maybe better to increment this counter in
mptcp_userspace_pm_append_new_local_addr() so we do it once if the local
doesn't already exist (when the TODO will be done).

>  	spin_unlock_bh(&msk->pm.lock);
>  
>  	lock_sock(sk);
> @@ -344,8 +346,11 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  
>  	spin_lock_bh(&msk->pm.lock);
>  	if (err) {
> +		msk->pm.local_addr_used--;

Similar here, maybe better to do that in
mptcp_userspace_pm_delete_local_addr()?

Also by doing that, the counter will also be decremented when the
userspace asks to destroy a subflow (and the refcount is 0).

>  		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
>  		mptcp_userspace_pm_delete_local_addr(msk, &local);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
