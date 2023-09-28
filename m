Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A19CA71
	for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 21:00:57 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9a9cd066db5so1836145766b.0
        for <mptcp@lists.linux.dev>; Thu, 28 Sep 2023 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695934856; x=1696539656; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Elrz91+AzGSM33ITIp0ZMseTcd92QHoGsMa1XxFxXMI=;
        b=bRkiwi0IpTYlgPVwrUUwhGjC1bamKTRShAcFfHZkV3hZZh5D8E6dnNopo4JrNz+nJG
         VpCtXf+TW2ADrUZFPfAZ2KWZdcSEz3xcsJCxyS/dhd/4Nr0Fgi9cVOhIew8e9urN0B85
         NAdzKYln2lSfomUHDrbHBETIRzkcULd9Zau6OVFt0PgLCoQl+uMdSqDXFlMxqcVLiDc3
         /BPBT6VJC+1b9aIGSEClE+PgvJNL8gqbHW1pfuGf9MUA5nryOHfvLNJP/jfHzt83u6jm
         H9qj5wPl0wHECfCYXbdjMd4O2Oc/fK0MHtlthMrIINlpN7icYUsVTm1RUFCt26afOjYA
         hATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934856; x=1696539656;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Elrz91+AzGSM33ITIp0ZMseTcd92QHoGsMa1XxFxXMI=;
        b=FximPgJ9dYynwxJys3IPwDcVvYtrv7c/G+a7v2XDNymz2YxMWcXnWTobz5H5kJ2S7a
         s0p3Nw86uZid4qyCmGV49IUjjieXkBe0MHfrwG71CIdHh5OVnnq8MZVJ/ya19GJiI4zr
         rgDmSLvq6xywfgWsG9OJoUpJTua7kNtWc9krRBQh1wmZAonuzJLDHVF6ykVJBMI9jaeU
         YJx8A0S9RR733K2ow0ehT5Rw8VsqmJNmNU+AjV27haz2IuqmEW+rWiOa5aTdn/9PLCRW
         wlbXP9w6N+q/WCoyj4zKzjw5+dvbSd1B7K1GvESBrAI/IPYsvyMq2Dpry2wvlF3Plsr9
         sNgg==
X-Gm-Message-State: AOJu0Yzbc8z1HSLd6brLkiEJoSCnfwlUJRpCOgOVTQuAfikdISucK/ek
	1Wh6WKt3bwnvkTSYb1MORasUF/7XvnOoOPOd5cYomw==
X-Google-Smtp-Source: AGHT+IEw4SgDruCOyTNMEPr36PVr9agXLzMoviXOKx7ROYvIko8lI/BTpWZ6nIlIKtWWqigqzPnUEA==
X-Received: by 2002:a17:906:3157:b0:9a2:185b:5376 with SMTP id e23-20020a170906315700b009a2185b5376mr2181522eje.49.1695934855989;
        Thu, 28 Sep 2023 14:00:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ff86:e30:98cd:120? ([2a02:578:8593:1200:ff86:e30:98cd:120])
        by smtp.gmail.com with ESMTPSA id ez23-20020a1709070bd700b009b285351817sm5050199ejc.116.2023.09.28.14.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 14:00:55 -0700 (PDT)
Message-ID: <6c6bff5e-56fb-49f7-af25-d5cb1347bc63@tessares.net>
Date: Thu, 28 Sep 2023 23:00:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 15/29] mptcp: userspace pm remove id 0
 address
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <1119bff10cfc3c6b3fe4afc410f7803f27f49f1b.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <1119bff10cfc3c6b3fe4afc410f7803f27f49f1b.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> This patch adds the ability to send RM_ADDR for local ID 0. Check
> whether id 0 address is removed, if not, put id 0 into a removing
> list, pass it to mptcp_pm_remove_addr() to remove id 0 address.
> 
> There is no reason not to allow the userspace to remove the initial
> address (ID 0). This special case was not taken into account not
> letting the userspace to delete all addresses as announced.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6b8083650bc1..8d97cf475cac 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -211,6 +211,38 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> +static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
> +						  struct genl_info *info)
> +{
> +	struct mptcp_rm_list list = { .nr = 0 };
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	bool has_id_0 = false;
> +	int err = -EINVAL;
> +
> +	lock_sock(sk);
> +	spin_lock_bh(&msk->pm.lock);

Why do you need to lock the 'pm' structure? mptcp_pm_remove_addr() will
modify the 'pm' structure but it will also do the lock, no?

> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (subflow->remote_id == 0) {

I only noticed that now but you need to look at local_id, not remote_id:
when we send a RM_ADDR, we announce that a previously announced (local)
address ID is now invalid → so we need to check for local IDs here.

> +			has_id_0 = true;
> +			break;
> +		}
> +	}
> +	if (!has_id_0) {
> +		GENL_SET_ERR_MSG(info, "address with id 0 not found");
> +		goto out;
> +	}
> +
> +	list.ids[list.nr++] = 0;
> +	mptcp_pm_remove_addr(msk, &list);
> +	err = 0;
> +out:
> +	spin_unlock_bh(&msk->pm.lock);
> +	release_sock(sk);
> +	sock_put(sk);

It looks strange to me to do a 'put' here because we didn't "hold" the
socket here in this function.

Should we not do the 'sock_put(sk)' in mptcp_pm_nl_remove_doit() instead?

> +	return err;
> +}
> +
>  int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> @@ -245,6 +277,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto remove_err;
>  	}
>  
> +	if (id_val == 0)
> +		return mptcp_userspace_remove_id_zero_address(msk, info);

Linked to what I said above: maybe here it would be better to have:

  err = mptcp_userspace_remove_id_zero_address(msk, info);
  goto out; // the sock_put() will be done there

(rename 'remove_err' to 'out' as there is potentially no errors here)

WDYT?


> +
>  	lock_sock(sk);
>  
>  	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
