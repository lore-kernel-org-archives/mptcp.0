Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676E360C7
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 16:32:27 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3178dd771ceso48003f8f.2
        for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 09:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692289945; x=1692894745;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=teCfLvBY95FrJKScJAANYYC+RV4m7k27uuRfGTLFmdI=;
        b=Xd+tOvfgnalLtrL58/pNJnDzPx/WkXDRRMY11xSyVrXQl64wCKZZOzNWBohbdvO8Nm
         3p7PQeuot8SL9vdT0GJWn1az7LiCWW04f+/Dvvy0JpL9LpFbGF1XdhbWHJYdFIyL9nzE
         KUPqyXPXlNLgGT63tWfL8qBSm04jHeLVXXeIfoevAGFfiTCkSkky6XAMgwCv5ds1x+xu
         MOH4nEz96na8k+rMsR83nrZCnm8INSeRM52qa7AsoonBvvL9bpVs/IABNiXpc84EyVsH
         ICRX//tCLKVBay8FTFn7a48LJ/r/4gNCH3anwz7OfI41pN7LwXEwmsd+knURqqrfxrj6
         Khtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289945; x=1692894745;
        h=content-transfer-encoding:in-reply-to:cc:autocrypt:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=teCfLvBY95FrJKScJAANYYC+RV4m7k27uuRfGTLFmdI=;
        b=Ena8amOAtjMMBqZHVBDrcHU/lm+Q2DiVQgOeB42qm70jSdzB9jpvXl++nMS5WNb5z3
         OJdT1HIHK3z9lJkCABMQmX9+12WE6/ZmZ2jPVefnZs331qFuZTLs3QcEom6/wgWhqLxK
         ZLzCqUK298iNMLdargtV42Qu8cFbGXKaeZV0BnhwxyaFMQN9x7iM/dE04Gq08mAHOAwj
         gp8V8yFiOWOwVI56piNWfg/1Te82P/Vs8e3BmJTpHpMCd2XBAF/qsQlGm4s2PxdpTjmd
         UGkMboquFWxJ1Ed5ncbKiq8GlPE2y+DaBK4cl7nM3tnxBzfqwjtYy6hUaqtbpy1ijtyY
         K8qQ==
X-Gm-Message-State: AOJu0YwCiIBFSyELK7W9wIwlnbyTwpF6z9lv35N+voMnpNNtvEniHccM
	xjMgVWMo4udfXzneuSt0V9Cjz1hVWmv4/1DlYIU=
X-Google-Smtp-Source: AGHT+IHeZNrHi2a90x5i3c+zXf0GDcQN41vRDBgzRRNgWyHW1wKFNhqXme7f/GskmhllfBuW/fkF7A==
X-Received: by 2002:a05:6000:1010:b0:319:76ce:32ba with SMTP id a16-20020a056000101000b0031976ce32bamr12537wrx.21.1692289945181;
        Thu, 17 Aug 2023 09:32:25 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c88:d59b:1c03:4962? ([2a02:578:8593:1200:c88:d59b:1c03:4962])
        by smtp.gmail.com with ESMTPSA id z2-20020adfec82000000b003141a3c4353sm4838894wrn.30.2023.08.17.09.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 09:32:24 -0700 (PDT)
Message-ID: <4805687a-20b8-4669-b9a1-4fd6344cbbe4@tessares.net>
Date: Thu, 17 Aug 2023 18:32:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 2/3] mptcp: remove id 0 address
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
References: <cover.1692281317.git.geliang.tang@suse.com>
 <2a2600dd6642da6d29be1df8062f7bc8637155b2.1692281317.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
Cc: mptcp@lists.linux.dev
In-Reply-To: <2a2600dd6642da6d29be1df8062f7bc8637155b2.1692281317.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 17/08/2023 16:10, Geliang Tang wrote:
> This patch adds the ability to send RM_ADDR for local ID 0. Put id 0
> into a removing list, pass it to mptcp_pm_remove_addr() to remve id

(typo: remve -> remove)

> 0 address.
> 
> There is no reason not to allow the userspace to remove the initial
> address (ID 0). This special case was not taken into account not
> letting the userspace to delete all addresses/subflows as announced.

only 'addresses' in this commit, not 'subflows', right?

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")

I guess the second "Fixes" is no longer needed.

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm.c           |  2 +-
>  net/mptcp/pm_userspace.c | 30 +++++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d8da5374d9e1..6c610fb494ab 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -192,7 +192,7 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>  
>  	update_subflows = subflow->request_join || subflow->mp_join;
>  	if (mptcp_pm_is_userspace(msk)) {
> -		if (update_subflows) {
> +		if (update_subflows || subflow->request_mptcp || subflow->mp_capable) {

I don't think we can do that: it is confusing but pm->subflows counts
the number of "additional" subflows. Probably we should rename it...
Anyway, it means that if we remove the initial subflow, we should not
decrement it not to break the "user API".

It also means that in the selftests, if we remove the initial subflow,
this "subflows" counter should not change (but still good to validate
that). We can also look with 'ss' (ss -ti | grep -c tcp-ulp-mptcp) or
getsockopt(MPTCP_FULL_INFO) (or others except MPTCP_INFO) and then
mptcp_subflow_data->num_subflows to get the "correct" amount of
subflows. Or only check if the remove address has been sent and received.

(not directly related to this but I wonder if we should not expose to
userspace if the initial subflow has been removed → I just created the
ticket #428 on GitHub)

>  			spin_lock_bh(&pm->lock);
>  			pm->subflows--;
>  			spin_unlock_bh(&pm->lock);
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index d042d32beb4d..3e5ac4015c8e 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -236,7 +236,31 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
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
> +		int id_0 = 0;

(could be a bool: has_id_0)

> +
> +		mptcp_for_each_subflow(msk, subflow) {

This should be done under the msk lock, no?

(we could also look at READ_ONCE(msk->first) before iterating over all
subflows but not sure it is worth it and probably best to do it in a
second part, for net-next and not -net)

> +			if (subflow->remote_id == 0)
> +				id_0 = 1;

You can "break" here.

> +		}
> +		if (!id_0)

It would be good to add an error message, e.g.

  GENL_SET_ERR_MSG(info, "address with id 0 not found")

To let the userspace understanding why it was not OK.

> +			goto out;
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
