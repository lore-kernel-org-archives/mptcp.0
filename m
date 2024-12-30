Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C1EAD2D
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735576424; cv=none; b=St1etWxplUGVoRhFExAV6hbF/u3RDu3UftzXdZP/vxdeWRrd5HXwPt7Ze6WDiA/ly1HR6bVCgy5cDcim8e1owrRGJTqsNpP4MTDGLFgUQICkRYRchPfsUVsZYM8YZbQvUmhXU/4tjbDbbnBnFND+Fe0QOVOUIJKt0+mOnwOmO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735576424; c=relaxed/simple;
	bh=6Eb9wd6FDOsWyUa2fRcAXGVvqyyt4bQir2p+sDhNlpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBk4E+pkMMPy0qPM/Z4J1puRRwaDwIWuN/BNZTG9wYQzK7d8+OOjohHqP4eUn0V8Lvl9aKBeVR1SsgT0y8yOnrglU5GWy3YYcWosveLCpsy1674u5GkOcjAUpctNgh9igXrXEk1wu2CuQtZR6N0UW6whF97WIa58cCLU7h6BDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjoUBhng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjoUBhng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D70BC4CED0;
	Mon, 30 Dec 2024 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735576424;
	bh=6Eb9wd6FDOsWyUa2fRcAXGVvqyyt4bQir2p+sDhNlpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jjoUBhngBuWq3iQ9l2jy0T49uzOLScgDCvTEsHM/fPYdl1JxGXbYvd+DbtZxQH8jN
	 4otz5OvDGGMeC8z5B3MZM+PYcb/xo+N0/qkHF1GzWboHInRNKVbMd+lsG8dHVYNez5
	 d+z0+f3eTgBzjckHnSv9YBUivZK/omfrDCxcTDGzttADsJqlMy4bBXqZo7pzYzqmUz
	 FfKSLpNty6+tloCSbM/NytQw1AeLgza6+LNNH7C7i2eiv3ykX9pX+RoxFQN0cahtsM
	 SuF7Szx6sGuS5NIF3byjEwDK4hSirVaxlmFMmJi1WcxiOGqtxuZ1nKndJf7bb7XfOp
	 oYE0djwJ/uapg==
Message-ID: <410bc1d4-8cf1-482c-a64c-1dc96996fe48@kernel.org>
Date: Mon, 30 Dec 2024 17:33:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 8/8] mptcp: reuse sending nlmsg code in
 dump_addr
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
 <8d1c6172111ac7a9d140e451233b6baa15481e07.1734074788.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8d1c6172111ac7a9d140e451233b6baa15481e07.1734074788.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

It looks like the code below only works if the dump can be done in one call.

I spent quite a bit of time looking at it, and at the end, I would like
to say it doesn't look like this modification is worth it: it increases
the complexity just to save a bit of duplicated code (which is used
differently). WDYT? Or do you really need this for the BPF PM?

Here below, you can find my review, but in short, I don't think we
should try to unify the code here. WDYT?

