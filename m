Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D32310F1
	for <mptcp@lists.linux.dev>; Sat, 16 Dec 2023 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C91heBba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4355C433C7;
	Sat, 16 Dec 2023 01:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702690901;
	bh=9VMHWhifUzA01VpubFLnmHdMb7YQNMTOCrM6L3wbYC0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=C91heBbayk9DJZmVoi1D3NHhkpXwHBl+/JMlkeIOWmbGtEpLTgrBVMgO4bjn4//PJ
	 k6qmhLzrVO5DepmOORL1a9J3KsY9za0i1dURdUjWxQHp1UWNQepi/EwO6u7l0AHTtU
	 b21orP2AIRHCJw8D1uaRnGOlhwqXwK/BwwUam+TfOvIXATaWoSVHrpvu3jBV9ALP/r
	 qvpUOCF+I307OKad4LfwyPA8YIfNQhOuUVhUknKopXIIviJXDiIveOlbeiuVtN1cUO
	 x/BknTaNYCXF7HvtsrL77fc16uwsQBxCR8rt2cbOaXwKG4q6D+ArKfGO0S/Gc8tq+r
	 dHMUhJTtY0+2g==
Date: Fri, 15 Dec 2023 17:41:40 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 02/12] mptcp: implement
 mptcp_userspace_pm_dump_addr
In-Reply-To: <9e4c62819fcc70f6051fab05dd6e1beffbd8ee0f.1702282411.git.geliang.tang@linux.dev>
Message-ID: <d43df5a3-e0ba-3c80-2826-8e864bbc1774@kernel.org>
References: <cover.1702282411.git.geliang.tang@linux.dev> <9e4c62819fcc70f6051fab05dd6e1beffbd8ee0f.1702282411.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 11 Dec 2023, Geliang Tang wrote:

> This patch implements mptcp_userspace_pm_dump_addr() to dump addresses
> from userspace pm address list. For each msk in this net, if userspace
> PM is enabled in it, traverse each address entry in address list, put
> every entry to userspace using mptcp_pm_nl_put_entry_msg().
>
> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_userspace.c | 29 +++++++++++++++++++++++++++++
> net/mptcp/protocol.h     |  2 ++
> 2 files changed, 31 insertions(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index efecbe3cf415..6f659a78c637 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -550,3 +550,32 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
> 	sock_put(sk);
> 	return ret;
> }
> +
> +int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
> +				 struct netlink_callback *cb)

Hi Geliang -

The entire list of entries may not fit in one skb. The cb struct is used 
to store context so the netlink framework can call the dump function 
multiple times to fill multiple skbs. This is why the original 
mptcp_pm_nl_get_addr_dumpit() reads and stores the id to/from cb->args[0]. 
That cb->args[0] context is used to skip the ids that have already been 
dumped.

With the function body below, if the list does not fit in one skb it will 
do the same thing on every call and create duplicate entries, and will 
never return 0 to tell the caller that it is finished.

There is also nothing in the netlink output to indicate which MPTCP 
connection each subflow id is associated with, or whether the entry is 
from a userspace-managed socket or the in-kernel pm, so the dumped 
information is not useful to a userspace PM.

Netlink dump commands can have attributes in the request (see 
netdev_nl_napi_get_dumpit()), I think it will be simpler to add a 
connection token to the dump request and only dump the id list for that 
single MPTCP connection.

- Mat


> +{
> +	struct net *net = sock_net(msg->sk);
> +	struct mptcp_pm_addr_entry *entry;
> +	long s_slot = 0, s_num = 0;
> +	struct mptcp_sock *msk;
> +
> +	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
> +		struct sock *sk = (struct sock *)msk;
> +
> +		if (mptcp_pm_is_userspace(msk)) {
> +			lock_sock(sk);
> +			spin_lock_bh(&msk->pm.lock);
> +			list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> +				if (mptcp_pm_nl_put_entry_msg(msg, cb, entry))
> +					break;
> +			}
> +			spin_unlock_bh(&msk->pm.lock);
> +			release_sock(sk);
> +		}
> +
> +		sock_put(sk);
> +		cond_resched();
> +	}
> +
> +	return msg->len;
> +}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 23d4742f3f30..a05a6745bc31 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -1028,6 +1028,8 @@ int mptcp_pm_nl_put_entry_msg(struct sk_buff *msg,
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
