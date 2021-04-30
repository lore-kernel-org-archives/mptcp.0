Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBB71
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 01:28:23 +0000 (UTC)
IronPort-SDR: Rd7l4ZAPB2rvW2EilIQTm335wp3IBi+x/XJsewNz9fpcYbnoW4JntKmWqnFPbeL9/9Pe3pmjBv
 zJF/xAU5DcZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="217903181"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="217903181"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:28:22 -0700
IronPort-SDR: uk+VxhsVnaGYWfQgf24b17FYGBxPlksyaAghNWNZk7FLxpbbueiJMbAODxVcM9wiwZCJS/n3PR
 zOE6F/xtJ8XA==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404388957"
Received: from rbidari-mobl1.amr.corp.intel.com ([10.254.72.16])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 18:28:20 -0700
Date: Thu, 29 Apr 2021 18:28:20 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 1/4] mptcp: add sysctl
 allow_join_initial_addr_port
In-Reply-To: <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com>
Message-ID: <b9e319a8-2935-c999-7d99-2f53f1c2e6@linux.intel.com>
References: <cover.1619623735.git.geliangtang@gmail.com> <952b920c38ab98adfdb77a0e941ff43c05461a0d.1619623735.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 28 Apr 2021, Geliang Tang wrote:

> This patch added a new sysctl, named allow_join_initial_addr_port, to
> control whether allow peers to send join requests to the IP address and
> port number used by the initial subflow.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> Documentation/networking/mptcp-sysctl.rst | 13 +++++++++++++
> net/mptcp/ctrl.c                          | 16 ++++++++++++++++
> net/mptcp/protocol.h                      |  1 +
> 3 files changed, 30 insertions(+)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 3b352e5f6300..6c67ea3d0b7f 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -24,3 +24,16 @@ add_addr_timeout - INTEGER (seconds)
> 	sysctl.
>
> 	Default: 120
> +
> +allow_join_initial_addr_port - INTEGER
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
> index 08c152199b89..5c520fcdf93d 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -19,6 +19,7 @@ struct mptcp_pernet {
>
> 	u8 mptcp_enabled;
> 	unsigned int add_addr_timeout;
> +	u8 allow_join_initial_addr_port;
> };
>
> static struct mptcp_pernet *mptcp_get_pernet(struct net *net)
> @@ -36,6 +37,11 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
> 	return mptcp_get_pernet(net)->add_addr_timeout;
> }
>
> +int mptcp_is_allow_join_id0(struct net *net)

I suggest "mptcp_allow_join_id0(struct net *net)"


Thanks,
Mat

> +{
> +	return mptcp_get_pernet(net)->allow_join_initial_addr_port;
> +}
> +
> static struct ctl_table mptcp_sysctl_table[] = {
> 	{
> 		.procname = "enabled",
> @@ -54,6 +60,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
> 		.mode = 0644,
> 		.proc_handler = proc_dointvec_jiffies,
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
> @@ -61,6 +75,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> {
> 	pernet->mptcp_enabled = 1;
> 	pernet->add_addr_timeout = TCP_RTO_MAX;
> +	pernet->allow_join_initial_addr_port = 1;
> }
>
> static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> @@ -77,6 +92,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>
> 	table[0].data = &pernet->mptcp_enabled;
> 	table[1].data = &pernet->add_addr_timeout;
> +	table[2].data = &pernet->allow_join_initial_addr_port;
>
> 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> 	if (!hdr)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d230a75af631..bb901435c2d4 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -524,6 +524,7 @@ static inline void mptcp_subflow_delegated_done(struct mptcp_subflow_context *su
>
> int mptcp_is_enabled(struct net *net);
> unsigned int mptcp_get_add_addr_timeout(struct net *net);
> +int mptcp_is_allow_join_id0(struct net *net);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
> 				     struct mptcp_options_received *mp_opt);
> bool mptcp_subflow_data_available(struct sock *sk);
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
