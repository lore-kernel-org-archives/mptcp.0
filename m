Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB23111A1
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 16:20:45 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-30789a4c537so696943f8f.0
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684340443; x=1686932443;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDYV+nmXiLnY3AgFVxQAge1DUjwiKvPC6iEkYB9gv/Y=;
        b=6XHdNUeX+sMwBErE5zwnaeCKy6C3lQV/Pp24IQQUEfBykHRmvcW23w7R32mxKmMk7N
         HQfDtm0u6V3hVC5e4Nj+kh0WVdb/8RXtIOblBoS/4mL+zMLABdBKB+jfPajDSGzzvDJz
         9N1CFhb3DyoUfomnTAv7oKjlBUW48b7Smrt6tuDPmbkDWBZYEY7aDhjgwp8mDh44HuYj
         twBpzoelK2Ey1ekAQVbF7aws/gIWz/OgI53aIXtiOrqWE9hhGTm0+3OgiERS0h3du9gR
         ggHyU/DnCT6YtS3baJzoo1GH983HHAsZJiaWDWzf6eb8IR6nu+xtaI3FrRkuMRjyjKUy
         UtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340443; x=1686932443;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDYV+nmXiLnY3AgFVxQAge1DUjwiKvPC6iEkYB9gv/Y=;
        b=OmkRlYxbDarzA8spM3qUJhp6n54xRFdDMzaUE+4qKXMhP40wK8RPbOJxjowwuYzR3M
         dVM33zJ0f9HCMer4MAn2bSMGkH0MiojaWnVUXck5k10MN5XH6ZbsxCvwYmNSHa/kEFhs
         MXi+Tz5916z64FQR3CzXP42CieFfXuPMpS8SdG44N9EHwzSXaN2T4ZVemVY1lEjaEp2j
         Jk/QeXFz3ryPXr51Bh8jZabqNO68lLud6qpzix/wLh3Svh5Vgz2CAOdiPKZuZBR1kVNs
         soG0mc50I8tLKquv4RMNGGHKtVGAhlz2Nlf4rcZBdh1+h5BEVo2DVpi0hOmtUm+t2/HI
         DKlQ==
X-Gm-Message-State: AC+VfDx5TJua+OiXjW+hc27SbTap3aipHLMS/tXNiMJ0VTKqziKrIhuF
	dPmUbqUOQkFIdQq7uBe41J2HuQ==
X-Google-Smtp-Source: ACHHUZ4XvTeTZlQn18GjkBLrFTo3QvCYxDc2+FPcMXaqy8tjrquBfz6H1XDyQr8KCbOj/91Tu3mvGw==
X-Received: by 2002:a5d:68ce:0:b0:307:a58f:5f7b with SMTP id p14-20020a5d68ce000000b00307a58f5f7bmr956694wrw.64.1684340443243;
        Wed, 17 May 2023 09:20:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id u10-20020adff88a000000b0030631dcbea6sm3186406wrp.77.2023.05.17.09.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:20:43 -0700 (PDT)
Message-ID: <2112492f-a482-0d44-d303-01a91b8ab701@tessares.net>
Date: Wed, 17 May 2023 18:20:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v13 4/5] mptcp: add addr into userspace pm list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1683692137.git.geliang.tang@suse.com>
 <fe6f8aa092dea9406495cac56a00fa359626dbda.1683692137.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fe6f8aa092dea9406495cac56a00fa359626dbda.1683692137.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/05/2023 06:20, Geliang Tang wrote:
> Add the address into userspace_pm_local_addr_list when the subflow is
> created. Make sure it can be found in mptcp_nl_cmd_remove(). And delete
> it in the new helper mptcp_userspace_pm_delete_local_addr().
> 
> Add address into pm anno_list in mptcp_nl_cmd_sf_create(). Remove
> it when connecting fails.
> 
> By doing this, the "REMOVE" command also works with subflows that have
> been created via the "SUB_CREATE" command instead of restricting to
> the addresses that have been announced via the "ANNOUNCE" command.
> 
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..016df47d7d6a 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -79,6 +79,25 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	return ret;
>  }
>  
> +static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
> +						struct mptcp_pm_addr_entry *addr)
> +{
> +	struct mptcp_pm_addr_entry *entry, *tmp;
> +
> +	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
> +			/* TODO: a refcount is needed because the entry can
> +			 * be used multiple times (e.g. fullmesh mode).
> +			 */
> +			list_del_rcu(&entry->list);
> +			kfree(entry);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>  						   unsigned int id,
>  						   u8 *flags, int *ifindex)
> @@ -246,11 +265,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> +/* If the subflow is closed from the other peer (not via a
> + * subflow destroy command then), we want to keep the entry
> + * not to assign the same ID to another address and to be
> + * able to send RM_ADDR after the removal of the subflow.
> + */

Did you not want to add this new comment above this one instead?

   static int mptcp_userspace_pm_delete_local_addr(...) {

It would make more sense than above or inside mptcp_nl_cmd_sf_create() I
think.

>  int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry local = { 0 };
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_sock *msk;
> @@ -302,12 +327,35 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  		goto create_err;
>  	}
>  
> +	local.addr = addr_l;
> +	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
> +	if (err < 0) {
> +		GENL_SET_ERR_MSG(info, "did not match address and id");
> +		goto create_err;
> +	}
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	if (!mptcp_pm_alloc_anno_list(msk, &local)) {
> +		GENL_SET_ERR_MSG(info, "cannot alloc address list");
> +		err = -EINVAL;
> +		goto anno_list_err;
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
> +		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);
> +anno_list_err:
> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +		spin_unlock_bh(&msk->pm.lock);
> +	}
> +
>   create_err:
>  	sock_put((struct sock *)msk);
>  	return err;

Regarding the removal of mptcp_userspace_pm_delete_local_addr() from
mptcp_nl_cmd_sf_destroy(): did you do that to be able to send a RM_ADDR
after having destroyed a subflow?

Doing this or not mean we can have 2 behaviours with different pros and
cons:

1) either we keep a list of all the local addresses that have been used
and we never remove entries:
   - we can have a huge list to iterate
   - we limit an MPTCP connection to max 255 different local addresses
(the ID is stored in 8 bits and the ID 0 is reserved)
   → that might be OK but maybe we don't need these restrictions?

2) or we delete local addresses when the subflow destroy command is used
   - we cannot invoke RM_ADDR after the destroy
   → is it an issue? "Destroy" means we remove stuff, it seems to make
sense, no?

Maybe it is better to have the 2nd behaviour? I think we will only want
to send a RM_ADDR and destroy the subflow "at the same time" if
something happened on the network side: the subflow has been closed
"by/because of the network" (e.g. timeout, rst) and we want to tell the
other peer to drop the subflow(s) with the corresponding ID. In this
case, it is fine (and makes sense) to call RM_ADDR before the destroy.
If we only want to remove the subflow because we no longer need it
before the end of the MPTCP connection, we don't need to send a RM_ADDR.

So I think it might be needed to re-add these lines from v12:

+		struct mptcp_pm_addr_entry entry = { .addr = addr_l };

+		spin_lock_bh(&msk->pm.lock);
+		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		spin_unlock_bh(&msk->pm.lock);

The selftests can then be adapted to send the remove address before the
destroy.


Also, if you don't call mptcp_userspace_pm_delete_local_addr() from
mptcp_nl_cmd_sf_destroy(), you will not decrement local_addr_used
counter in patch 1/7 from the second part.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
