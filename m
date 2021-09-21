Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10172
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 00:05:20 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="245671132"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="245671132"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 17:05:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="473985725"
Received: from nkhakpas-mobl.amr.corp.intel.com ([10.212.134.160])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 17:05:19 -0700
Date: Mon, 20 Sep 2021 17:05:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Tim Gardner <tim.gardner@canonical.com>
cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>, 
    "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mptcp: Avoid NULL dereference in
 mptcp_getsockopt_subflow_addrs()
In-Reply-To: <20210920154232.15494-1-tim.gardner@canonical.com>
Message-ID: <149982aa-720-35be-4866-39259b92884d@linux.intel.com>
References: <20210920154232.15494-1-tim.gardner@canonical.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 20 Sep 2021, Tim Gardner wrote:

> Coverity complains of a possible NULL dereference in
> mptcp_getsockopt_subflow_addrs():
>
> 861        } else if (sk->sk_family == AF_INET6) {
>    	3. returned_null: inet6_sk returns NULL. [show details]
>    	4. var_assigned: Assigning: np = NULL return value from inet6_sk.
> 862                const struct ipv6_pinfo *np = inet6_sk(sk);
>
> Fix this by checking for NULL.
>
> Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Cc: mptcp@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
>
> [ I'm not at all sure this is the right thing to do since the final result is to
> return garbage to user space in mptcp_getsockopt_subflow_addrs(). Is this one
> of those cases where inet6_sk() can't fail ?]

Hi Tim -

Thanks for noticing this and proposing a fix.

As you commented, this isn't the right change to merge since 
mptcp_getsockopt_subflow_addrs() would copy garbage.

This block of code already checks that CONFIG_IPV6 is enabled, so the 
question is whether sk_fullsock() would return false because the subflow 
is in TCP_TIME_WAIT or TCP_NEW_SYN_RECV. The caller is iterating over 
sockets in the MPTCP socket's conn_list, which does not contain 
request_socks (so there are no sockets in the TCP_NEW_SYN_RECV state).

TCP subflow sockets are normally removed from the conn_list before they 
are closed by their parent MPTCP socket, but I need to double-check for 
corner cases. I created a github issue to track this: 
https://github.com/multipath-tcp/mptcp_net-next/issues/231


Thanks,

Mat


> ---
> net/mptcp/sockopt.c | 3 +++
> 1 file changed, 3 insertions(+)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 8137cc3a4296..c89f2bedce79 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -861,6 +861,9 @@ static void mptcp_get_sub_addrs(const struct sock *sk, struct mptcp_subflow_addr
> 	} else if (sk->sk_family == AF_INET6) {
> 		const struct ipv6_pinfo *np = inet6_sk(sk);
>
> +		if (!np)
> +			return;
> +
> 		a->sin6_local.sin6_family = AF_INET6;
> 		a->sin6_local.sin6_port = inet->inet_sport;
>
> -- 
> 2.33.0
>
>

--
Mat Martineau
Intel
