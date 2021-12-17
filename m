Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913502CA0
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 00:40:33 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="239454094"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="239454094"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:40:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="464924987"
Received: from jastump-mobl.amr.corp.intel.com ([10.251.18.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 16:40:22 -0800
Date: Thu, 16 Dec 2021 16:40:22 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash-to: "mptcp: cleanup MPJ subflow list
 handling"
In-Reply-To: <70e15da075bab481ac07ed1ce8c2adc9740403c6.1639665203.git.pabeni@redhat.com>
Message-ID: <b4a3815b-cdb1-9f78-da0-46b0c1472e42@linux.intel.com>
References: <70e15da075bab481ac07ed1ce8c2adc9740403c6.1639665203.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 16 Dec 2021, Paolo Abeni wrote:

> The self-tests in a loop triggered a UaF similar to:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/250
> 
> The critical scenario is actually almost fixed by:
> 
> "mptcp: cleanup MPJ subflow list handling"
> 
> with a notable exception: if an MPJ handshake races with
> mptcp_close(), the subflow enter the join_list and __mptcp_finish_join()
> is processed at the msk socket lock release in mptcp_close(),
> the subflow will preserver a danfling reference to the msk sk_socket.
> 
> Address the issue fragting the subflow only on successful
                     ^^^^^^^^ grafting?

Change looks good to squash, and the tests (other than the one ipv6 issue) 
are ok on my local system.

> __mptcp_finish_join()
> 
> Note that issues/250 triggers even before
> "mptcp: cleanup MPJ subflow list handling", as before such commit the join
> list was not spliced by mptcp_close(). We could consider a net-only patch to
> address that.

Yes, definitely need something for #250 in net.


Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e81fd46a43c4..e89d7741aa7f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -810,9 +810,17 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>
>  static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
>  {
> -	if (((struct sock *)msk)->sk_state != TCP_ESTABLISHED)
> +	struct sock *sk = (struct sock *)msk;
> +
> +	if (sk->sk_state != TCP_ESTABLISHED)
>  		return false;
> 
> +	/* attach to msk socket only after we are sure we will deal with it
> +	 * at close time
> +	 */
> +	if (sk->sk_socket && !ssk->sk_socket)
> +		mptcp_sock_graft(ssk, sk->sk_socket);
> +
>  	mptcp_propagate_sndbuf((struct sock *)msk, ssk);
>  	mptcp_sockopt_sync_locked(msk, ssk);
>  	WRITE_ONCE(msk->allow_infinite_fallback, false);
> @@ -3234,7 +3242,6 @@ bool mptcp_finish_join(struct sock *ssk)
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>  	struct sock *parent = (void *)msk;
> -	struct socket *parent_sock;
>  	bool ret = true;
>
>  	pr_debug("msk=%p, subflow=%p", msk, subflow);
> @@ -3278,13 +3285,6 @@ bool mptcp_finish_join(struct sock *ssk)
>  		return false;
>  	}
> 
> -	/* attach to msk socket only after we are sure he will deal with us
> -	 * at close time
> -	 */
> -	parent_sock = READ_ONCE(parent->sk_socket);
> -	if (parent_sock && !ssk->sk_socket)
> -		mptcp_sock_graft(ssk, parent_sock);
> -
>  	subflow->map_seq = READ_ONCE(msk->ack_seq);
>
>  out:
> -- 
> 2.33.1
> 
> 
>

--
Mat Martineau
Intel
