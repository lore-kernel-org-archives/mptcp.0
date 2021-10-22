Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD802C98
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 23:50:00 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="229276619"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="229276619"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 16:50:00 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="464217738"
Received: from gmonroy-mobl3.amr.corp.intel.com ([10.254.64.84])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 16:50:00 -0700
Date: Fri, 22 Oct 2021 16:49:59 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Poorva Sonparote <psonparo@redhat.com>
cc: mptcp@lists.linux.dev, dcaratti@redhat.com
Subject: Re: [PATCH RFC] Support for SOL_IP for MPTCP setsockopt
In-Reply-To: <0c05b2c0bfb6cd5b6788d00c7f61474d0cd5a747.1634749192.git.psonparo@redhat.com>
Message-ID: <f424e68a-7332-531e-9fe6-ef5fcbaddfd5@linux.intel.com>
References: <0c05b2c0bfb6cd5b6788d00c7f61474d0cd5a747.1634749192.git.psonparo@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 20 Oct 2021, Poorva Sonparote wrote:

> Hello!
>
> I have been working on adding support for IP_TOS for setsockopt(). I
> am attaching the packetdrill test and the patch but it  still won't set the TOS value
> for the subflows that are created after the setsockopt() call.
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/220#issuecomment-947863717
>
> Thanks,
> Poorva
>
>
>
>
> This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
> https://github.com/multipath-tcp/mptcp_net-next/issues/220
>
> Currently, any new subflows that are created after the setsockopt()
> call are not being updated with the set IP_TOS value.
>

Hi Poorva,

Thanks for the patch!


A 'Closes:' tag with the github issue link is also helpful here.

> Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
> ---
> net/mptcp/sockopt.c | 39 ++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 38 insertions(+), 1 deletion(-)
>

If you have more commentary that isn't part of the commit message you want 
to be permanently stored in git, this space (after the '---' line above 
but before the 'diff --git ...' below) is a good for that! 'git am' will 
drop this text when applying. This is especially not a big deal with RFC 
patches like this one, since they don't end up getting merged anyway.


> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 8137cc3a4296..f5ee49660902 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -598,6 +598,40 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
> 	return ret;
> }
>
> +static int mptcp_setsockopt_sol_ip_set_tos(struct mptcp_sock *msk, int optname,
> +					   sockptr_t optval, unsigned int optlen)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	int ret, err;
> +	int val = 0;
> +
> +	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
> +	val = inet_sk(sk)->tos;
> +
> +	if (err != 0)
> +		return err;

Minor - need a blank line here.

> +	lock_sock(sk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +
> +		ip_sock_set_tos(ssk, val);
> +	}
> +	release_sock(sk);

and here

> +	return ret;
> +}
> +
> +static int mptcp_setsockopt_sol_ip(struct mptcp_sock *msk, int optname,
> +				   sockptr_t optval, unsigned int optlen)
> +{
> +	switch (optname) {
> +	case IP_TOS:
> +		return  mptcp_setsockopt_sol_ip_set_tos(msk, optname, optval, optlen);
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
> 				    sockptr_t optval, unsigned int optlen)
> {
> @@ -637,12 +671,14 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
> 	if (ssk)
> 		return tcp_setsockopt(ssk, level, optname, optval, optlen);
>
> +	if (level == SOL_IP)
> +		return mptcp_setsockopt_sol_ip(msk, optname, optval, optlen);
> +
> 	if (level == SOL_IPV6)
> 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
>
> 	if (level == SOL_TCP)
> 		return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
> -

Looks like an accidental line deletion here.

> 	return -EOPNOTSUPP;
> }
>
> @@ -1000,6 +1036,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> 	ssk->sk_priority = sk->sk_priority;
> 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
> +	ip_sock_set_tos(ssk, inet_sk(sk)->tos);

I think this does sync the tos value to new subflows, right? Since the ssk 
is already locked, use __ip_sock_set_tos(). Maybe you ran in to a deadlock 
here that interfered with the syncing.

>
> 	if (sk->sk_userlocks & tx_rx_locks) {
> 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
> -- 
> 2.18.2
>
>
>

--
Mat Martineau
Intel
