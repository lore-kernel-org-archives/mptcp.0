Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB976168B6
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 16:30:52 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so62522645e9.0
        for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692203450; x=1692808250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6RZKPT05ZFJfhsC8+BC5EInuQlu97/7uAjRIlYOmaY=;
        b=LbxDlt/rpezNH7mvJkrUvCrZkQsSZXryb8Dbkmjuyw6ehCUtZ2sKUJPtnZImhHgb9U
         s5ULkFthICxNUSE/2AFsJ7Sx8dUVcGrAcVHiWO3JVMaG0iYVVGRqsERFBOdF94BxxEYV
         WwLTlpfoGDnU6nX43HJYGNHUYB4tHYTDaPz1hAh7382aqluYrC6GhKgIX/MkwLfYePVp
         NXUbeODty4/lwiVo0X1YChvSepCOxRVCfbz0VhTE+R3x4/NvqB5buHVyD5Tbm2giL/Qr
         h11tePOtxJZ99OTLX12t2E5frCkuLIIENTHpDFTQb5/PFZry174s7wdyyNGv9VEUsgEn
         xDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203450; x=1692808250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6RZKPT05ZFJfhsC8+BC5EInuQlu97/7uAjRIlYOmaY=;
        b=FLwiW4eLvpIleH97UthOoPW1wX3bPDN3vpphrJ6z85JdZWq2d8hPdwOAjt8H+tW6Oa
         4Pb0ct/v8sko0y805xIFi+smr0kBMcK5yYXbHX/y3ntEgn9h+MY5X62tTMsgI3PEhw1v
         0oVYaDfGXYf6m2r03FUIpXFm+XeLrOstp6hr7mOlFNxmRE/b9KRcsCurMavJe5dxtIS5
         viqdEDx1ot7Al95Q7i8l2yhbfDGQHpCngdaEfP38poOjgUtdlcv8AQjDV2a0Y56wHNTt
         ay5zcD4tEK+CU+RlWO8wr8WP0vz8uijN3liwaesnXKqgFPF8JlORi+EtfHf713Fjb8HF
         QzzA==
X-Gm-Message-State: AOJu0YwXfaR5adIWnAqgxJ3cW2kO4JqtbB5jTaj+9MGWLHOhgoAhxUC6
	isbjq0uRIDl4AcSjTbGwZQstglnLNCVQeY9q5PY=
X-Google-Smtp-Source: AGHT+IG4JvGqMTTZR/Xj4GTt08QbL0NxFSTv16k493ne+SP4H8elmF0Szn/qgY7d35hMddfI+M88jA==
X-Received: by 2002:adf:ed10:0:b0:319:6d8a:75f5 with SMTP id a16-20020adfed10000000b003196d8a75f5mr1808756wro.20.1692203450525;
        Wed, 16 Aug 2023 09:30:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9191:2283:c4d7:5cd7? ([2a02:578:8593:1200:9191:2283:c4d7:5cd7])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d6507000000b003143b14848dsm21626245wru.102.2023.08.16.09.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 09:30:50 -0700 (PDT)
Message-ID: <83589fbb-03c9-4e26-8ab7-2f15830f3e2b@tessares.net>
Date: Wed, 16 Aug 2023 18:30:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 2/4] mptcp: remove id 0 subflow & address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1691564649.git.geliang.tang@suse.com>
 <03bfb31a8baa468a3cd4001635cd6b7fdc1c8725.1691564649.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <03bfb31a8baa468a3cd4001635cd6b7fdc1c8725.1691564649.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/08/2023 09:06, Geliang Tang wrote:
> This patch adds the ability to send RM_ADDR for local ID 0 and the
> ability to remove id 0 subflow.
> 
> Put id 0 into a removing list, pass it to mptcp_pm_remove_addr() to
> remve id 0 address and pass it to mptcp_pm_nl_rm_subflow_received() to

(s/remve/remove/)

> remove id 0 subflow.

Please always add the reason, e.g.

  There is no reason not to allow the userspace to remove the initial
address (ID 0) and destroy the initial subflow. This special case was
not taken into account not letting the userspace to delete all
addresses/subflows as announced.

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379

I wonder if we should consider this as a fix: it looks like a bug that
the remove address for ID 0 and the destroy of the initial subflow don't
work.

In this case, we might need:

  Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
  Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
establishment")

While at it, it might then be better to split this commit in two: one to
remove the address and one to destroy the subflow with id 0. WDYT?

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index d042d32beb4d..38629ebc4ec6 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -239,6 +239,21 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  		goto remove_err;
>  	}
>  
> +	if (id_val == 0) {
> +		struct mptcp_rm_list list = { .nr = 0 };
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

I think an additional check is needed to make sure ID 0 has not already
been removed, no?

By doing that, we would have a similar behaviour to what we have with
the other IDs, e.g. if we send two remove address command for the same
ID, the second one will fail with "address with specified id not found"
message. We should do the same for ID 0.

> +		goto remove_err;

It is strange to use a label with "err" in the name when there is no
error. Probably better to rename it? ("out"?)

> +	}
> +
>  	lock_sock((struct sock *)msk);
>  
>  	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> @@ -399,14 +414,16 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_sock *msk;
>  	struct sock *sk, *ssk;
>  	int err = -EINVAL;
>  	u32 token_val;
> +	u8 id_val;
>  
> -	if (!laddr || !raddr || !token) {
> +	if (((!laddr || !raddr) && !id) || !token) {
>  		GENL_SET_ERR_MSG(info, "missing required inputs");
>  		return err;
>  	}
> @@ -424,6 +441,27 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  		goto destroy_err;
>  	}
>  
> +	if (id) {
> +		id_val = nla_get_u8(id);
> +		if (id_val == 0) {
> +			struct mptcp_rm_list list = { .nr = 0 };
> +
> +			list.ids[list.nr++] = 0;
> +
> +			sk = (struct sock *)msk;
> +			lock_sock(sk);
> +			spin_lock_bh(&msk->pm.lock);
> +			mptcp_pm_nl_rm_subflow_received(msk, &list);
> +			spin_unlock_bh(&msk->pm.lock);
> +			release_sock(sk);
> +
> +			err = 0;
> +		} else {
> +			err = -EINVAL;
> +		}

I don't think we should do that to fix the issue #379: an ID is linked
to a local IP address and you can have multiple subflows using the same
local IP address, including the initial local IP address (with ID 0).
The current goal of the destroy subflow command is to destroy a specific
subflow. For the issue #379, we should instead accept the destruction of
the initial subflow when we give its local and remove address like we
would do for any other subflows. Or maybe this is something that already
work? e.g. if you create an MPTCP connection from A to B, then a new
subflow from C to D, can you remove the initial subflow (A <-> B)?

What you did here in mptcp_nl_cmd_sf_destroy() looks like a new feature
to be able to destroy all subflows linked to an ID address: an
optimisation not to send a destroy address for each subflows linked to
this address. But is there really a need to be able to do that? If yes,
there is no reason to restrict that to ID 0 and the comment in the
header file in uapi should be updated too. Anyway, that's for a
dedicated commit and that's for -next.

> +		goto destroy_err;

Same here: here, there is potentially no error, best to rename the label
to avoid confusions

> +	}
> +
>  	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
>  	if (err < 0) {
>  		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
