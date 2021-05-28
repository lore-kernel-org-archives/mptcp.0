Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F929CA
	for <mptcp@lists.linux.dev>; Fri, 28 May 2021 00:07:38 +0000 (UTC)
IronPort-SDR: t9YV3pb6YsGtoT3lSZmsZRnrcfRzcsq6V+y7G9mjdw/0VUFz8wyKGpq3s2rm/DE6cQXVmIO+cD
 2DuREsybOqbA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="266749007"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="266749007"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:05:34 -0700
IronPort-SDR: kNeZBA72F5p7T72o6sGQpLB0FwytwQiArrh5H/gax0tzqnpLqz7pZzKLkLzri3Dqt8OYq4PTuB
 2wmZBgVcXIuw==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="634174423"
Received: from mkronenb-mobl.amr.corp.intel.com ([10.209.5.218])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:05:34 -0700
Date: Thu, 27 May 2021 17:05:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next] mptcp: use fast lock for subflows when
 possible.
In-Reply-To: <ef0582a975599149d8a127d6f6914760bb64f136.1622131853.git.pabeni@redhat.com>
Message-ID: <1f2a9e6-7099-146a-aec9-b2874e6db3ff@linux.intel.com>
References: <ef0582a975599149d8a127d6f6914760bb64f136.1622131853.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 27 May 2021, Paolo Abeni wrote:

> There are a bunch of callsite where the ssk socket
> lock is acquired using the full-blown version eligible for
> the fast variant. Let's move to the latter.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - add more chunks in protocol.c

Looks good, thanks Paolo.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> ---
> net/mptcp/pm_netlink.c | 10 ++++++----
> net/mptcp/protocol.c   | 15 +++++++++------
> 2 files changed, 15 insertions(+), 10 deletions(-)
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
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 785e74c13b3c..786f09d83d35 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -433,23 +433,25 @@ static void mptcp_send_ack(struct mptcp_sock *msk)
>
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
>
> -		lock_sock(ssk);
> +		slow = lock_sock_fast(ssk);
> 		if (tcp_can_send_ack(ssk))
> 			tcp_send_ack(ssk);
> -		release_sock(ssk);
> +		unlock_sock_fast(ssk, slow);
> 	}
> }
>
> static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> {
> +	bool slow;
> 	int ret;
>
> -	lock_sock(ssk);
> +	slow = lock_sock_fast(ssk);
> 	ret = tcp_can_send_ack(ssk);
> 	if (ret)
> 		tcp_cleanup_rbuf(ssk, 1);
> -	release_sock(ssk);
> +	unlock_sock_fast(ssk, slow);
> 	return ret;
> }
>
> @@ -2252,13 +2254,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>
> 	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
> 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow;
>
> -		lock_sock(tcp_sk);
> +		slow = lock_sock_fast(tcp_sk);
> 		if (tcp_sk->sk_state != TCP_CLOSE) {
> 			tcp_send_active_reset(tcp_sk, GFP_ATOMIC);
> 			tcp_set_state(tcp_sk, TCP_CLOSE);
> 		}
> -		release_sock(tcp_sk);
> +		unlock_sock_fast(tcp_sk, slow);
> 	}
>
> 	inet_sk_state_store(sk, TCP_CLOSE);
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
