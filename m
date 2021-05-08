Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9655172
	for <mptcp@lists.linux.dev>; Sat,  8 May 2021 00:19:12 +0000 (UTC)
IronPort-SDR: es04MAJqO+CXA0dqnjue0JUa+MyO5cUKRHR5mWljODOgIGRUKwtwbD5bE9IJSXUTt/JUf3fD2q
 YK4cYzzlftsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="198920087"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="198920087"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:19:11 -0700
IronPort-SDR: sLXmtjBhYKjV47DoKrkdN7Xh6fYLQZDIdIAqG7XdHPZVxTtMSKZfff5dr/SderYG8023pjKgCS
 pDeSPQWWpm8g==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431726819"
Received: from magalleg-mobl.amr.corp.intel.com ([10.209.84.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 17:19:10 -0700
Date: Fri, 7 May 2021 17:19:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>
Subject: Re: [MPTCP][PATCH v4 mptcp-next 1/4] mptcp: add sysctl
 allow_join_initial_addr_port
In-Reply-To: <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com>
Message-ID: <366f1e0-5c33-b52f-559-cf2d4c74ab8@linux.intel.com>
References: <cover.1620275759.git.geliangtang@gmail.com> <025c3e92286c1c425b6ce65b4feac7e416947e54.1620275759.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 6 May 2021, Geliang Tang wrote:

> This patch added a new sysctl, named allow_join_initial_addr_port, to
> control whether allow peers to send join requests to the IP address and
> port number used by the initial subflow.
>
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> Documentation/networking/mptcp-sysctl.rst | 13 +++++++++++++
> net/mptcp/ctrl.c                          | 16 ++++++++++++++++
> net/mptcp/protocol.h                      |  1 +
> 3 files changed, 30 insertions(+)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index ee06fd782465..76d939e688b8 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -32,3 +32,16 @@ checksum_enabled - BOOLEAN
> 	per-namespace sysctl.
>
> 	Default: 0
> +
> +allow_join_initial_addr_port - BOOLEAN
> +	Allow peers to send join requests to the IP address and port number used
> +	by the initial subflow if the value is 1. This controls a flag that is
> +	sent to the peer at connection time, and whether such join requests are
> +	accepted or denied.
> +
> +	Joins to addresses advertised with ADD_ADDR are not affected by this
> +	value.
> +
> +	This is a per-namespace sysctl.
> +
> +	Default: 1
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index b5ff77dae503..786055b0c6eb 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -24,6 +24,7 @@ struct mptcp_pernet {
> 	u8 mptcp_enabled;
> 	unsigned int add_addr_timeout;
> 	u8 checksum_enabled;
> +	u8 allow_join_initial_addr_port;
> };
>
> static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> @@ -46,6 +47,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> 	pernet->mptcp_enabled = 1;
> 	pernet->add_addr_timeout = TCP_RTO_MAX;
> 	pernet->checksum_enabled = 0;
> +	pernet->allow_join_initial_addr_port = 1;
> }
>
> #ifdef CONFIG_SYSCTL
> @@ -54,6 +56,11 @@ int mptcp_is_checksum_enabled(struct net *net)
> 	return mptcp_get_pernet(net)->checksum_enabled;
> }
>
> +int mptcp_allow_join_id0(struct net *net)
> +{
> +	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
> +}
> +

This function needs an alternate version after the #else (suggest that it 
always returns 1), so the build doesn't break in the !CONFIG_SYSCTL case.

-Mat


> static struct ctl_table mptcp_sysctl_table[] = {
> 	{
> 		.procname = "enabled",
> @@ -80,6 +87,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
> 		.extra1       = SYSCTL_ZERO,
> 		.extra2       = SYSCTL_ONE
> 	},
> +	{
> +		.procname = "allow_join_initial_addr_port",
> +		.maxlen = sizeof(u8),
> +		.mode = 0644,
> +		.proc_handler = proc_dou8vec_minmax,
> +		.extra1       = SYSCTL_ZERO,
> +		.extra2       = SYSCTL_ONE
> +	},
> 	{}
> };
>
> @@ -98,6 +113,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> 	table[0].data = &pernet->mptcp_enabled;
> 	table[1].data = &pernet->add_addr_timeout;
> 	table[2].data = &pernet->checksum_enabled;
> +	table[3].data = &pernet->allow_join_initial_addr_port;
>
> 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> 	if (!hdr)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 98c735f237b4..17ce5639665a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -542,6 +542,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
> int mptcp_is_enabled(struct net *net);
> unsigned int mptcp_get_add_addr_timeout(struct net *net);
> int mptcp_is_checksum_enabled(struct net *net);
> +int mptcp_allow_join_id0(struct net *net);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
> 				     struct mptcp_options_received *mp_opt);
> bool mptcp_subflow_data_available(struct sock *sk);
> -- 
> 2.31.1

--
Mat Martineau
Intel
