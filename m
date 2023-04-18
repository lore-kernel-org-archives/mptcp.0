Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51E1C02
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 15:33:34 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so80206wmb.0
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681832012; x=1684424012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQEupPeNNi+lWNj3PClMu+C3Ar8j6mtJOGTRpd/1+9k=;
        b=mfe5do4IYRjSMK8KntzdRqBMADag5gYfByZWE6a0lelscErVw56WmMMbfNRZtms35H
         uqSPlefOM3UnSiLtErM881JaN2/5w/r/Y5VOsZhnCazftE+lq2uKB+LMbcQfpPR+AMbV
         dNuih/iHrjhg7QX9vRxqZUk2FoG6FelEzslkXHI6dM/GcOFCEHJE1bQu2lE24qf8cRYd
         QAgZ2HWiLR8R0bFlLI4DudwnNVTUO0K3dnGDKWF0sTBr3egx0HvIeYTMwTVsM9s79LxQ
         Zj5pm+tiuK4/3AKpszwGEq+iOOcOjv7UxQ9ZFWu0UQpNC7LIUSlOV7KzKEcbcwxF0mUE
         j76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832012; x=1684424012;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQEupPeNNi+lWNj3PClMu+C3Ar8j6mtJOGTRpd/1+9k=;
        b=LQ0MeFmgAw90e2G/tV7vQzHJPC5KcIJjenCtSA6aOeUTDFzzTsVWuTFYOb/Jg9vBeH
         Yb7EqFiol7w9rkab9p9xRSVWodgbw4Rmr5Ydj9ONFvUuPsw5D9kilfbberbr0iN4kpmH
         U7HnteGp/bRsLgOjcDa/RdffBkLqxHd4rNEYh5m23jcHekMv7BrEvQAr6hSzMF5+wj+E
         8Aw4e1OPu+gR4j6cs7dQrLlMgywcpttV+lswOsCMTXGE1yK8LZzMODNr+O4oy/b1DDHr
         CwEc92hakyGeaYSy2SzihgkP4Nm8jCZmQHqQkNveZXU1JpXqoi6KfBzzAbPkBfhvqY1x
         WDbA==
X-Gm-Message-State: AAQBX9dYwIDqKc5/HbzsAD+PN4LWeIgGVi4S9Y9SZ5k/eoHDokG4cg8H
	vUA4tKQsRE7B+ijhur4rGmgrLtME2vJrsskhvfPYmg==
X-Google-Smtp-Source: AKy350bbdu7hfUxsE00F/xgUgbnocdy/w0bS6tQILW0W7au7KWJm22r281KKNGRbey+5WnMWsDaJUA==
X-Received: by 2002:a7b:cb9a:0:b0:3f1:7c38:719b with SMTP id m26-20020a7bcb9a000000b003f17c38719bmr738126wmi.3.1681832012330;
        Tue, 18 Apr 2023 08:33:32 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:1b76:be36:72bc:27e0? ([2a02:578:8593:1200:1b76:be36:72bc:27e0])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003f09cda253esm3002045wmn.34.2023.04.18.08.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:33:31 -0700 (PDT)
Message-ID: <cd5538f6-cb32-0575-da7d-cf26d853e763@tessares.net>
Date: Tue, 18 Apr 2023 17:33:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v7 4/7] mptcp: add addr into userspace pm list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1681463340.git.geliang.tang@suse.com>
 <064aa29832dfa25337877f33766da1ede5ed6843.1681463340.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <064aa29832dfa25337877f33766da1ede5ed6843.1681463340.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/04/2023 11:11, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created.

I'm sorry to send the same kind of comment as on the previous patches
and on the version 5 but can you also add the reason why you need to do
that in the commit message please?


Also, it looks like you are fixing two issues (or adding two features) here:

- Being able to send a remove addr for any additional subflow that have
been created (MPTCP_PM_CMD_SUBFLOW_CREATE) but not announced
(MPTCP_PM_CMD_ADD_ADDR): a part of issue #379 (this doesn't fix the
possibility to remove ID 0 from what I see)

- Increment local_addr_used: a part of issue #329

No?

Maybe could you split this in two? e.g. modifying local_addr_used
counter in another commit?

Could you add:

  Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
establishment")
  Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379

and:

  Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
establishment")
  Link: https://github.com/multipath-tcp/mptcp_net-next/issues/329

> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 312fdce174fa..99a3968f38ac 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -301,6 +301,17 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	err = mptcp_userspace_pm_get_local_id(msk, &addr_l);
> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "did not match address and id");
> +		goto create_err;
> +	}
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	mptcp_pm_alloc_anno_list(msk, &addr_l);
> +	msk->pm.local_addr_used++;

Correct me if I'm wrong but if the local address has already been used
before, we are going to increment the counter while we should not, no?
e.g. if the client re-use the same local address to create multiple
subflows to different IP.

mptcp_userspace_pm_append_new_local_addr() should probably report if
there was a match of if a new entry has been added.

> +	spin_unlock_bh(&msk->pm.lock);
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);

Also, should we not increment the counter if there was no errors? (or
maybe in case of errors, the counter is decremented elsewhere? I didn't
check but I don't think so)

While at it, in case of errors, should we not also remove addr_l from
the local list?

> @@ -419,6 +430,18 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
>  	if (ssk) {
>  		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +		struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +		spin_lock_bh(&msk->pm.lock);
> +		list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +			if (mptcp_addresses_equal(&entry->addr, &addr_l, false)) {
> +				list_del_rcu(&entry->list);
> +				kfree(entry);
> +				msk->pm.local_addr_used--;

Here as well, I don't think you can remove the entry and decrement the
counter if the local address is used by multiple subflows (e.g. fullmesh
mode), no?

The entry might need a refcount.

> +				break;
> +			}
> +		}
> +		spin_unlock_bh(&msk->pm.lock);

Do we need to do the same (remove the entry and decrement the counter)
when the subflow is removed from the other side or because of a network
error?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
