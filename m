Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070D10E3
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNK6kSIU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8F0C433C8;
	Sat,  6 Jan 2024 01:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704503800;
	bh=xB2r4Sn0l0Xj2dg+DZ7PRmYNZSyGH0E6sXchldzLO8I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dNK6kSIU8qDvmn2auH2l7od/D6ezHi1hH6iBeL9alBQJk1Wfq9NbP6Cp3TTwUrCMr
	 9eppEe2GNl6ZWQEQl22sSQY0ozDL35z2BAFqmLo2rFgAqjMAvEWV8wY7jSFWF+ryyn
	 kwcvx2OW3e+g29jOdHMAgZYYgWdyINdj5gr8vCiJY2fIBDrKhhxA/iKL1byi7+xKmU
	 IFcxNpvwto/NmK76v86IFT+8Zig7WbwzfARFtHq296q5np0UtzGz6PlM9LsAGqI7E+
	 /JLpjzn/yk1aOAjVfTzdCtocaY6vezEBzVNScMvRzpDE38kq0LkXHJ/yJMe6DHgiCr
	 84HhaX0AyD9bQ==
Date: Fri, 5 Jan 2024 17:16:40 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 08/24] mptcp: implement
 mptcp_userspace_pm_dump_addr
In-Reply-To: <a3d164f8f7d10b8805b01cf6284ed1cfdd12b28d.1703904325.git.geliang.tang@linux.dev>
Message-ID: <0a290410-7949-f7bd-a9ee-2fecaa303c23@kernel.org>
References: <cover.1703904325.git.geliang.tang@linux.dev> <a3d164f8f7d10b8805b01cf6284ed1cfdd12b28d.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Dec 2023, Geliang Tang wrote:

> This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
> from userspace pm address list. Use mptcp_token_get_sock() to get the
> msk from the given token, if userspace PM is enabled in it, traverse
> each address entry in address list, put every entry to userspace using
> mptcp_pm_nl_put_entry_msg().
>
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_userspace.c | 58 ++++++++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h     |  2 ++
> 2 files changed, 60 insertions(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 9df643373c39..98237108ddcf 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -576,3 +576,61 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
> 	sock_put(sk);
> 	return ret;
> }
> +
> +int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
> +				 struct netlink_callback *cb)
> +{
> +	struct id_bitmap {
> +		DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
> +	} *bitmap;
> +	const struct genl_info *info = genl_info_dump(cb);
> +	struct net *net = sock_net(msg->sk);
> +	struct mptcp_pm_addr_entry *entry;
> +	struct mptcp_sock *msk;
> +	struct nlattr *token;
> +	int ret = -EINVAL;
> +	struct sock *sk;
> +	void *hdr;
> +
> +	bitmap = (struct id_bitmap *)cb->ctx;
> +	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> +
> +	msk = mptcp_token_get_sock(net, nla_get_u32(token));
> +	if (!msk) {
> +		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
> +		return ret;
> +	}
> +
> +	if (!mptcp_pm_is_userspace(msk)) {
> +		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
> +		return ret;
> +	}
> +
> +	sk = (struct sock *)msk;
> +
> +	lock_sock(sk);
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> +		if (test_bit(entry->addr.id, bitmap->map))
> +			continue;
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
> +		__set_bit(entry->addr.id, bitmap->map);
> +		genlmsg_end(msg, hdr);
> +	}
> +	spin_unlock_bh(&msk->pm.lock);
> +	release_sock(sk);
> +
> +	*((struct id_bitmap *)cb->ctx) = *bitmap;

Hi Geliang -

Since the __set_bit() above already handled the indirection for you and 
made any changes directly to the cb->ctx memory location, this assignment 
is not needed.

- Mat

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
> 2.39.2
>
>
>