On 13/12/2024 08:35, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> With the help of get_addr(), we can modify dump_addr() interfaces
> to reuse send_nlmsg code between the netlink PM and userspace PM.
> 
> The current dump_addr() flow looks like this:
> 
> 	lock();
> 	for_each_entry(entry)
> 		send_nlmsg(entry);
> 	unlock();
> 
> After holding the lock, get every entry by walking the address list,
> send each one looply, and finally release the lock.
> 
> This set changes the process by copying the address list to an id
> bitmap while holding the lock, then release the lock immediately.
> After that, without locking, walking the copied id bitmap to get
> every copy of entry by using get_addr(), and send each one looply:
> 
> 	lock();
> 	for_each_entry(entry)
> 		set_bit(bitmap);
> 	unlock();
> 
> 	for_each_bit(bitmap) {
> 		copy = get_addr();

What you are hiding here is that there will be a lock again here for
each address: so we will lock and unlock once before, and once per
address... Maybe we don't care about that here, but is it really worth it?

> 		send_nlmsg(copy);
> 	}
> 
> With this, we can reuse the send_nlmsg() code in dump_addr() interfaces
> between the netlink PM and userspace PM. They only need to implement
> their own dump_addr() interfaces to hold the different locks, copy the
> different address lists to an id bitmap, then release the locks.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c           | 43 ++++++++++++++++++++++++++++++++++++----
>  net/mptcp/pm_netlink.c   | 35 +++-----------------------------
>  net/mptcp/pm_userspace.c | 41 ++++++++++++++------------------------
>  net/mptcp/protocol.h     |  6 ++----
>  4 files changed, 59 insertions(+), 66 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 0aaf16319c34..22c0ca77ca0d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -485,20 +485,55 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
>  	return ret;
>  }
>  
> -static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb,
> +static int mptcp_pm_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
>  			      const struct genl_info *info)
>  {
>  	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
> -		return mptcp_userspace_pm_dump_addr(msg, cb, info);
> -	return mptcp_pm_nl_dump_addr(msg, cb, info);
> +		return mptcp_userspace_pm_dump_addr(bitmap, info);
> +	return mptcp_pm_nl_dump_addr(bitmap, info);
>  }
>  
>  int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
>  				struct netlink_callback *cb)
>  {
>  	const struct genl_info *info = genl_info_dump(cb);
> +	mptcp_pm_addr_id_bitmap_t *bitmap;
> +	struct mptcp_pm_addr_entry entry;
> +	int id = cb->args[0];
> +	void *hdr;
> +	int i;
> +
> +	bitmap = (mptcp_pm_addr_id_bitmap_t *)cb->ctx;

Mmh, that feels wrong: you are using cb->ctx and cb->args at the same
part, but they are part of an union. This will likely only work the
first time, not if dumpit() is called in multiple chunks, no?

For it to work, I guess you should only copy the bitmap the first time
(not sure what you can look at, reserve some bits in cb->ctx for that?),
then use __test_and_clear_bit() instead of test_bit(). But again, not
sure if it is really worth it, that makes things a bit more complex.


BTW, not related to ↑, but it might be safer to add a build check to
make sure sizeof(cb->ctx) >= sizeof(mptcp_pm_addr_id_bitmap_t), just in
case we change it later.

> +
> +	mptcp_pm_dump_addr(bitmap, info);

Should you not only fill the bitmap the first time? I'm not sure if I
fully understand how it is used, but from what I see, the dump can be
done in multiple calls, hence the use of cb. Here this fill the bitmap
without taking into account what was done before.

> +
> +	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
> +		if (test_bit(i, bitmap->map)) {
> +			if (mptcp_pm_get_addr(i, &entry, info))
> +				break;

I don't think you should "break" here, but "continue" instead:
potentially between the two calls, the address at this ID might have
been removed.

> +
> +			if (id && entry.addr.id <= id)

Why is the condition different from before in pm_netlink.c? Why do you
need to explicitly skip id 0?

If I'm not mistaken, with the in-kernel PM, we cannot have ID 0 here,
but we can with the userspace PM, no?

> +				continue;
> +
> +			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> +					  cb->nlh->nlmsg_seq,
> +					  &mptcp_genl_family, NLM_F_MULTI,
> +					  MPTCP_PM_CMD_GET_ADDR);
> +			if (!hdr)
> +				break;
> +
> +			if (mptcp_nl_fill_addr(msg, &entry) < 0) {
> +				genlmsg_cancel(msg, hdr);
> +				break;
> +			}
> +
> +			id = entry.addr.id;
> +			genlmsg_end(msg, hdr);
> +		}
> +	}
>  
> -	return mptcp_pm_dump_addr(msg, cb, info);
> +	cb->args[0] = id;
> +	return msg->len;
>  }
>  
>  static int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 0d826bfc4718..831c440d6cc5 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1783,48 +1783,19 @@ int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
>  	return ret;
>  }
>  
> -int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
> -			  struct netlink_callback *cb,
> +int mptcp_pm_nl_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
>  			  const struct genl_info *info)
>  {
>  	struct net *net = genl_info_net(info);
> -	struct mptcp_pm_addr_entry *entry;
>  	struct pm_nl_pernet *pernet;
> -	int id = cb->args[0];
> -	void *hdr;
> -	int i;
>  
>  	pernet = pm_nl_get_pernet(net);
>  
>  	rcu_read_lock();
> -	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
> -		if (test_bit(i, pernet->id_bitmap)) {
> -			entry = __lookup_addr_by_id(pernet, i);
> -			if (!entry)
> -				break;
> -
> -			if (entry->addr.id <= id)
> -				continue;
> -
> -			hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> -					  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> -					  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> -			if (!hdr)
> -				break;
> -
> -			if (mptcp_nl_fill_addr(msg, entry) < 0) {
> -				genlmsg_cancel(msg, hdr);
> -				break;
> -			}
> -
> -			id = entry->addr.id;
> -			genlmsg_end(msg, hdr);
> -		}
> -	}
> +	bitmap_copy(bitmap->map, pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>  	rcu_read_unlock();

"pernet->id_bitmap" is not protected by RCU, only the endpoints are
(linked to __lookup_addr_by_id()).

In other words, rcu_read_(un)lock() are no longer needed here.

It also means that potentially, we are changing the behaviour of the
dump when endpoints are being modified but:

— MPTCP netlink commands are processed one by one, so this should not
happen if I'm not mistaken.

— Even if the endpoints were being modified during a dump (maybe it can
if the endpoints cannot all fit in the buffer?), that's OK if it reports
the previous version of just updated info.

>  
> -	cb->args[0] = id;
> -	return msg->len;
> +	return 0;
>  }

