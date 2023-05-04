Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7179D8
	for <mptcp@lists.linux.dev>; Thu,  4 May 2023 14:59:51 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so437122f8f.1
        for <mptcp@lists.linux.dev>; Thu, 04 May 2023 07:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1683212389; x=1685804389;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pj6IbyTFLCN419dqEFNzGUierqjGDAynrV6lEzhcAu8=;
        b=lfp7vJiKujhcn6yVt9BSbgAg6GLamS7IX07GSNAcn40E9fKV+7dgAYO1RtKsr6N2aW
         urgsuuxYsXpXYNO1vxUpUfchwVMVqzTjfX8NRa8WZmlgIvHghM+WBrzigdz9iIcj3Qbz
         eG57pUras6BdeVPxQT3IqLtV1rjHs/Gnh7Hg6145M6d900LZztLnykilRT/XMlphEwwK
         tZIegwT2DjmXckIi+hFw1f5WiwI7+LCue/RVmSQkJmLgmdxsCY/tntIE+VzNRc0wAe/0
         5zFfEX+zx5r2t+7DduqBBbfZNIhWGwOni3YnH62TF4HKAv0XZLbPpNJsBtG+orAmtH0z
         uk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212389; x=1685804389;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj6IbyTFLCN419dqEFNzGUierqjGDAynrV6lEzhcAu8=;
        b=R8YWakb2JvdgTayZ+45t5Dr/ZAppzwmKtGvjBESUF3NWWjUkYBtzmAuqjp3gpIh28Y
         w+Qhryu1vCPFi/TohUF0ruti0svr7yHJMFBDuJHN42dZyl2XSpoMXKXO7uZe+r1iS/oV
         ccixCakJ9tOtGzcBob8BV3CeJNzRSG9Xph9oQXpGfyYq6ysN9xH2JZ0ELco5FxI/c+OY
         y3r0nYKMW8pVUfDpyXgvPtJQGUttaGzqKpx8MFPF2T14dLOqFM+dzgSpFtVP+QTUgk+Q
         Fc7PM/rEwhRCdu18VVX0PwHaX29dQDedmYa1fhokmO+gP4WwntpPKiHrYkdC7vXsZpvl
         LQGA==
X-Gm-Message-State: AC+VfDzmnkuUktElHyRZD3CxMJxt3UfJxmCCC4XdA6uJUjqbODAcam+r
	Du9Pd4m9dN/eZby+OoYZe3NOssAod3eIN0TEqH0=
X-Google-Smtp-Source: ACHHUZ5GMMWKJGzgngc+OTI+tkL3Oqe9PGOnMOkeBeh/ni6f2IFLzcnh95q/V2aKPFcFKr1TKevieg==
X-Received: by 2002:adf:e808:0:b0:2f8:cd53:d882 with SMTP id o8-20020adfe808000000b002f8cd53d882mr2623953wrm.56.1683212389351;
        Thu, 04 May 2023 07:59:49 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6b04:8b76:7dd3:7b25? ([2a02:578:8593:1200:6b04:8b76:7dd3:7b25])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d6306000000b002fed865c55esm37106537wru.56.2023.05.04.07.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 07:59:49 -0700 (PDT)
Message-ID: <54773621-db9d-b7fd-f4ce-9ff470513668@tessares.net>
Date: Thu, 4 May 2023 16:59:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH mptcp-next v11 04/12] mptcp: add addr into userspace pm
 list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1683195386.git.geliang.tang@suse.com>
 <4ec2d013559dce53d222e9cbd53c45a4b4d5ba12.1683195386.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4ec2d013559dce53d222e9cbd53c45a4b4d5ba12.1683195386.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/05/2023 12:20, Geliang Tang wrote:
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
>  net/mptcp/pm_userspace.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6beadea8c67d..c50e1507ae35 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -79,6 +79,24 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
> +			 * be used multiple times (e.g. fullmesh mode). */

Thank you for the new comment.

Just to know if we need to create a new ticket: are you already looking
at that or you don't plan to? Do you prefer if I create a new ticket?

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
> @@ -251,6 +269,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry local = { 0 };
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_sock *msk;
> @@ -302,12 +321,40 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
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
> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +		spin_unlock_bh(&msk->pm.lock);
> +		goto create_err;

Here, you need to set err to a negative value, e.g. -EINVAL. And
probably good to send an NL error message as well, like above.

  if (!mptcp_pm_alloc_anno_list(msk, &local)) {
  	GENL_SET_ERR_MSG(info, "cannot alloc address list");
        err = -EINVAL;
        goto alloc_anno_list_fail;
  }

While at it, it might be good to use a new label (alloc_anno_list_fail),
so you don't have to clean and unlock again, see below.

> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
>  	lock_sock(sk);
>  
>  	err = __mptcp_subflow_connect(sk, &addr_l, &addr_r);
>  
>  	release_sock(sk);
>  
> +	spin_lock_bh(&msk->pm.lock);
> +	if (err) {

Maybe better to put the spin_lock inside the 'if (err)' section, no?
(i.e. no need to lock if there is no error)

> +		mptcp_pm_remove_anno_list_by_saddr(msk, &addr_l);

It might be good to add a new label here (e.g. "alloc_anno_list_fail"),
so we can go here in case of error with mptcp_pm_alloc_anno_list() above.

> +		mptcp_userspace_pm_delete_local_addr(msk, &local);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +
> +	/* If the subflow is closed from the other peer (not via a
> +	 * subflow destroy command then), we want to keep the entry
> +	 * not to assign the same ID to another address and to be
> +	 * able to send RM_ADDR after the removal of the subflow.
> +	 */

(maybe good to add this comment just above the declaration of the
mptcp_userspace_pm_delete_local_addr() function?)

> +
>   create_err:
>  	sock_put((struct sock *)msk);
>  	return err;
> @@ -420,10 +467,14 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
>  	if (ssk) {
>  		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
>  
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);

(maybe keep this operation with the MIBs as the last step as we
generally do?)

> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_userspace_pm_delete_local_addr(msk, &entry);

Why do you not need to call mptcp_pm_remove_anno_list_by_saddr() here?

> +		spin_unlock_bh(&msk->pm.lock);
>  		err = 0;
>  	} else {
>  		err = -ESRCH;

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
