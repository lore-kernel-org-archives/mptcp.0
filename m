Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1C06101
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 23:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665445092; x=1696981092;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=t7SXemiaiJvQ1leG9i7qBdNXDj7+3isFTm8IxCurlMg=;
  b=cP+Uct2HmNBHHNw2IKlcw2bKZNwq4LLGxKsAHUJvSoz/Dpw8dL8jLJnK
   0a1XgxZ51hVwDimATPdBQY7hcWrjCwXmjNcuVc1DFCGow+Ayq82qUsp4c
   WVAxR7mxwv17/RH8F/nItXa+yzGCvakOjkFEJ6D9w34iaD+SHQqkDs7NJ
   3RnTk4T/UQRMj/kll4hpCsozlHeAr+6ialK1B0W+Cx33jCwicCJLR9BE6
   Ys1CMBf45csCBZJey+nuLaFkhQImlPbXl4pIYSNJ8p51g1bBOJluIbsM/
   p/8jzQ+/1SI5pHL4kUZGcpoFPxVfR+50Eza9Wa2TSW5y8vPq+ZqDMAZZk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="303100189"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="303100189"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 16:38:12 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="955118712"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="955118712"
Received: from pnle-mobl.amr.corp.intel.com ([10.212.235.19])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 16:38:11 -0700
Date: Mon, 10 Oct 2022 16:38:11 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: set msk local address earlier
In-Reply-To: <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
Message-ID: <3978422b-52e0-8a1d-e424-541d6ab5c229@linux.intel.com>
References: <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Oct 2022, Paolo Abeni wrote:

> The mptcp_pm_nl_get_local_id() code assumes that the msk local address
> is available at that point. For passive sockets, we initialize such
> address at accept() time.
>
> Depending on the running configuration and the user-space timing, a
> passive MPJ subflow can join the msk socket before accept() completes.
>
> In such case, the PM assigns a wrong local id to the MPJ subflow
> and later PM netlink operations will end-up touching the wrong/unexpected
> subflow.
>
> All the above causes sporadic self-tests failures, especially when
> the host is heavy loaded.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/308
> Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
> Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This has a minor conflict in protocol.h when trying to apply to 
export-net, but it's easy to resolve (mptcp_get_scheduler is in export 
but not export-net).

I ran in to one failure in a test that wasn't mentioned in #308 the first 
time I tried running "mptcp_join.sh -rp" but couldn't reproduce it:

010 flush addresses                      syn[fail] got 2 JOIN[s] syn expected 3
  - synack[fail] got 2 JOIN[s] synack expected 3
  - ack[fail] got 2 JOIN[s] ack expected 3
                                          add[ ok ] - echo  [fail] got 2 ADD_ADDR echo[s] expected 3
                                          rm [fail] got 2 RM_ADDR[s] expected 3
  - rmsf  [fail] got 2 RM_SUBFLOW[s] expected in range [3:6]

but I don't think that's related? (Let me know if the MIB list is useful, 
I saved that too)

Code changes look good to me, seems like it's worth trying in the 
export-net branch so we can test it with the CI builds:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>



> ---
> net/mptcp/protocol.c | 3 +--
> net/mptcp/protocol.h | 1 +
> net/mptcp/subflow.c  | 7 +++++++
> 3 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1aa940928b4f..d34765db0700 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2951,7 +2951,7 @@ static void mptcp_close(struct sock *sk, long timeout)
> 	sock_put(sk);
> }
>
> -static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> +void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> {
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> 	const struct ipv6_pinfo *ssk6 = inet6_sk(ssk);
> @@ -3702,7 +3702,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 		if (mptcp_is_fully_established(newsk))
> 			mptcp_pm_fully_established(msk, msk->first, GFP_KERNEL);
>
> -		mptcp_copy_inaddrs(newsk, msk->first);
> 		mptcp_rcv_space_init(msk, msk->first);
> 		mptcp_propagate_sndbuf(newsk, msk->first);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 18f866b1afda..2358a4083eb3 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -604,6 +604,7 @@ int mptcp_allow_join_id0(const struct net *net);
> unsigned int mptcp_stale_loss_cnt(const struct net *net);
> int mptcp_get_pm_type(const struct net *net);
> const char *mptcp_get_scheduler(const struct net *net);
> +void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
> 				     struct mptcp_options_received *mp_opt);
> bool __mptcp_retransmit_pending_data(struct sock *sk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 07dd23d0fe04..05a2b054287a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -723,6 +723,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 				goto dispose_child;
> 			}
>
> +			if (new_msk)
> +				mptcp_copy_inaddrs(new_msk, child);
> 			subflow_drop_ctx(child);
> 			goto out;
> 		}
> @@ -750,6 +752,11 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 			ctx->conn = new_msk;
> 			new_msk = NULL;
>
> +			/* set msk addresse early to ensure mptcp_pm_get_local_id()
> +			 * uses the correct data
> +			 */
> +			mptcp_copy_inaddrs(ctx->conn, child);
> +
> 			/* with OoO packets we can reach here without ingress
> 			 * mpc option
> 			 */
> -- 
> 2.37.3
>
>
>

--
Mat Martineau
Intel
