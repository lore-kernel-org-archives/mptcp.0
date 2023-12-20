Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB4482F3
	for <mptcp@lists.linux.dev>; Wed, 20 Dec 2023 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7gebHy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FBFC433C8;
	Wed, 20 Dec 2023 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703100224;
	bh=NKF9ztNmawYUUJuyiKFklbcLU14SoBIn4Ofm8pgkFVU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=u7gebHy5mTkpGhqsuglxC+vZ5Q5NHIPFDzORzQnaXBfThOAkKc5q4pd+ViZa+0nL1
	 fQwaAWubUZpwMQ9ofF0hO+s6PweGcwaDNeXdRN4TznB5QFFxMtYjUY2Qnm65ugHaYt
	 fJEMDqhqRI1oJ4ICW7Bf2+19IQnEKCW37p+WgVO1jrBXzlfamriRJwip+gwtXbee36
	 hHzJHiZ1eXXcxPE1tBYfDXwRTUud3ssB7dUsNfcpUA4mhSj4THCuDT/5ZRFy7jBiis
	 Fgz49HrRxjALXImjMig1uScrE03Fd8IXYx4+2p3laH3LJ3CwZTwTge8ZDphDTpOZy3
	 HPUmRma9KEgOg==
Date: Wed, 20 Dec 2023 11:23:43 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 02/14] mptcp: implement
 mptcp_userspace_pm_dump_addr
In-Reply-To: <bada36b2aba2ef3854e89af90ab67c7067840661.1702992525.git.geliang.tang@linux.dev>
Message-ID: <c97ec49c-79ab-9c73-665e-c1c74df76c65@kernel.org>
References: <cover.1702992525.git.geliang.tang@linux.dev> <bada36b2aba2ef3854e89af90ab67c7067840661.1702992525.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 19 Dec 2023, Geliang Tang wrote:

> This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
> from userspace pm address list. Use mptcp_token_get_sock() to get the
> msk from the given token, if userspace PM is enabled in it, traverse
> each address entry in address list, put every entry to userspace using
> mptcp_pm_nl_put_entry_msg().
>
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_userspace.c | 48 ++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h     |  2 ++
> 2 files changed, 50 insertions(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index efecbe3cf415..1c8007acf7f3 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -550,3 +550,51 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
> 	sock_put(sk);
> 	return ret;
> }
> +
> +int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
> +				 struct netlink_callback *cb)
> +{
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct net *net = sock_net(msg->sk);
> +	struct mptcp_pm_addr_entry *entry;
> +	struct mptcp_sock *msk;
> +	int id = cb->args[0];
> +	int ret = -EINVAL;
> +	struct sock *sk;
> +	void *hdr;
> +
> +	msk = mptcp_token_get_sock(net, nla_get_u32(info->attrs[MPTCP_PM_ATTR_TOKEN]));
> +	if (!msk)
> +		return ret;

Hi Geliang -

In addition to returning the error value, also set an error message with 
NL_SET_ERR_MSG_ATTR (similar to the handling of an invalid token in 
mptcp_pm_nl_announce_doit).

> +
> +	if (!mptcp_pm_is_userspace(msk))
> +		return ret;
> +
> +	sk = (struct sock *)msk;
> +
> +	lock_sock(sk);
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (entry->addr.id <= id)
> +			continue;

Since userspace_pm_local_addr_list is not sorted, the check for "<= id" 
isn't going to work here. Need to also assume the list could change while 
the lock is not held, so I think the netlink_callback context needs a 
bitmap to keep track of which IDs have been dumped already.

Fortunately struct netlink_callback has 48 bytes to store context, and 
there's a comment in the struct declaration that recommends casting a 
struct over cb->ctx[], which has enough room for 256 MPTCP address IDs. 
This would also avoid using the deprecated args[] member (args[] and ctx[] 
are in a union).

- Mat


> +
> +		hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
> +				  cb->nlh->nlmsg_seq, &mptcp_genl_family,
> +				  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
> +		if (!hdr)
> +			break;
> +
> +		if (mptcp_nl_fill_addr(msg, entry) < 0) {
> +			genlmsg_cancel(msg, hdr);
> +			break;
> +		}
> +
> +		id = entry->addr.id;
> +		genlmsg_end(msg, hdr);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +	release_sock(sk);
> +
> +	cb->args[0] = id;
> +	return msg->len;
> +}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9b0b3fa65ae5..7c0d592a9a45 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1029,6 +1029,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> +int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
> +				 struct netlink_callback *cb);
>
> void __init mptcp_pm_nl_init(void);
> void mptcp_pm_nl_work(struct mptcp_sock *msk);
> -- 
> 2.35.3
>
>
>
