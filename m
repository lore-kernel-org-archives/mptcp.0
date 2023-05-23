Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F644C7B
	for <mptcp@lists.linux.dev>; Tue, 23 May 2023 14:49:14 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f605d8a8a9so22357355e9.0
        for <mptcp@lists.linux.dev>; Tue, 23 May 2023 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684853352; x=1687445352;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quIRQNBRejD7WAtKyakm/WGDcvmdp2F3ziFcM5ee76o=;
        b=pNHlK6l/LP8DuyBMwPOufNdZIXKidNvMn1LTM1X6WWGEcXRzZGM1KwGE+b9Xaqc7ao
         qw+VAYhj3PiJqvrqlseHAxJygCBAX8sT7YUs5UoTOU3acsoFYRPrCZrpmsalLTuw5rI2
         +9He5vCWztewbBAVYz0zYYams298V0+rmqM+yOnwkh++GNFy291rtJWI6fGShrZpabKp
         nBYSFhkSoDWlOPu4seCig/MiiXjPT/5D/nUUeaenIhoIBQ+wnySnpd1mgFA37hbJ0DLf
         URjtsGWezP3Q3RKqw38wHqKm9y4rx89u9/P1rPt9frakLj4DtekWpOpfUXtJDg2tSerP
         XFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853352; x=1687445352;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quIRQNBRejD7WAtKyakm/WGDcvmdp2F3ziFcM5ee76o=;
        b=cIa52RMT+hckozKgg5g5eTeZdGOnHVn2K/+9bzav/GGepS+8o9fZJdb8kxaWlVyG86
         3qUxJZYG8ocPwqXbGpAHMiFy6IG/BwQWBI3zB+J+u1boRySF90vxWNc+KVZsVzQ6HUpl
         uW7IG8BVFW59y2XBB7uzvTd8USbZsQYMN5Zwkg5tMWWG7Pm4Spu4iLBsVl/zVIZiCxd7
         gC7yUCYyxptaZcLnoCOm4TTB/Cw4LyRztglYh8OLAt4pPR15Gc0IxP+iBGv1ugOEUtta
         eCEBbHLpWFw5PVCa7Tc2TSB0WM0+6B6+ksxPrjBsItcjQu5YjHFIo7tBdv8oyRrPdM1r
         teqA==
X-Gm-Message-State: AC+VfDywReBNpyJNUnqm214XzCp4PoFd/tONbkhJeBmWL04x5owePkan
	xQ58/rKCTyGyIxoSFNmK2nBPCWO0xH5fl3GMidTcqtrt
X-Google-Smtp-Source: ACHHUZ7ZBCrhdUCP2f4vedwpYjg3k5Uz/i8rhARoObDdxVyZN7O4m1Gd9FKh1NQ/JWAYJ9ogCuWIag==
X-Received: by 2002:a05:600c:cf:b0:3f4:2572:2259 with SMTP id u15-20020a05600c00cf00b003f425722259mr10442287wmm.28.1684853352404;
        Tue, 23 May 2023 07:49:12 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6cb1:7d36:3be3:30d? ([2a02:578:8593:1200:6cb1:7d36:3be3:30d])
        by smtp.gmail.com with ESMTPSA id m17-20020a7bcb91000000b003f6050d35c9sm6435381wmi.20.2023.05.23.07.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:49:12 -0700 (PDT)
Message-ID: <5a6aeb8d-2fc5-739c-e9a9-48fd7b2f17ff@tessares.net>
Date: Tue, 23 May 2023 16:49:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v14 4/5] mptcp: add address into userspace pm
 list
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684760588.git.geliang.tang@suse.com>
 <eb878bc64faa6755849881acd361ae6682112e04.1684760588.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <eb878bc64faa6755849881acd361ae6682112e04.1684760588.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 22/05/2023 15:12, Geliang Tang wrote:
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
> Add two new removing flags for userspace PM: MPTCP_USER_PM_FLAG_RM_SIGNAL
> and MPTCP_USER_PM_FLAG_RM_SUBFLOW. They'll be set in mptcp_nl_cmd_remove()
> and mptcp_nl_cmd_sf_destroy(). The address entry'll be removed from
> userspace_pm_local_addr_list only when both flags are set.

I don't think we should do that, at least not as part of this commit
fixing a bug (not able to send a RM_ADDR for an address that has not
been announced but used in a subflow that has been created) and needed
for -net.

Also, it is unclear to me what use case you are trying to fix here.
Correct me if I'm wrong but typically, a RM_ADDR is sent either because:
- a previously announced address is no longer available → server use-case
- an address used when created new subflows is no longer usable and it
is no longer possible to close the subflow properly (with FIN) → mostly
a client use-case.

