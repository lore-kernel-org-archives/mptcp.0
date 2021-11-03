Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3392C96
	for <mptcp@lists.linux.dev>; Wed,  3 Nov 2021 23:06:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="255253125"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="255253125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 16:06:26 -0700
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="scan'208";a="501295903"
Received: from crschrol-desk6.amr.corp.intel.com ([10.251.25.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 16:06:26 -0700
Date: Wed, 3 Nov 2021 16:06:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fix race between close() and accept()
In-Reply-To: <beea1c3bd7e3fc9b8bc309874cec2597766d7fba.1635958931.git.pabeni@redhat.com>
Message-ID: <d77d8e84-90a9-8c61-1460-eb569646ca62@linux.intel.com>
References: <beea1c3bd7e3fc9b8bc309874cec2597766d7fba.1635958931.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 3 Nov 2021, Paolo Abeni wrote:

> The current implementation of mptcp_accept() is prone to the
> following race vs mptcp_close():
>
> (on CPU 0)
> listen(msk)
> accept(msk)
>  |-> mptcp_stream_accept(msk)
>        |-> <listen status check successful>
>
> (preempted or on CPU 1)
> close(msk)
>  |-> <msk->sk_state = TCP_CLOSE, ssk is orphaned, ssk state is unchanged>
>
> (preempted or on CPU 0, continuing accept())
>  |-> mptcp_accept()
>        |-> inet_csk_accept()
>              |-> <ssk status check is successful even if ssk is orphaned: oops>
>
> The solution is atomically close the listener subflow at mptcp_close()
> time.
>
> Reported-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note: this should close:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/239
>
> but without a repro I can't be sure...
> ---
> net/mptcp/protocol.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1ee3530ac2a3..4c96a9eb2142 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2712,18 +2712,25 @@ static void mptcp_close(struct sock *sk, long timeout)
> 	lock_sock(sk);
> 	sk->sk_shutdown = SHUTDOWN_MASK;
>
> -	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
> -		inet_sk_state_store(sk, TCP_CLOSE);
> +	if (sk->sk_state == TCP_LISTEN) {
> +		struct socket *listener;
> +
> +		listener = __mptcp_nmpc_socket(mptcp_sk(sk));
> +		if (listener)
> +			__mptcp_close_ssk(sk, listener->sk, mptcp_subflow_ctx(listener->sk));

It looks like __mptcp_close_ssk() will call 
mtpcp_dispose_initial_subflow() and destroy the listener without regard 
to the listener's sk_refcnt.

Does it make sense to wait until __mptcp_destroy_sock() to dispose of the 
listener instead (there's already a call there to do that), and 
add sock_hold(listener->sk)/sock_put(listener->sk) in mptcp_accept()?



> 		goto cleanup;
> 	}
>
> +	if (sk->sk_state == TCP_CLOSE)
> +		goto cleanup;
> +
> 	if (mptcp_close_state(sk))
> 		__mptcp_wr_shutdown(sk);
>
> 	sk_stream_wait_close(sk, timeout);
>
> cleanup:
> -	/* orphan all the subflows */
> +	/* orphan all the non listener subflows */
> 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
> 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