This helper no longer dump addresses any more, it only copies the
bitmap. Should it be eventually renamed?

>  static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 0d9bea3a04a2..0db477b703a5 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -614,18 +614,25 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
>  	return ret;
>  }
>  
> -int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
> -				 struct netlink_callback *cb,
> -				 const struct genl_info *info)
> +static int mptcp_userspace_pm_reset_bitmap(struct mptcp_sock *msk,
> +					   mptcp_pm_addr_id_bitmap_t *bitmap)
>  {
> -	mptcp_pm_addr_id_bitmap_t *bitmap;
>  	struct mptcp_pm_addr_entry *entry;
> +
> +	bitmap_zero(bitmap->map, MPTCP_PM_MAX_ADDR_ID + 1);
> +
> +	mptcp_for_each_userspace_pm_addr(msk, entry)
> +		__set_bit(entry->addr.id, bitmap->map);
> +
> +	return 0;
> +}
> +
> +int mptcp_userspace_pm_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
> +				 const struct genl_info *info)
> +{
>  	struct mptcp_sock *msk;
>  	int ret = -EINVAL;
>  	struct sock *sk;
> -	void *hdr;
> -
> -	bitmap = (mptcp_pm_addr_id_bitmap_t *)cb->ctx;
>  
>  	msk = mptcp_userspace_pm_get_sock(info);
>  	if (!msk)
> @@ -635,27 +642,9 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  
>  	lock_sock(sk);
>  	spin_lock_bh(&msk->pm.lock);
> -	mptcp_for_each_userspace_pm_addr(msk, entry) {
> -		if (test_bit(entry->addr.id, bitmap->map))
> -			continue;
> -
> -		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> -				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> -				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> -		if (!hdr)
> -			break;
> -
> -		if (mptcp_nl_fill_addr(msg, entry) < 0) {
> -			genlmsg_cancel(msg, hdr);
> -			break;
> -		}
> -
> -		__set_bit(entry->addr.id, bitmap->map);
> -		genlmsg_end(msg, hdr);
> -	}
> +	ret = mptcp_userspace_pm_reset_bitmap(msk, bitmap);

Mmh, I don't understand this. If I'm not mistaken, before, we were using
a bitmap because in case the dump had to be done in multiple parts, we
required a way to mark which IDs had already been dumped.

But here, with your modification, you fill all the bitmap like we would
be able to dump everything in one go: the bitmap is written with all
entries, and reset each time we need to "dump the rest". So at the end,
we no longer remember what was done in the previous parts, and we would
dump the same thing over and over, no?

>  	spin_unlock_bh(&msk->pm.lock);
>  	release_sock(sk);
> -	ret = msg->len;
>  
>  	sock_put(sk);
>  	return ret;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index da2cf524c5da..ed629320ba56 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1124,11 +1124,9 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_in
>  bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
>  bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
>  bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> -int mptcp_pm_nl_dump_addr(struct sk_buff *msg,
> -			  struct netlink_callback *cb,
> +int mptcp_pm_nl_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
>  			  const struct genl_info *info);
> -int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
> -				 struct netlink_callback *cb,
> +int mptcp_userspace_pm_dump_addr(mptcp_pm_addr_id_bitmap_t *bitmap,
>  				 const struct genl_info *info);
>  int mptcp_pm_nl_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
>  			 const struct genl_info *info);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

