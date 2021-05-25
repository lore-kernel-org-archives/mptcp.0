Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516A17F
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 00:16:54 +0000 (UTC)
IronPort-SDR: bv6/MaLfxozvVt8i1eCK4qQq79bu7phvqrynKoOYajN5rGI/l03obUMUzsYYGcEeUPzLY+HH0C
 1FQWdEFDwznA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="189440959"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="189440959"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:16:50 -0700
IronPort-SDR: pp1om8kJ5Nx5YB8+Rpl+6qeXdApUMUqJB1/iF2A7cHbsG3We/QZw2l2B6rv0sk6un2srVrpbXS
 Q5uR9MfU8xcQ==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="614296828"
Received: from taclark-mobl4.amr.corp.intel.com ([10.212.246.204])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 17:16:50 -0700
Date: Mon, 24 May 2021 17:16:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v7 mptcp-next 3/5] mptcp: add add_cached in
 mptcp_pm_data
In-Reply-To: <c27772875a9bf14dd336526f48676f368758be97.1621839764.git.geliangtang@gmail.com>
Message-ID: <b2356854-d4e-5968-582e-b8736aeea04b@linux.intel.com>
References: <cover.1621839764.git.geliangtang@gmail.com> <7df5c99cf5336e3c1b0225903c75d01bbcde8daf.1621839764.git.geliangtang@gmail.com> <372e8fb0d481dfed41cf7e01c60b18c55a852f7e.1621839764.git.geliangtang@gmail.com>
 <c27772875a9bf14dd336526f48676f368758be97.1621839764.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 24 May 2021, Geliang Tang wrote:

> This patch added a new member add_cached in struct mptcp_pm_data, to
> track the most recent received ADD_ADDR information. Also invalidate
> it if a matching REMOVE_ADDR is received.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/pm.c         | 1 +
> net/mptcp/pm_netlink.c | 3 +++
> net/mptcp/protocol.h   | 1 +
> 3 files changed, 5 insertions(+)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 9d00fa6d22e9..edc57ff4c1dd 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -316,6 +316,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> 	msk->pm.subflows = 0;
> 	msk->pm.rm_list_tx.nr = 0;
> 	msk->pm.rm_list_rx.nr = 0;
> +	msk->pm.add_cached.id = 0;
> 	WRITE_ONCE(msk->pm.work_pending, false);
> 	WRITE_ONCE(msk->pm.addr_signal, 0);
> 	WRITE_ONCE(msk->pm.accept_addr, false);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 09722598994d..795f6d84bbfc 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -515,6 +515,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> 		remote.port = sk->sk_dport;
> 	memset(&local, 0, sizeof(local));
> 	local.family = remote.family;
> +	msk->pm.add_cached = remote;
>
> 	spin_unlock_bh(&msk->pm.lock);
> 	__mptcp_subflow_connect(sk, &local, &remote, 0, 0);

I think the above few lines of code show the point Paolo was making in the 
meeting last week (and I didn't get the full implications of it at the 
time). If this is the point where the extra remote address is received and 
cached, then there's already a __mptcp_subflow_connect() here to connect 
to the peer - and the connection code in 
mptcp_pm_create_subflow_or_signal_addr() becomes redundant.

There's a corner case where the pernet limits change after an ADD_ADDR is 
received, but the above caching doesn't work for that because there's an 
optimization in mptcp_pm_add_addr_received() to echo the ADD_ADDR without 
scheduling the worker. So mptcp_pm_nl_add_addr_received() doesn't get 
called when pm->accept_addr is false, and the address information is lost. 
This could be handled by removing the optimization and modifying the 
worker, but that doesn't seem worthwhile.


So, after going on a detour after v4 of this patch set, I see the appeal 
of the simpler logic Paolo suggested in 
https://lore.kernel.org/mptcp/ef31d1b4b0456a02f0e8515c449ea4fd4e7c1611.camel@redhat.com/

Paolo, Geliang, what do you think about using that approach and removing 
the caching? (I'm guessing your first thought is "finally!"...)


-Mat


> @@ -631,6 +632,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
> 			if (rm_type == MPTCP_MIB_RMADDR) {
> 				msk->pm.add_addr_accepted--;
> 				WRITE_ONCE(msk->pm.accept_addr, true);
> +				if (msk->pm.add_cached.id == id)
> +					msk->pm.add_cached.id = 0;
> 			} else if (rm_type == MPTCP_MIB_RMSUBFLOW) {
> 				msk->pm.local_addr_used--;
> 			}
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1201ab04bcdf..d28f6cdc9798 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -185,6 +185,7 @@ struct mptcp_pm_data {
> 	struct mptcp_addr_info local;
> 	struct mptcp_addr_info remote;
> 	struct list_head anno_list;
> +	struct mptcp_addr_info add_cached;
>
> 	spinlock_t	lock;		/*protects the whole PM data */
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
