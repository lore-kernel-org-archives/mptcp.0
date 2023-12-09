Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906027F8
	for <mptcp@lists.linux.dev>; Sat,  9 Dec 2023 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUaoIkCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76B2C433C7;
	Sat,  9 Dec 2023 01:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702085165;
	bh=+Bc6/jsbv9hnXE0TTj/jekUCEyst+O0e+ZAULhxEEww=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qUaoIkCKe+WgUIfkEYSVKpHTvxbd0F4mKZkSfhm8NkKAxJ4cwTKgGNinGpHrqsfJg
	 3ey9ZxIgn+hgx2dGAewVaART25N2E4k+zs16kHRa0WySY4OJMPAQ9kS60Cw1cNEDQo
	 6KzFEKBveP6MH+44qcRC3XiNpYWeLDZz89Z5jx6/QZa3R85PX2Mn/QOAZlTfmmGx4n
	 ENxHOO3vwmsKW/noQDN1HNOFUO/RzaoDlV6qKw32NqvpCVjiPVDUZaVhmYsJw1LN4A
	 9AAjOZOvjzb/jtmEJvYeHaWhvmkX6bBZpebhJgt+mCfbpEG0QPneEUIkCvtcg0vYmq
	 3VfqqKlWx8+TA==
Date: Fri, 8 Dec 2023 17:26:05 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 06/25] mptcp: dump addrs in userspace pm
 list
In-Reply-To: <c4e0b884beb2f6dac38792d4881c1c1943a329ad.1702029538.git.geliang.tang@linux.dev>
Message-ID: <99092ce5-dd9a-991e-c588-e6ffeb0b0520@kernel.org>
References: <cover.1702029538.git.geliang.tang@linux.dev> <c4e0b884beb2f6dac38792d4881c1c1943a329ad.1702029538.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 8 Dec 2023, Geliang Tang wrote:

> This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
> the address entry by the given id in the userspace local addresses list.
> Invoke it when dumping addresses from netlink commands.
>

Hi Geliang -

The existing per-net dump command won't work for the userspace PM, since 
each connection can have separate local address lists. So, the get-addr 
dump command needs an optional 'token' parameter that will dump the local 
addr list for one userspace PM connection.

- Mat

> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_netlink.c   |  9 +++++++--
> net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
> net/mptcp/protocol.h     |  2 ++
> 3 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1c85d711a86e..489a7723efc4 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1676,8 +1676,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
> 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
> 		if (test_bit(i, pernet->id_bitmap)) {
> 			entry = __lookup_addr_by_id(pernet, i);
> -			if (!entry)
> -				break;
> +			if (!entry) {
> +				spin_unlock_bh(&pernet->lock);
> +				entry = __userspace_pm_lookup_addr_by_id(net, i);
> +				spin_lock_bh(&pernet->lock);
> +				if (!entry)
> +					break;
> +			}
>
> 			if (entry->addr.id <= id)
> 				continue;
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6999296cd5db..5e45e36ce1d3 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -549,3 +549,28 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
> 	sock_put(sk);
> 	return ret;
> }
> +
> +struct mptcp_pm_addr_entry *
> +__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
> +{
> +	struct mptcp_pm_addr_entry *entry = NULL;
> +	long s_slot = 0, s_num = 0;
> +	struct mptcp_sock *msk;
> +
> +	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> +		struct sock *sk = (struct sock *)msk;
> +
> +		if (mptcp_pm_is_userspace(msk)) {
> +			lock_sock(sk);
> +			spin_lock_bh(&msk->pm.lock);
> +			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
> +			spin_unlock_bh(&msk->pm.lock);
> +			release_sock(sk);
> +		}
> +
> +		sock_put(sk);
> +		cond_resched();
> +	}
> +
> +	return entry;
> +}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8296bdf58f90..3ab4a4f1bf81 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1025,6 +1025,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
> int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
> +struct mptcp_pm_addr_entry *
> +__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
>
> void __init mptcp_pm_nl_init(void);
> void mptcp_pm_nl_work(struct mptcp_sock *msk);
> -- 
> 2.35.3
>
>
>