In other words, if the client sends a "destroy" command, it sounds
normal to me that the kernel will close the subflow (send FIN) and
remove all associated resources (if the same address was not used by
other subflows, hence the required refcount for the address entry).
After that, there is no need to send a remove address. Or am I missing
something?

So I think we don't need these flags, WDYT?

> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/uapi/linux/mptcp.h |  2 ++
>  net/mptcp/pm_userspace.c   | 72 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 32af2d278cb4..75737e4165f7 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -86,6 +86,8 @@ enum {
>  #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
>  #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
>  #define MPTCP_PM_ADDR_FLAG_IMPLICIT			(1 << 4)
> +#define MPTCP_USER_PM_FLAG_RM_SIGNAL			(1 << 5)
> +#define MPTCP_USER_PM_FLAG_RM_SUBFLOW			(1 << 6)
>  
>  enum {
>  	MPTCP_PM_CMD_UNSPEC,
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 622698fa36f7..5f0bdb5c8033 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -79,6 +79,30 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
> +			if (entry->flags & MPTCP_USER_PM_FLAG_RM_SUBFLOW)
> +				break;
> +			entry->flags |= MPTCP_USER_PM_FLAG_RM_SUBFLOW;
> +			if (entry->flags & MPTCP_USER_PM_FLAG_RM_SIGNAL) {
> +				/* TODO: a refcount is needed because the entry can
> +				 * be used multiple times (e.g. fullmesh mode).
> +				 */
> +				list_del_rcu(&entry->list);
> +				kfree(entry);
> +			}
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
> @@ -231,6 +255,12 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  		goto remove_err;
>  	}
>  
> +	if (match->flags & MPTCP_USER_PM_FLAG_RM_SIGNAL) {
> +		GENL_SET_ERR_MSG(info, "no need to remove this address");
> +		release_sock((struct sock *)msk);
> +		goto remove_err;
> +	}
> +
>  	rm_list.ids[rm_list.nr++] = match->addr.id;
>  	spin_lock_bh(&msk->pm.lock);
>  	mptcp_pm_remove_addr(msk, &rm_list);
> @@ -238,9 +268,12 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
>  
>  	release_sock((struct sock *)msk);
>  
> -	list_move(&match->list, &free_list);
> -	list_for_each_entry_safe(match, entry, &free_list, list) {
> -		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
> +	match->flags |= MPTCP_USER_PM_FLAG_RM_SIGNAL;
> +	if (match->flags & MPTCP_USER_PM_FLAG_RM_SUBFLOW) {
> +		list_move(&match->list, &free_list);
> +		list_for_each_entry_safe(match, entry, &free_list, list) {
> +			sock_kfree_s((struct sock *)msk, match, sizeof(*match));
> +		}
>  	}
>  
>  	err = 0;
> @@ -254,6 +287,7 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>  	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
> +	struct mptcp_pm_addr_entry local = { 0 };
>  	struct mptcp_addr_info addr_r;
>  	struct mptcp_addr_info addr_l;
>  	struct mptcp_sock *msk;
> @@ -305,12 +339,35 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
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

It looks strange to add an entry in the announced list: here we only
create new subflows, we don't announce an address (ADD_ADDR).

All you need here in mptcp_nl_cmd_sf_create() is to add the address in
the local addr list, no?

Did you do that to be able to send a RM_ADDR for addresses used to
create new subflows from here?

If yes, I guess you need to call mptcp_pm_remove_anno_list_by_saddr()
from mptcp_nl_cmd_remove() but ignore the result:

+	/* Remove ADD_ADDR associated timers, then send RM_ADDR */
+	mptcp_pm_remove_anno_list_by_saddr(msk, &match->addr);
+
+	rm_list.ids[rm_list.nr++] = match->addr.id;
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &rm_list);
+	spin_unlock_bh(&msk->pm.lock);

Note that it might be better to keep the helper mptcp_pm_remove_addrs()
in pm_netlink.c. If you do that, you can remove the patch 3/5 exporting
remove_anno_list_by_saddr().

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
> @@ -364,6 +421,11 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
>  	return NULL;
>  }
>  
> +/* If the subflow is closed from the other peer (not via a
> + * subflow destroy command then), we want to keep the entry
> + * not to assign the same ID to another address and to be
> + * able to send RM_ADDR after the removal of the subflow.
> + */

Could you move this comment above mptcp_userspace_pm_delete_local_addr()
please? I think it makes more sense there (that's about removeing local
address).

>  int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
> @@ -423,7 +485,11 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>  	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
>  	if (ssk) {
>  		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
>  
> +		spin_lock_bh(&msk->pm.lock);
> +		mptcp_userspace_pm_delete_local_addr(msk, &entry);
> +		spin_unlock_bh(&msk->pm.lock);
>  		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
>  		mptcp_close_ssk(sk, ssk, subflow);
>  		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
