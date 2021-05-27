Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDCA2FAD
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 04:19:34 +0000 (UTC)
IronPort-SDR: 0rhxPGoDYBzsVEcIZ29epf9A9GdZkPfxLaqt1bJ4hIxipuzXabvxbATMVJacgfhr+rdQ+K2NYZ
 WHoNVo2J4Shg==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182298309"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="182298309"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:19:33 -0700
IronPort-SDR: XbAfmlsnIXXNiJ+U5kEdtqFWL12C+Oq+Gk8xEb6Q751dy66030O1TNTCdQqI5L/2yRN7Ngftvx
 LwDlwRcYSbVA==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="477313922"
Received: from oelenito-mobl1.amr.corp.intel.com ([10.212.180.42])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:19:33 -0700
Date: Wed, 26 May 2021 21:19:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: use fast lock for subflows when
 possible.
In-Reply-To: <f18ab6d96263347de227dadcef3aff102f682ab9.1622045130.git.pabeni@redhat.com>
Message-ID: <1a3dec37-9b54-e6ba-ca36-db5ed7f6ebb4@linux.intel.com>
References: <f18ab6d96263347de227dadcef3aff102f682ab9.1622045130.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 26 May 2021, Paolo Abeni wrote:

> There are a bunch of callsite where the ssk socket
> lock is acquired using the full-blown version eligible for
> the fast variant. Let's move to the latter.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> The previous patch demonstrated that using lock_sock()
> were the fast version is available can have worse side-effect
> than slower performances.
>
> This tries to address the topic.
> ---
> net/mptcp/pm_netlink.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)

Looks good to me, thanks Paolo.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

-Mat


>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 09722598994d..d4732a4f223e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -540,6 +540,7 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
> 	if (subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
>
> 		spin_unlock_bh(&msk->pm.lock);
> 		pr_debug("send ack for %s%s%s",
> @@ -547,9 +548,9 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
> 			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
>
> -		lock_sock(ssk);
> +		slow = lock_sock_fast(ssk);
> 		tcp_send_ack(ssk);
> -		release_sock(ssk);
> +		unlock_sock_fast(ssk, slow);
> 		spin_lock_bh(&msk->pm.lock);
> 	}
> }
> @@ -566,6 +567,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		struct sock *sk = (struct sock *)msk;
> 		struct mptcp_addr_info local;
> +		bool slow;
>
> 		local_address((struct sock_common *)ssk, &local);
> 		if (!addresses_equal(&local, addr, addr->port))
> @@ -578,9 +580,9 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>
> 		spin_unlock_bh(&msk->pm.lock);
> 		pr_debug("send ack for mp_prio");
> -		lock_sock(ssk);
> +		slow = lock_sock_fast(ssk);
> 		tcp_send_ack(ssk);
> -		release_sock(ssk);
> +		unlock_sock_fast(ssk, slow);
> 		spin_lock_bh(&msk->pm.lock);
>
> 		return 0;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
