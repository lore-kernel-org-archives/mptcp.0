Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F117B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 01:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645667048; x=1677203048;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZP7dqKHDYUItSWMHfgfli7T+ae8OToHErI7wJJuO0H4=;
  b=YTuHP21ISZg7NfLpIpaniQeFs0YH8n4WG6wEY5yQ8lMmleYnakj6/+i5
   z9GsnGZUiDtkTAOmhxrFOEsAJG1Hx9AQ6LKSrV+QgUc9XTtD0r94Dxs9s
   LxOjBrG1s0Gf2vaqsPwjvxdYXgn1gpPcPsVvUvt9/w2JsF85AGKqCPSpF
   ogbcPGUSOhK+pLVy8uvnjzr2tw9CtAW22TcODPIZct/4tp7M9ZRjotwTD
   awBuEiOidDwzm0u8RUzskWadyk9YAQapMF+Mq5JQjpVgJW/MJ8QQ7Shbl
   uqw0RtIBF3I48AMs2u7zezTFE9m/Z0McUBC6iiTXYKHyo3vt89UxbKMbv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="338564642"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="338564642"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:44:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508678018"
Received: from ortmgvpn37.amr.corp.intel.com ([10.212.237.95])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:44:07 -0800
Date: Wed, 23 Feb 2022 17:44:07 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC mptcp-next v2 4/6] mptcp: add a new sysctl
 mp_fail_timeout
In-Reply-To: <59946591122d6453baa10bfc3de3badda3bccd47.1645096378.git.geliang.tang@suse.com>
Message-ID: <3653b652-42a9-f83b-d9dc-534d3f6a54@linux.intel.com>
References: <cover.1645096378.git.geliang.tang@suse.com> <59946591122d6453baa10bfc3de3badda3bccd47.1645096378.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 17 Feb 2022, Geliang Tang wrote:

> This patch added a new sysctl, named mp_fail_timeout, to control the
> timeout value (in seconds) of the MP_FAIL retransmission.
>

I'm reluctant to add a sysctl for this - is there a use case other than 
making the selftest run faster? :)

-Mat


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> Documentation/networking/mptcp-sysctl.rst | 10 ++++++++++
> net/mptcp/ctrl.c                          | 14 ++++++++++++++
> net/mptcp/protocol.h                      |  1 +
> 3 files changed, 25 insertions(+)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index e263dfcc4b40..3ad19e04ecce 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -75,3 +75,13 @@ stale_loss_cnt - INTEGER
> 	This is a per-namespace sysctl.
>
> 	Default: 4
> +
> +mp_fail_timeout - INTEGER (seconds)
> +	Set the timeout after which a MP_FAIL control message will be
> +	resent to an MPTCP peer that has not acknowledged a previous
> +	MP_FAIL message.
> +
> +	The default value matches TCP_RTO_MAX. This is a per-namespace
> +	sysctl.
> +
> +	Default: 120
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..a211af9b19e8 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -32,6 +32,7 @@ struct mptcp_pernet {
> 	u8 checksum_enabled;
> 	u8 allow_join_initial_addr_port;
> 	u8 pm_type;
> +	unsigned int mp_fail_timeout;
> };
>
> static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -69,6 +70,11 @@ int mptcp_get_pm_type(const struct net *net)
> 	return mptcp_get_pernet(net)->pm_type;
> }
>
> +unsigned int mptcp_get_mp_fail_timeout(const struct net *net)
> +{
> +	return mptcp_get_pernet(net)->mp_fail_timeout;
> +}
> +
> static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> {
> 	pernet->mptcp_enabled = 1;
> @@ -77,6 +83,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> 	pernet->allow_join_initial_addr_port = 1;
> 	pernet->stale_loss_cnt = 4;
> 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
> +	pernet->mp_fail_timeout = TCP_RTO_MAX;
> }
>
> #ifdef CONFIG_SYSCTL
> @@ -128,6 +135,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
> 		.extra1       = SYSCTL_ZERO,
> 		.extra2       = &mptcp_pm_type_max
> 	},
> +	{
> +		.procname = "mp_fail_timeout",
> +		.maxlen = sizeof(unsigned int),
> +		.mode = 0644,
> +		.proc_handler = proc_dointvec_jiffies,
> +	},
> 	{}
> };
>
> @@ -149,6 +162,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> 	table[3].data = &pernet->allow_join_initial_addr_port;
> 	table[4].data = &pernet->stale_loss_cnt;
> 	table[5].data = &pernet->pm_type;
> +	table[6].data = &pernet->mp_fail_timeout;
>
> 	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> 	if (!hdr)
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3c74b04fba6c..c28842ab0dcc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -583,6 +583,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
> int mptcp_allow_join_id0(const struct net *net);
> unsigned int mptcp_stale_loss_cnt(const struct net *net);
> int mptcp_get_pm_type(const struct net *net);
> +unsigned int mptcp_get_mp_fail_timeout(const struct net *net);
> void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
> 				     struct mptcp_options_received *mp_opt);
> bool __mptcp_retransmit_pending_data(struct sock *sk);
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
